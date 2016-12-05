<cfscript>
describe( "listMandates()",function(){

	beforeEach( function(){
		variables.listMandates = gc.mandates().list();
		prepareMock( listMandates );
		listMandates.$( method="sendHttpRequest",returns=mock.emptyResponse() );
	});

	
	it( "generates the correct http attributes", function(){
		var result = listMandates.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/mandates" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "generates the correct url parameters", function(){
		var result = listMandates
			.withCreditor( "CR123")
			.withReference( "REF-123" )
			.withStatus( "submitted" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/mandates?creditor=CR123&reference=REF-123&status=submitted" );
	});

	it( "generates the correct url parameters", function(){
		result = listMandates
			.withCustomer( "CU123" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/mandates?customer=CU123" );
	});

	it( "generates the correct url parameters", function(){
		result = listMandates
			.withCustomerBankAccount( "BA123" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/mandates?customer_bank_account=BA123" );
	});

	it( "throws an exception if customer, customer_bank_account and creditor parameters are combined",function(){
		expect( function(){
			var result = listMandates.withCreditor( "MD123" ).withCustomer( "CU123").execute();
		}).toThrow( type="GoCardlessClientException.InvalidParameter" );
		expect( function(){
			var result = listMandates.withCreditor( "MD123" ).withCustomerBankAccount( "BA123" ).execute();
		}).toThrow( type="GoCardlessClientException.InvalidParameter" );
		expect( function(){
			var result = listMandates.withCustomer( "MD123" ).withCustomerBankAccount( "BA123" ).execute();
		}).toThrow( type="GoCardlessClientException.InvalidParameter" );
	});

});
</cfscript>