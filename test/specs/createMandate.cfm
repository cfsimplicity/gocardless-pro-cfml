<cfscript>
describe( "createMandate()",function(){

	beforeEach( function(){
		variables.createMandate = gc.mandates().create();
		prepareMock( createMandate );
		createMandate.$( method="sendHttpRequest",returns=mock.successfulMandateRequest( 201 ) );
	});

	it( "generates the correct http attributes and json body", function(){
		var result = createMandate
			.withCreditor( "CR123" )
			.withCustomerBankAccount( "BA123" )
			.withIdemPotencyKey( 123 )
			.withMetadata( { contract: "ABCD1234" } )
			.withReference( "REF-123" )
			.withScheme( "bacs" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/mandates" );
		expect( result.requestMethod ).toBe( "POST" );
		expect( result.idemPotencyKey ).toBe( 123 );
		expect( result.requestBody ).toInclude( '"creditor":"CR123"' );
		expect( result.requestBody ).toInclude( '"customer_bank_account":"BA123"' );
		expect( result.requestBody ).toInclude( '"metadata":{"contract":"ABCD1234"}' );
		expect( result.requestBody ).toInclude( '"reference":"REF-123"' );
		expect( result.requestBody ).toInclude( '"scheme":"bacs"' );
	});

	it( "returns the mandate resource on success", function(){
		var result = createMandate.withCustomerBankAccount( "BA123" ).execute();
		expect( result ).toHaveKey( "resource" );
	});

	it( "adds an error key to the result if creation is not successful", function(){
		createMandate.$( method="sendHttpRequest",returns=mock.failedHttpResponse() );
		var result = createMandate.withCustomerBankAccount( "BA123" ).execute();
		expect( result ).toHaveKey( "error" );
	});

	it( "Throws an exception if required parameters are missing",function() {
		expect( function(){
			var result = createMandate.execute();
		}).toThrow( type="GoCardlessClientException.MissingRequiredParameter" );
	});

});
</cfscript>