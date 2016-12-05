component accessors="true" extends="baseGetRequest"{
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setResourceEnvelopeName( "customers" );
		this.setEndPoint( "customers/" & this.getId() );
		this.setApiDocsLink( this.getApiDocsLink() & "##customers-get-a-single-customer" );
		return this;
	}

}