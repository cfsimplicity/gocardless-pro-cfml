component accessors="true" extends="baseListRequest"{

	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "GET" );
		this.setEndPoint( "events" );
		this.setApiDocsLink( this.getApiDocsLink() & "##events-list-events" );
		return this;
	}

	function withAction( required string value ){
		super.addUrlParameter( "action", value );
		return this;
	}

	function withInclude( required string value ){
		super.addUrlParameter( "include", value );
		return this;
	}

	function withMandate( required string value ){
		checkIfResourceTypePresent();
		super.addUrlParameter( "mandate", value );
		return this;
	}

	function withParentEvent( required string value ){
		super.addUrlParameter( "parent_event", value );
		return this;
	}

	function withPayment( required string value ){
		checkIfResourceTypePresent();
		super.addUrlParameter( "payment", value );
		return this;
	}

	function withPayout( required string value ){
		checkIfResourceTypePresent();
		super.addUrlParameter( "payout", value );
		return this;
	}

	function withRefund( required string value ){
		checkIfResourceTypePresent();
		super.addUrlParameter( "refund", value );
		return this;
	}

	function withResourceType( required string value ){
		if( 
				StructKeyExists( this.getUrlParameters(), "mandate" )
				OR StructKeyExists( this.getUrlParameters(), "payment" )
				OR StructKeyExists( this.getUrlParameters(), "payout" )
				OR StructKeyExists( this.getUrlParameters(), "refund" )
				OR StructKeyExists( this.getUrlParameters(), "subscription" )
		)
			throwMutuallyExclusiveException();
		super.addUrlParameter( "resource_type", value );
		return this;
	}

	function withSubscription( required string value ){
		checkIfResourceTypePresent();
		super.addUrlParameter( "subscription", value );
		return this;
	}

	private void function checkIfResourceTypePresent(){
		if( StructKeyExists( this.getUrlParameters(), "resource_type" ) )
			throwMutuallyExclusiveException();
	}

	private void function throwMutuallyExclusiveException(){
		throw( type="GoCardlessClientException.InvalidParameter", message="You cannot use the 'resource_type' parameter together with the 'mandate', 'payment', 'payout', 'refund' or 'subscription' parameters", detail=". See #this.getApiDocsLink()#" );
	}

}