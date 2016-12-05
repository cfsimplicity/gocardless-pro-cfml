<cfscript>
describe( "getSubscription()",function(){

	beforeEach( function(){
		variables.getSubscription = gc.subscriptions().get( "SB123" );
		prepareMock( getSubscription );
		getSubscription.$( method="sendHttpRequest",returns=mock.successfulSubscriptionRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = getSubscription.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/subscriptions/SB123" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "returns the subscription resource on success", function(){
		var result = getSubscription.execute();
		var subscription = result.resource;
		expect( subscription.id ).toBe( "SB123" );
		expect( subscription.links.mandate ).toBe( "MD123" );
	});

});
</cfscript>