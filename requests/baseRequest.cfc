component accessors="true"{

	property name="apiDocsLink" default="https://developer.gocardless.com/api-reference/";
	property name="body";
	property name="bodyJson";
	property name="endPoint";
	property name="httpMethod";
	property name="idemPotencyKey";
	property name="metadata" type="struct"; /* Key-value store of custom data. Up to 3 keys are permitted, with key names up to 50 characters and values up to 500 characters. */

	function init( required struct instanceVariables ){
		variables.instance = instanceVariables;
		return this;
	}

	boolean function has( required string propertyName ){
		if( !StructKeyExists( variables, propertyName ) OR IsNull( variables[ propertyName ] ) )
			return false;
		var value = variables[ propertyName ];
		if( IsSimpleValue( value ) )
			return ( Len( value ) GT 0 );
		if( IsStruct( value ) )
			return !StructIsEmpty( value );
		return false;
	}

	void function setStringValue( required string property, required string value ){
		/* Deal with ACF's tendency to convert number strings to unquoted numbers when serialised to JSON */
		if( instance.engineIsColdFusion AND IsNumeric( value ) ) 
			value = Chr( 2 ) & value;
		variables[ property ] = value;
	}
	
	void function validateMetaData( required struct metadata ){
		if( StructCount( metadata )  GT 3 )
			throw( type="GoCardlessClientException.InvalidParameter", message="Invalid 'metadata' parameter", detail="The 'metadata' parameter can have no more than three keys. See #this.getApiDocsLink()#" );
		for( var key in metadata ){
			if( Len( key ) GT 50 ){
				throw( type="GoCardlessClientException.InvalidParameter", message="Invalid 'metadata' parameter", detail="The '#key#' key is longer than the maxiumum 50 characters allowed. See #this.getApiDocsLink()#" );
			}
			if( Len( metadata[ key ] ) GT 500 )
				throw( type="GoCardlessClientException.InvalidParameter", message="Invalid 'metadata' parameter", detail="The value of '#key#' is longer than the maxiumum 500 characters allowed. See #this.getApiDocsLink()#" );
		}
	}

	void function validateAmount( required string parameterName, required string value ){
		if( !IsNumeric( value ) OR !IsValid( "integer", value ) )
			throw( type="GoCardlessClientException.InvalidParameter", message="Invalid '#parameterName#' parameter", detail="You must provide the figure in whole pence/cents. See #this.getApiDocsLink()#" );
	}

	void function validateCurrency( required string parameterName, required string value ){
		if( !REFind( "^(?:GBP|EUR|SEK)$", value ) )
			throw( type="GoCardlessClientException.InvalidParameter", message="Invalid '#parameterName#' parameter", detail="Possible values are GBP, EUR or SEK. See #this.getApiDocsLink()#" );
	}

	void function validateDateFormat( required string parameterName, required string value ){
		if( !REFind( "^\d{4,4}-\d{2,2}-\d{2,2}$", value ) )
			throw( type="GoCardlessClientException.InvalidParameter", message="Invalid '#parameterName#' parameter", detail="You must use the format 'yyyy-mm-dd'. See #this.getApiDocsLink()#" );
	}

	void function validateStringLength( required string parameterName, required string value, required numeric limit ){
		if( Len( value )  GT limit )
			throw( type="GoCardlessClientException.InvalidParameter", message="Invalid '#parameterName#' parameter", detail="The '#parameterName#' parameter cannot be more than #limit# characters long. See #this.getApiDocsLink()#" );
	}

	void function serializeBodyToJson(){
		var json = SerializeJSON( this.getBody() );
		if( instance.engineIsColdFusion )
			json = removeForceQuotedNumberValuesHackCharacter( json );
		this.setBodyJson( json );
	}

	string function removeForceQuotedNumberValuesHackCharacter( required string body ){
		return body.Replace( "\u0002", "", "ALL" );
	}

	string function getRequestUrl(){
		return instance.baseGoCardlessUrl & this.getEndPoint();
	}

	struct function makeApiRequest(){
		try{
			var httpResponse = doApiHttpCall();
		}
		catch( any exception ){
			result.error = "Exception while making API request: #exception.message#";
			rethrow;
		}
		/* Return a result containing the input params and response */
		var result = {
			requestUrl: this.getRequestUrl()
			,requestMethod: this.getHttpMethod()
			,httpResponse: httpResponse
			,bodyReceived: Trim( ToString( httpResponse.fileContent ) )
			,data: IsJson( httpResponse.fileContent )? DeserializeJSON( httpResponse.fileContent ): {}
		};
		if( this.has( "body" ) )
			result.requestBody = this.getBodyJson();
		if( this.has( "idemPotencyKey" ) )
			result.idemPotencyKey = this.getIdemPotencyKey();
		return result;
	}

	struct function doApiHttpCall(){
		var http = New http();
	  http.setUrl( this.getRequestUrl() );
	  http.setMethod( this.getHttpMethod() );
	  http.setCharset( "utf-8" );
	  http.addParam( type="header",name="Accept",value="application/json" );
	  http.addParam( type="header",name="Authorization",value="Bearer #instance.access_token#" );//"Bearer" is case sensitive
	  http.addParam( type="header",name="GoCardless-Version",value="#instance.goCardlessApiVersion#" );
	  if( this.has( "body" ) ){
	  	http.addParam( type="header",name="Content-Type",value="application/json" );
	  	http.addParam( type="body",value=this.getBodyJson() );
	  }
	  if( this.has( "idemPotencyKey" ) )
	  	http.addParam( type="header",name="Idempotency-Key",value="#this.getIdemPotencyKey()#" );
		return sendHttpRequest( http );
	}

	/* Separate to make testing (mocking) easier */
	struct function sendHttpRequest( required httpObject ){
		return httpObject.send().getPrefix();
	}

	void function ensureJsonKeyValueIsQuoted( required string key ){
		var result = REReplaceNoCase( this.getBodyJson(), '"#key#":([^",}]+)([,}])', '"#key#":"\1"\2', "all" );
		this.setBodyJson( result );
	}

	void function handleGoCardlessError( required struct result ){
		result.requestSucceeded = false;
		result.error = "Response error from GoCardless: " & result.httpResponse.statuscode;
		if( IsNull( result.data.error.message ) )
			return;
		result.error &= ". #result.data.error.message#. See the returned 'data.error' for more details.";
	}

}