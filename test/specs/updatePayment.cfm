<cfscript>
describe( "updatePayment()",function(){

	beforeEach( function(){
		variables.updatePayment = gc.payments().update( "PM123" );
		prepareMock( updatePayment );
		updatePayment.$( method="sendHttpRequest",returns=mock.successfulPaymentRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = updatePayment.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payments/PM123" );
		expect( result.requestMethod ).toBe( "PUT" );
	});

	it( "generates the correct json body", function(){
		var result = updatePayment.withMetaData( { key: "value" } ).execute();
		expect( result.requestBody ).toInclude( '{"payments":{"metadata":' );
		expect( result.requestBody ).toInclude( '"key":"value"' );
	});

	it( "returns the payment resource on success", function(){
		var result = updatePayment.withMetaData( { key: "value" } ).execute();
		expect( result ).toHaveKey( "resource" );
	});

});
</cfscript>