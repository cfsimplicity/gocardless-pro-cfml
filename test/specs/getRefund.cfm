<cfscript>
describe( "getRefund()",function(){

	beforeEach( function(){
		variables.getRefund = gc.refunds().get( "RF123" );
		prepareMock( getRefund );
		getRefund.$( method="sendHttpRequest",returns=mock.successfulRefundRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = getRefund.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/refunds/RF123" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "returns the refund resource on success", function(){
		var result = getRefund.execute();
		var refund = result.resource;
		expect( refund.id ).toBe( "RF123" );
		expect( refund.links.payment ).toBe( "PM123" );
	});

});
</cfscript>