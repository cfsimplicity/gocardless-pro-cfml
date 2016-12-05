<cfscript>
describe( "createCustomerBankAccount()",function(){

	beforeEach( function(){
		variables.createCustomerBankAccount = gc.customerBankAccounts().create();
		prepareMock( createCustomerBankAccount );
		createCustomerBankAccount.$( method="sendHttpRequest",returns=mock.successfulCustomerBankAccountRequest( 201 ) );
	});

	it( "generates the correct http attributes and json body", function(){
		var result = createCustomerBankAccount
			.withAccountHolderName( "Frank Osborne" )
			.withAccountNumber( "55779911" )
			.withBankCode( "19043" )
			.withBranchCode( "200000" )
			.withCountryCode( "GB" )
			.withCurrency( "GBP" )
			.withCustomer( "CU123" )
			.withIban( "GB60 BARC 2000 0055 7799 11" )
			.withMetadata( { key: "value" } )
			.withIdemPotencyKey( 123 )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/customer_bank_accounts" );
		expect( result.requestMethod ).toBe( "POST" );
		expect( result.idemPotencyKey ).toBe( 123 );
		expect( result.requestBody ).toInclude( '"account_holder_name":"Frank Osborne"' );
		expect( result.requestBody ).toInclude( '"bank_code":"19043"' );
		expect( result.requestBody ).toInclude( '"branch_code":"200000"' );
		expect( result.requestBody ).toInclude( '"country_code":"GB"' );
		expect( result.requestBody ).toInclude( '"currency":"GBP"' );
		expect( result.requestBody ).toInclude( '"customer":"CU123"' );
		expect( result.requestBody ).toInclude( '"iban":"GB60 BARC 2000 0055 7799 11"' );
		expect( result.requestBody ).toInclude( '"metadata":{"key":"value"}' );
	});

	it( "returns the customerBankAccount resource on success", function(){
		var result = createCustomerBankAccount
			.withAccountHolderName( "Frank Osborne" )
			.withCurrency( "GBP" )
			.withCustomer( "CU123" )
			.execute();
		expect( result ).toHaveKey( "resource" );
	});

	it( "adds an error key to the result if creation is not successful", function(){
		createCustomerBankAccount.$( method="sendHttpRequest",returns=mock.failedHttpResponse() );
		var result = createCustomerBankAccount
			.withAccountHolderName( "Frank Osborne" )
			.withCurrency( "GBP" )
			.withCustomer( "CU123" )
			.execute();
		expect( result ).toHaveKey( "error" );
	});

	it( "Throws an exception if required parameters are missing",function() {
		expect( function(){
			var result = createCustomerBankAccount.execute();
		}).toThrow( type="GoCardlessClientException.MissingRequiredParameter" );
	});

});
</cfscript>