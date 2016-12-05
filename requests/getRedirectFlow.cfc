component accessors="true" extends="baseGetRequest"{
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setResourceEnvelopeName( "redirect_flows" );
		this.setEndPoint( "redirect_flows/" & this.getId() );
		this.setApiDocsLink( this.getApiDocsLink() & "##redirect-flows-get-a-single-redirect-flow" );
		return this;
	}

}