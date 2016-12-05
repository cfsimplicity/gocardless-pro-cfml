component accessors="true" extends="baseRequest"{

	property name="urlParameters" type="struct";

	function init(){
		super.init( argumentCollection=arguments );
		variables.urlParameters = {};
		return this;
	}

	void function addUrlParameter( required string key, required value ){
		variables.urlParameters[ key ] = value;
	}

	function withAfter( required string id ){
		addUrlParameter( "after", id );
		return this;
	}

	function withBefore( required string id ){
		addUrlParameter( "before", id );
		return this;
	}

	function withCreatedAtGt( required string datetime ){
		addUrlParameter( "created_at[gt]", datetime );
		return this;
	}

	function withCreatedAtGte( required string datetime ){
		addUrlParameter( "created_at[gte]", datetime );
		return this;
	}

	function withCreatedAtLt( required string datetime ){
		addUrlParameter( "created_at[lt]", datetime );
		return this;
	}

	function withCreatedAtLte( required string datetime ){
		addUrlParameter( "created_at[lte]", datetime );
		return this;
	}

	function withLimit( required numeric value ){
		addUrlParameter( "limit", value );
		return this;
	}

	string function getRequestUrl(){
		var baseUrl = super.getRequestUrl();
		if( !this.has( "urlParameters" ) )
			return baseUrl;
		var paramsStruct = this.getUrlParameters();
		var paramsArray = [];
		for( var key in paramsStruct ){
			var value = paramsStruct[ key ];
			ArrayAppend( paramsArray, "#key#=#value#" );
		}
		ArraySort( paramsArray,"textnocase" );//to make testing easier
		var paramsString = ArrayToList( paramsArray, '&' );
		return "#baseUrl#?#paramsString#";
	}

	function execute(){
		var result = super.makeApiRequest();
		if( !Find( "200", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		return result;
	}

}