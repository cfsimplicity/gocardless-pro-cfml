component accessors="true" extends="baseGetRequest"{
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setResourceEnvelopeName( "events" );
		this.setEndPoint( "events/" & this.getId() );
		this.setApiDocsLink( this.getApiDocsLink() & "##events-get-a-single-event" );
		return this;
	}

}