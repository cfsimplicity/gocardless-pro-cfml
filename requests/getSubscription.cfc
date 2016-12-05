component accessors="true" extends="baseGetRequest"{
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setResourceEnvelopeName( "subscriptions" );
		this.setEndPoint( "subscriptions/" & this.getId() );
		this.setApiDocsLink( this.getApiDocsLink() & "##subscriptions-get-a-single-subscription" );
		return this;
	}

}