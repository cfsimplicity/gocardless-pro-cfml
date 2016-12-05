<cfscript>
describe( "updateSubscription()",function(){

	beforeEach( function(){
		variables.updateSubscription = gc.subscriptions().update( "SB123" );
		prepareMock( updateSubscription );
		updateSubscription.$( method="sendHttpRequest",returns=mock.successfulSubscriptionRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = updateSubscription.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/subscriptions/SB123" );
		expect( result.requestMethod ).toBe( "PUT" );
	});

	it( "generates the correct json body", function(){
		var result = updateSubscription
			.withMetaData( { key: "value" } )
			.withName( "new name" )
			.withPaymentReference( "WINEBOX" )
			.execute();
		expect( result.requestBody ).toInclude( '"metadata":{"key":"value"}' );
		expect( result.requestBody ).toInclude( '"key":"value"' );
		expect( result.requestBody ).toInclude( '"name":"new name"' );
		expect( result.requestBody ).toInclude( '"payment_reference":"WINEBOX"' );
	});

	it( "returns the subscription resource on success", function(){
		var result = updateSubscription.withMetaData( { key: "value" } ).execute();
		expect( result ).toHaveKey( "resource" );
	});

	it( "Throws an exception if parameters are invalid",function() {
		expect( function(){
			var tooLong = RepeatString( "a", 256 );
			var result = updateSubscription.withName( tooLong );
		}).toThrow( type="GoCardlessClientException.InvalidParameter" );
	});

});
</cfscript>