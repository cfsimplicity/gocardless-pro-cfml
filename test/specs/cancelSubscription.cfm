<cfscript>
describe( "cancelSubscription()",function(){

	beforeEach( function(){
		variables.successfullyCancelledSubscription = {
			fileContent: '{"subscriptions":{"id":"SB123","created_at":"2014-10-20T17:01:06.000Z","amount":2500,"currency":"GBP","status":"cancelled","name":"Monthly Magazine","start_date":"2014-11-03","end_date":null,"interval":1,"interval_unit":"monthly","day_of_month":1,"month":null,"payment_reference":null,"upcoming_payments":[],"metadata":{"order_no":"ABCD1234"},"links":{"mandate":"MD123"}}}'
			,statuscode: 200
		};
		variables.cancelSubscription = gc.subscriptions().cancel( "SB123" );
		prepareMock( cancelSubscription );
		cancelSubscription.$( method="sendHttpRequest",returns=successfullyCancelledSubscription );
	});

	it( "generates the correct http attributes", function(){
		var result = cancelSubscription.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/subscriptions/SB123/actions/cancel" );
		expect( result.requestMethod ).toBe( "POST" );
	});

	it( "generates the correct json body", function(){
		var result = cancelSubscription.withMetaData( { key: "value" } ).execute();
		expect( result.requestBody ).toInclude( '{"data":{"metadata":' );
		expect( result.requestBody ).toInclude( '"key":"value"' );
	});

	it( "returns the subscription resource on success", function(){
		var result = cancelSubscription.withMetaData( { key: "value" } ).execute();
		expect( result ).toHaveKey( "resource" );
		expect( result.resource.status ).toBe( "cancelled" );
	});

});
</cfscript>