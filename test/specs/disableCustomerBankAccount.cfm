<cfscript>
describe( "disableCustomerBankAccount()",function(){

	beforeEach( function(){
		variables.disableCustomerBankAccount = gc.customerBankAccounts().disable( "BA123" );
		prepareMock( disableCustomerBankAccount );
		disableCustomerBankAccount.$( method="sendHttpRequest",returns=mock.successfulCustomerBankAccountRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = disableCustomerBankAccount.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/customer_bank_accounts/BA123/actions/disable" );
		expect( result.requestMethod ).toBe( "POST" );
	});

});
</cfscript>