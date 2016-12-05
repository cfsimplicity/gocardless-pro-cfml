component accessors="true" extends="baseListRequest"{

	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "GET" );
		this.setEndPoint( "subscriptions" );
		this.setApiDocsLink( this.getApiDocsLink() & "##subscriptions-list-subscriptions" );
		return this;
	}

	function withMandate( required string id ){
		super.addUrlParameter( "mandate", id );
		return this;
	}

	function withCustomer( required string id ){
		super.addUrlParameter( "customer", id );
		return this;
	}

}