<cfscript>
describe( "getCustomer()",function(){

	beforeEach( function(){
		variables.getCustomer = gc.customers().get( "CU123" );
		prepareMock( getCustomer );
		getCustomer.$( method="sendHttpRequest",returns=mock.successfulCustomerRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = getCustomer.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/customers/CU123" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "returns the customer resource on success", function(){
		var result = getCustomer.execute();
		var customer = result.resource;
		expect( customer.id ).toBe( "CU123" );
	});

});
</cfscript>