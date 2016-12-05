component accessors="true" extends="baseListRequest"{

	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "GET" );
		this.setEndPoint( "payments" );
		this.setApiDocsLink( this.getApiDocsLink() & "##payments-list-payments" );
		return this;
	}

	function withMandate( required string id ){
		super.addUrlParameter( "mandate", id );
		return this;
	}

	function withCustomer( required string id ){
		if( StructKeyExists( this.getUrlParameters(), "creditor" ) )
			throwMutuallyExclusiveException();
		super.addUrlParameter( "customer", id );
		return this;
	}

	function withCreditor( required string id ){
		if( StructKeyExists( this.getUrlParameters(), "customer" ) )
			throwMutuallyExclusiveException();
		super.addUrlParameter( "creditor", id );
		return this;
	}

	function withStatus( required string value ){
		super.addUrlParameter( "status", value );
		return this;
	}

	function withSubscription( required string id ){
		super.addUrlParameter( "subscription", id );
		return this;
	}

	private void function throwMutuallyExclusiveException(){
		throw( type="GoCardlessClientException.InvalidParameter", message="'customer' and 'creditor' parameters mutually exclusive", detail="The 'customer' and 'creditor' parameters cannot both be specified. See #this.getApiDocsLink()#" );
	}

}