component accessors="true" extends="baseListRequest"{

	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "GET" );
		this.setEndPoint( "customers" );
		this.setApiDocsLink( this.getApiDocsLink() & "##customers-list-customers" );
		return this;
	}

}