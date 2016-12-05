<cfscript>
describe( "createRefund()",function(){

	beforeEach( function(){
		variables.createRefund = gc.refunds().create();
		prepareMock( createRefund );
		createRefund.$( method="sendHttpRequest",returns=mock.successfulRefundRequest( 201 ) );
	});

	it( "generates the correct http attributes and json body", function(){
		var result = createRefund
			.withAmount( 100 )
			.withIdemPotencyKey( 123 )
			.withMetadata( { key: "value" } )
			.withPayment( "PM123" )
			.withReference( "REF-123" )
			.withTotalAmountConfirmation( 150 )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/refunds" );
		expect( result.requestMethod ).toBe( "POST" );
		expect( result.idemPotencyKey ).toBe( 123 );
		expect( result.requestBody ).toInclude( '"amount":100' );
		expect( result.requestBody ).toInclude( '"metadata":{"key":"value"}' );
		expect( result.requestBody ).toInclude( '"payment":"PM123"' );
		expect( result.requestBody ).toInclude( '"reference":"REF-123"' );
		expect( result.requestBody ).toInclude( '"total_amount_confirmation":150' );
	});

	it( "returns the refund resource on success", function(){
		var result = createRefund
			.withAmount( 100 )
			.withPayment( "PM123" )
			.withTotalAmountConfirmation( 150 )
			.execute();
		expect( result ).toHaveKey( "resource" );
	});

	it( "adds an error key to the result if creation is not successful", function(){
		createRefund.$( method="sendHttpRequest",returns=mock.failedHttpResponse() );
		var result = createRefund
			.withAmount( 100 )
			.withPayment( "PM123" )
			.withTotalAmountConfirmation( 150 )
			.execute();
		expect( result ).toHaveKey( "error" );
	});

	it( "Throws an exception if required parameters are missing",function() {
		expect( function(){
			var result = createRefund.execute();
		}).toThrow( type="GoCardlessClientException.MissingRequiredParameter" );
	});

});
</cfscript>