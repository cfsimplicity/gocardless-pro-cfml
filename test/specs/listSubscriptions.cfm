<cfscript>
describe( "listSubscriptions()",function(){

	beforeEach( function(){
		variables.listSubscriptions = gc.subscriptions().list();
		prepareMock( listSubscriptions );
		listSubscriptions.$( method="sendHttpRequest",returns=mock.emptyResponse() );
	});

	
	it( "generates the correct http attributes", function(){
		var result = listSubscriptions.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/subscriptions" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "generates the correct url parameters", function(){
		var result = listSubscriptions
			.withCustomer( "CU123")
			.withMandate( "MD123" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/subscriptions?customer=CU123&mandate=MD123" );
	});

});
</cfscript>