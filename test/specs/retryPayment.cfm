<cfscript>
describe( "retryPayment()",function(){

	beforeEach( function(){
		variables.retryPayment = gc.payments().retry( "PM123" );
		prepareMock( retryPayment );
		retryPayment.$( method="sendHttpRequest",returns=mock.successfulPaymentRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = retryPayment.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payments/PM123/actions/retry" );
		expect( result.requestMethod ).toBe( "POST" );
	});

	it( "generates the correct json body", function(){
		var result = retryPayment.withMetaData( { key: "value" } ).execute();
		expect( result.requestBody ).toInclude( '{"data":{"metadata":' );
		expect( result.requestBody ).toInclude( '"key":"value"' );
	});

	it( "returns the payment resource on success", function(){
		var result = retryPayment.withMetaData( { key: "value" } ).execute();
		var payment = result.resource;
		expect( payment.id ).toBe( "PM123" );
	});

});
</cfscript>