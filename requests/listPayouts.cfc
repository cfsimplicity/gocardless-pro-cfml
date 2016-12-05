component accessors="true" extends="baseListRequest"{

	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "GET" );
		this.setEndPoint( "payouts" );
		this.setApiDocsLink( this.getApiDocsLink() & "##payouts-list-payouts" );
		return this;
	}

	function withCreditor( required string id ){
		super.addUrlParameter( "creditor", id );
		return this;
	}

	function withCreditorBankAccount( required string id ){
		super.addUrlParameter( "creditor_bank_account", id );
		return this;
	}

	function withCurrency( required string value ){
		super.validateCurrency( "currency", value );
		super.addUrlParameter( "currency", value );
		return this;
	}

	function withStatus( required string value ){
		super.addUrlParameter( "status", value );
		return this;
	}

}