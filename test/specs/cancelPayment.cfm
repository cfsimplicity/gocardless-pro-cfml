<cfscript>
describe( "cancelPayment()",function(){

	beforeEach( function(){
		variables.successfullyCancelledPayment = {
			fileContent: '{"payments":{"id":"PM123","created_at":"2014-05-08T17:01:06.000Z","charge_date":"2014-05-21","amount":100,"description":null,"currency":"GBP","status":"cancelled","reference":"WINEBOX001","metadata":{"order_dispatch_date":"2014-05-22"},"amount_refunded":0,"links":{"mandate":"MD123","creditor":"CR123"}}}'
			,statuscode: 200
		};
		variables.cancelPayment = gc.payments().cancel( "PM123" );
		prepareMock( cancelPayment );
		cancelPayment.$( method="sendHttpRequest",returns=successfullyCancelledPayment );
	});

	it( "generates the correct http attributes", function(){
		var result = cancelPayment.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payments/PM123/actions/cancel" );
		expect( result.requestMethod ).toBe( "POST" );
	});

	it( "generates the correct json body", function(){
		var result = cancelPayment.withMetaData( { key: "value" } ).execute();
		expect( result.requestBody ).toInclude( '{"data":{"metadata":' );
		expect( result.requestBody ).toInclude( '"key":"value"' );
	});

	it( "returns the payment resource on success", function(){
		var result = cancelPayment.withMetaData( { key: "value" } ).execute();
		var payment = result.resource;
		expect( payment.id ).toBe( "PM123" );
		expect( payment.status ).toBe( "cancelled" );
	});

});
</cfscript>