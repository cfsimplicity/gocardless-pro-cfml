component accessors="true" extends="baseGetRequest"{
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setResourceEnvelopeName( "refunds" );
		this.setEndPoint( "refunds/" & this.getId() );
		this.setApiDocsLink( this.getApiDocsLink() & "##refunds-get-a-single-refund" );
		return this;
	}

}