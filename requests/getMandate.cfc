component accessors="true" extends="baseGetRequest"{
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setResourceEnvelopeName( "mandates" );
		this.setEndPoint( "mandates/" & this.getId() );
		this.setApiDocsLink( this.getApiDocsLink() & "##mandates-get-a-single-mandate" );
		return this;
	}

}