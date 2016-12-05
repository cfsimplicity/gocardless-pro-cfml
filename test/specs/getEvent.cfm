<cfscript>
describe( "getEvent()",function(){

	beforeEach( function(){
		variables.getEvent = gc.events().get( "PO123" );
		prepareMock( getEvent );
		getEvent.$( method="sendHttpRequest",returns=mock.successfulEventRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = getEvent.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/events/PO123" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "returns the event resource on success", function(){
		var result = getEvent.execute();
		var event = result.resource;
		expect( event.id ).toBe( "EV123" );
		expect( event.links.payment ).toBe( "PM123" );
	});

});
</cfscript>