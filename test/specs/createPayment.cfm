<cfscript>
describe( "createPayment()",function(){

	beforeEach( function(){
		variables.createPayment = gc.payments().create();
		prepareMock( createPayment );
		createPayment.$( method="sendHttpRequest",returns=mock.successfulPaymentRequest( 201 ) );
	});

	it( "generates the correct http attributes and json body", function(){
		var result = createPayment
			.withAmount( 100 )
			.withAppFee( 1 )
			.withChargeDate( "2014-05-21" )
			.withCurrency( "GBP" )
			.withDescription( "Wine" )
			.withIdemPotencyKey( 123 )
			.withMandate( "MD123" )
			.withMetadata( { order_dispatch_date: "2014-05-22" } )
			.withReference( "WINEBOX001" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payments" );
		expect( result.requestMethod ).toBe( "POST" );
		expect( result.idemPotencyKey ).toBe( 123 );
		expect( result.requestBody ).toInclude( '"amount":100' );
		expect( result.requestBody ).toInclude( '"app_fee":1' );
		expect( result.requestBody ).toInclude( '"charge_date":"2014-05-21"' );
		expect( result.requestBody ).toInclude( '"currency":"GBP"' );
		expect( result.requestBody ).toInclude( '"description":"Wine"' );
		expect( result.requestBody ).toInclude( '"reference":"WINEBOX001"' );
		expect( result.requestBody ).toInclude( '"links":{"mandate":"MD123"}' );
		expect( result.requestBody ).toInclude( '"metadata":{"order_dispatch_date":"2014-05-22"}' );
	});

	it( "returns the payment resource on success", function(){
		var result = createPayment
			.withAmount( 100 )
			.withAppFee( 1 )
			.withChargeDate( "2014-05-21" )
			.withCurrency( "GBP" )
			.withDescription( "Wine" )
			.withMandate( "MD123" )
			.withMetadata( { order_dispatch_date: "2014-05-22" } )
			.execute();
		var payment = result.resource;
		expect( payment.id ).toBe( "PM123" );
		expect( payment.amount ).toBe( 100 );
		expect( payment.app_fee ).toBe( 1 );
		expect( payment.charge_date ).toBe( "2014-05-21" );
		expect( payment.currency ).toBe( "GBP" );
		expect( payment.description ).toBe( "Wine" );
		expect( payment.links.mandate ).toBe( "MD123" );
		expect( payment.metadata ).toHaveKey( "order_dispatch_date" );
	});

	it( "adds an error key to the result if creation is not successful", function(){
		createPayment.$( method="sendHttpRequest",returns=mock.failedHttpResponse() );
		var result = createPayment.withAmount( 100 ).withCurrency( "GBP" ).withMandate( "MD123" ).execute();
		expect( result ).toHaveKey( "error" );
	});

	describe( "exceptions",function(){

		it( "Throws an exception if required parameters are missing",function() {
			expect( function(){
				var result = createPayment.execute();
			}).toThrow( type="GoCardlessClientException.MissingRequiredParameter" );
		});

		it( "Throws an exception if parameters are invalid",function() {
			expect( function(){
				var result = createPayment.withAmount( 1.2 );
			}).toThrow( type="GoCardlessClientException.InvalidParameter" );
			expect( function(){
				var result = createPayment.withAppFee( 1.2 );
			}).toThrow( type="GoCardlessClientException.InvalidParameter" );
			expect( function(){
				var result = createPayment.withChargeDate( "20161111" );
			}).toThrow( type="GoCardlessClientException.InvalidParameter" );
			expect( function(){
				var result = createPayment.withCurrency( "USD" );
			}).toThrow( type="GoCardlessClientException.InvalidParameter" );
		});

	});

});
</cfscript>