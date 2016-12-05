component accessors="true" extends="baseRequest"{

	property name="id";
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setId( id );
		this.setEndPoint( "payments/#this.getId()#/actions/retry" );
		this.setHttpMethod( "POST" );
		this.setApiDocsLink( this.getApiDocsLink() & "##payments-retry-a-payment" );
		return this;
	}

	function withMetadata( required struct metadata ){
		super.validateMetadata( metadata );
		this.setMetadata( metadata );
		return this;
	}

	function execute(){
		var body = {};
		if( this.has( "metadata" ) )
			body.data.metadata = this.getMetadata();
		this.setBody( body );
		super.serializeBodyToJson();
		var result = super.makeApiRequest();
		if( !Find( "200", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.payments;
		return result;
	}

}