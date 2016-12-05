component accessors="true" extends="baseRequest"{

	property name="id" required="true";
	property name="sessionToken" required="true";
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setId( id );
		this.setHttpMethod( "POST" );
		this.setEndPoint( "redirect_flows/" & this.getId() & "/actions/complete" );
		this.setApiDocsLink( this.getApiDocsLink() & "##redirect-flows-complete-a-redirect-flow" );
		return this;
	}

	function withSessionToken( required string value ){
		this.setStringValue( "sessionToken", value );
		return this;
	}

	private void function validateRequiredParameters(){
		if( !this.has( "sessionToken" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'sessionToken' parameter", detail="You must provide a session token to identify the user. See #this.getApiDocsLink()#" );
	}

	function execute(){
		validateRequiredParameters();
		var body = {
			data: {
				session_token: this.getSessionToken()
			}
		};
		this.setBody( body );
		super.serializeBodyToJson();
		super.ensureJsonKeyValueIsQuoted( "session_token" );
		var result = super.makeApiRequest();
		if( !Find( "200", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.redirect_flows;
		return result;
	}

}