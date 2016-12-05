<cfscript>
describe( "updateCustomerBankAccount()",function(){

	beforeEach( function(){
		variables.updateCustomerBankAccount = gc.customerBankAccounts().update( "BA123" );
		prepareMock( updateCustomerBankAccount );
		updateCustomerBankAccount.$( method="sendHttpRequest",returns=mock.successfulCustomerBankAccountRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = updateCustomerBankAccount.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/customer_bank_accounts/BA123" );
		expect( result.requestMethod ).toBe( "PUT" );
	});

	it( "generates the correct json body", function(){
		var result = updateCustomerBankAccount.withMetaData( { key: "value" } ).execute();
		expect( result.requestBody ).toInclude( '{"customer_bank_accounts":{"metadata":' );
		expect( result.requestBody ).toInclude( '"key":"value"' );
	});

	it( "returns the payment resource on success", function(){
		var result = updateCustomerBankAccount.withMetaData( { key: "value" } ).execute();
		expect( result ).toHaveKey( "resource" );
	});

});
</cfscript>