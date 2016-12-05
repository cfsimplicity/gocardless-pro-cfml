<cfscript>
describe( "getPayout()",function(){

	beforeEach( function(){
		variables.getPayout = gc.payouts().get( "PO123" );
		prepareMock( getPayout );
		getPayout.$( method="sendHttpRequest",returns=mock.successfulPayoutRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = getPayout.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payouts/PO123" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "returns the payout resource on success", function(){
		var result = getPayout.execute();
		var payout = result.resource;
		expect( payout.id ).toBe( "PO123" );
		expect( payout.links.creditor ).toBe( "CR123" );
	});

});
</cfscript>