<cfscript>
describe( "updateRefund()",function(){

	beforeEach( function(){
		variables.updateRefund = gc.refunds().update( "RF123" );
		prepareMock( updateRefund );
		updateRefund.$( method="sendHttpRequest",returns=mock.successfulRefundRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = updateRefund.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/refunds/RF123" );
		expect( result.requestMethod ).toBe( "PUT" );
	});

	it( "generates the correct json body", function(){
		var result = updateRefund.withMetaData( { key: "value" } ).execute();
		expect( result.requestBody ).toInclude( '{"refunds":{"metadata":' );
		expect( result.requestBody ).toInclude( '"key":"value"' );
	});

	it( "returns the refund resource on success", function(){
		var result = updateRefund.withMetaData( { key: "value" } ).execute();
		expect( result ).toHaveKey( "resource" );
	});

});
</cfscript>