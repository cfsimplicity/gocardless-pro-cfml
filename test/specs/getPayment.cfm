<cfscript>
describe( "getPayment()",function(){

	beforeEach( function(){
		variables.getPayment = gc.payments().get( "PM123" );
		prepareMock( getPayment );
		getPayment.$( method="sendHttpRequest",returns=mock.successfulPaymentRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = getPayment.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payments/PM123" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "returns the payment resource on success", function(){
		var result = getPayment.execute();
		var payment = result.resource;
		expect( payment.id ).toBe( "PM123" );
		expect( payment.links.creditor ).toBe( "CR123" );
	});

});
</cfscript>