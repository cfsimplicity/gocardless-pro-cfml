component accessors="true" extends="baseRequest"{

	property name="id";
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setId( id );
		this.setEndPoint( "customer_bank_accounts/#this.getId()#/actions/disable" );
		this.setHttpMethod( "POST" );
		this.setApiDocsLink( this.getApiDocsLink() & "##customer-bank-accounts-disable-a-customer-bank-account" );
		return this;
	}

	function execute(){
		var result = super.makeApiRequest();
		if( !Find( "200", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.customer_bank_accounts;
		return result;
	}

}