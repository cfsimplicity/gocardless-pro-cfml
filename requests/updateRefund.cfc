component accessors="true" extends="baseRequest"{

	property name="id";
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setId( id );
		this.setEndPoint( "refunds/" & this.getId() );
		this.setHttpMethod( "PUT" );
		this.setApiDocsLink( this.getApiDocsLink() & "##refunds-update-a-refund" );
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
			body.refunds.metadata = this.getMetadata();
		this.setBody( body );
		super.serializeBodyToJson();
		var result = super.makeApiRequest();
		if( !Find( "200", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.refunds;
		return result;
	}

}