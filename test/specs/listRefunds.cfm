<cfscript>
describe( "listRefunds()",function(){

	beforeEach( function(){
		variables.listRefunds = gc.refunds().list();
		prepareMock( listRefunds );
		listRefunds.$( method="sendHttpRequest",returns=mock.emptyResponse() );
	});

	
	it( "generates the correct http attributes", function(){
		var result = listRefunds.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/refunds" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "generates the correct url parameters", function(){
		var result = listRefunds
			.withPayment( "PM123" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/refunds?payment=PM123" );
	});

});
</cfscript>