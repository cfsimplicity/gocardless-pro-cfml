<cfscript>
describe( "listEvents()",function(){

	beforeEach( function(){
		variables.listEvents = gc.events().list();
		prepareMock( listEvents );
		listEvents.$( method="sendHttpRequest",returns=mock.emptyResponse() );
	});

	
	it( "generates the correct http attributes", function(){
		var result = listEvents.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/events" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "generates the correct url parameters", function(){
		var result = listEvents
			.withAction( "cancelled")
			.withInclude( "subscription")
			.withMandate( "MD123" )
			.withParentEvent( "EV122" )
			.withPayment( "PM123" )
			.withPayout( "PO123" )
			.withRefund( "RF123" )
			.withSubscription( "SB123" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/events?action=cancelled&include=subscription&mandate=MD123&parent_event=EV122&payment=PM123&payout=PO123&refund=RF123&subscription=SB123" );
	});

	it( "generates the correct url parameters", function(){
		var result = listEvents
			.withResourceType( "payments" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/events?resource_type=payments" );
	});

	it( "throws an exception if resource_type and resource parameters are used together",function(){
		expect( function(){
			var result = listEvents
				.withMandate( "MD123" )
				.withResourceType( "mandates")
				.execute();
		}).toThrow( type="GoCardlessClientException.InvalidParameter" );
	});

});
</cfscript>