component accessors="true" extends="baseGetRequest"{
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setResourceEnvelopeName( "payments" );
		this.setEndPoint( "payments/" & this.getId() );
		this.setApiDocsLink( this.getApiDocsLink() & "##payments-get-a-single-payment" );
		return this;
	}

}