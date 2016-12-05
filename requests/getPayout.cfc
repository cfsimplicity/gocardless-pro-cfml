component accessors="true" extends="baseGetRequest"{
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setResourceEnvelopeName( "payouts" );
		this.setEndPoint( "payouts/" & this.getId() );
		this.setApiDocsLink( this.getApiDocsLink() & "##payouts-get-a-single-payout" );
		return this;
	}

}