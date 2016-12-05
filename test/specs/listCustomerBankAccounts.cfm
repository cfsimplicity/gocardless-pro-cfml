<cfscript>
describe( "listCustomerBankAccounts()",function(){

	beforeEach( function(){
		variables.listCustomerBankAccounts = gc.customerBankAccounts().list();
		prepareMock( listCustomerBankAccounts );
		listCustomerBankAccounts.$( method="sendHttpRequest",returns=mock.emptyResponse() );
	});

	
	it( "generates the correct http attributes", function(){
		var result = listCustomerBankAccounts.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/customer_bank_accounts" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "generates the correct url parameters", function(){
		var result = listCustomerBankAccounts
			.withCustomer( "CU123")
			.withEnabled( "true" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/customer_bank_accounts?customer=CU123&enabled=true" );
	});

});
</cfscript>