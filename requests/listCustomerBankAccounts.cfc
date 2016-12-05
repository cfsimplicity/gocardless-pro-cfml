component accessors="true" extends="baseListRequest"{

	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "GET" );
		this.setEndPoint( "customer_bank_accounts" );
		this.setApiDocsLink( this.getApiDocsLink() & "##customer-bank-accounts-list-customer-bank-accounts" );
		return this;
	}

	function withCustomer( required string id ){
		super.addUrlParameter( "customer", id );
		return this;
	}

	function withEnabled( required boolean value ){
		super.addUrlParameter( "enabled", value );
		return this;
	}

}