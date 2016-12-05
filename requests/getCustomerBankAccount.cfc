component accessors="true" extends="baseGetRequest"{
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setResourceEnvelopeName( "customer_bank_accounts" );
		this.setEndPoint( "customer_bank_accounts/" & this.getId() );
		this.setApiDocsLink( this.getApiDocsLink() & "##customer-bank-accounts-get-a-single-customer-bank-account" );
		return this;
	}

}