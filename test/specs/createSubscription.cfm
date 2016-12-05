<cfscript>
describe( "createSubscription()",function(){

	beforeEach( function(){
		variables.createSubscription = gc.subscriptions().create();
		prepareMock( createSubscription );
		createSubscription.$( method="sendHttpRequest",returns=mock.successfulSubscriptionRequest( 201 ) );
	});

	it( "generates the correct http attributes and json body", function(){
		var result = createSubscription
			.withAmount( 100 )
			.withCount( 4 )
			.withCurrency( "GBP" )
			.withDayOfMonth( 20 )
			.withIdemPotencyKey( 123 )
			.withInterval( 1 )
			.withIntervalUnit( "monthly")
			.withMandate( "MD123" )
			.withMonth( "november" )
			.withMetadata( { key: "value" } )
			.withName( "test" )
			.withPaymentReference( "WINEBOX" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/subscriptions" );
		expect( result.requestMethod ).toBe( "POST" );
		expect( result.idemPotencyKey ).toBe( 123 );
		expect( result.requestBody ).toInclude( '"amount":100' );
		expect( result.requestBody ).toInclude( '"count":4' );
		expect( result.requestBody ).toInclude( '"currency":"GBP"' );
		expect( result.requestBody ).toInclude( '"day_of_month":20' );
		expect( result.requestBody ).toInclude( '"interval":1' );
		expect( result.requestBody ).toInclude( '"interval_unit":"monthly"' );
		expect( result.requestBody ).toInclude( '"links":{"mandate":"MD123"}' );
		expect( result.requestBody ).toInclude( '"metadata":{"key":"value"}' );
		expect( result.requestBody ).toInclude( '"payment_reference":"WINEBOX"' );
		expect( result.requestBody ).toInclude( '"month":"november"' );
		expect( result.requestBody ).toInclude( '"name":"test"' );
	});

	it( "returns the subscription resource on success", function(){
		var result = createSubscription
			.withAmount( 2500 )
			.withCurrency( "GBP" )
			.withIntervalUnit( "monthly")
			.withMandate( "MD123" )
			.execute();
		var subscription = result.resource;
		expect( subscription.id ).toBe( "SB123" );
	});

	it( "adds an error key to the result if creation is not successful", function(){
		createSubscription.$( method="sendHttpRequest",returns=mock.failedHttpResponse() );
		var result = createSubscription
			.withAmount( 100 )
			.withCurrency( "GBP" )
			.withIntervalUnit( "monthly")
			.withMandate( "MD123" )
			.execute();
		expect( result ).toHaveKey( "error" );
	});

	describe( "exceptions",function(){

		it( "Throws an exception if required parameters are missing",function() {
			expect( function(){
				var result = createSubscription.execute();
			}).toThrow( type="GoCardlessClientException.MissingRequiredParameter" );
		});

		it( "Throws an exception if parameters are invalid",function() {
			expect( function(){
				var result = createSubscription.withAmount( 1.2 );
			}).toThrow( type="GoCardlessClientException.InvalidParameter" );
			expect( function(){
				var result = createSubscription.withEndDate( "20161111" );
			}).toThrow( type="GoCardlessClientException.InvalidParameter" );
			expect( function(){
				var result = createSubscription.withCurrency( "USD" );
			}).toThrow( type="GoCardlessClientException.InvalidParameter" );
			expect( function(){
				var tooLong = RepeatString( "a", 256 );
				var result = createSubscription.withName( tooLong );
			}).toThrow( type="GoCardlessClientException.InvalidParameter" );
		});

	});

});
</cfscript>