component accessors="true" extends="baseRequest"{

	property name="id";
	property name="resourceEnvelopeName";
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setId( id );
		this.setHttpMethod( "GET" );
		return this;
	}

	function execute(){
		var result = super.makeApiRequest();
		if( !Find( "200", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data[ this.getResourceEnvelopeName() ];
		return result;
	}

}