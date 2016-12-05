<cfscript>
describe( "getCustomerBankAccount()",function(){

	beforeEach( function(){
		variables.getCustomerBankAccount = gc.customerBankAccounts().get( "BA123" );
		prepareMock( getCustomerBankAccount );
		getCustomerBankAccount.$( method="sendHttpRequest",returns=mock.successfulCustomerBankAccountRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = getCustomerBankAccount.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/customer_bank_accounts/BA123" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "returns the customer bank account resource on success", function(){
		var result = getCustomerBankAccount.execute();
		expect( result ).toHaveKey( "resource" );
	});

});
</cfscript>