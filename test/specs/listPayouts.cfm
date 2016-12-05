<cfscript>
describe( "listPayouts()",function(){

	beforeEach( function(){
		variables.listPayouts = gc.payouts().list();
		prepareMock( listPayouts );
		listPayouts.$( method="sendHttpRequest",returns=mock.emptyResponse() );
	});

	
	it( "generates the correct http attributes", function(){
		var result = listPayouts.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payouts" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "generates the correct url parameters", function(){
		var result = listPayouts
			.withCreditor( "CR123")
			.withCreditorBankAccount( "BA123")
			.withCurrency( "GBP" )
			.withStatus( "pending" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payouts?creditor=CR123&creditor_bank_account=BA123&currency=GBP&status=pending" );
	});

});
</cfscript>