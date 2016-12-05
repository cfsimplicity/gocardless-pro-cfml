component accessors="true" extends="baseListRequest"{

	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "GET" );
		this.setEndPoint( "refunds" );
		this.setApiDocsLink( this.getApiDocsLink() & "##refunds-list-refunds" );
		return this;
	}

	function withPayment( required string id ){
		super.addUrlParameter( "payment", id );
		return this;
	}

}