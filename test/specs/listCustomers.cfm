<cfscript>
describe( "listCustomers()",function(){

	beforeEach( function(){
		variables.listCustomers = gc.customers().list();
		prepareMock( listCustomers );
		listCustomers.$( method="sendHttpRequest",returns=mock.emptyResponse() );
	});

	
	it( "generates the correct http attributes", function(){
		var result = listCustomers.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/customers" );
		expect( result.requestMethod ).toBe( "GET" );
	});

});
</cfscript>