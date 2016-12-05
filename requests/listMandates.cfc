component accessors="true" extends="baseListRequest"{

	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "GET" );
		this.setEndPoint( "mandates" );
		this.setApiDocsLink( this.getApiDocsLink() & "##mandates-list-mandates" );
		return this;
	}

	function withCreditor( required string id ){
		if( StructKeyExists( this.getUrlParameters(), "customer" ) OR StructKeyExists( this.getUrlParameters(), "customer_bank_account" ) )
			throwMutuallyExclusiveException();
		super.addUrlParameter( "creditor", id );
		return this;
	}

	function withCustomer( required string id ){
		if( StructKeyExists( this.getUrlParameters(), "creditor" ) OR StructKeyExists( this.getUrlParameters(), "customer_bank_account" ) )
			throwMutuallyExclusiveException();
		super.addUrlParameter( "customer", id );
		return this;
	}

	function withCustomerBankAccount( required string id ){
		if( StructKeyExists( this.getUrlParameters(), "creditor" ) OR StructKeyExists( this.getUrlParameters(), "customer" ) )
			throwMutuallyExclusiveException();
		super.addUrlParameter( "customer_bank_account", id );
		return this;
	}

	function withMandate( required string id ){
		super.addUrlParameter( "mandate", id );
		return this;
	}

	function withReference( required string value ){
		super.addUrlParameter( "reference", value );
		return this;
	}

	function withStatus( required string value ){
		super.addUrlParameter( "status", value );
		return this;
	}

	private void function throwMutuallyExclusiveException(){
		throw( type="GoCardlessClientException.InvalidParameter", message="'customer', 'customer_bank_account' and 'creditor' parameters mutually exclusive", detail="Only one of 'customer', 'customer_bank_account' and 'creditor' parameters can be specified. See #this.getApiDocsLink()#" );
	}

}