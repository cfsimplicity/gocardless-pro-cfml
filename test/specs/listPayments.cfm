<cfscript>
describe( "listPayments()",function(){

	beforeEach( function(){
		variables.listPayments = gc.payments().list();
		prepareMock( listPayments );
		listPayments.$( method="sendHttpRequest",returns=mock.emptyResponse() );
	});

	
	it( "generates the correct http attributes", function(){
		var result = listPayments.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payments" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "generates the correct url parameters", function(){
		var result = listPayments
			.withCustomer( "CU123")
			.withMandate( "MD123" )
			.withStatus( "submitted" )
			.withSubscription( "SB123" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payments?customer=CU123&mandate=MD123&status=submitted&subscription=SB123" );
	});

	it( "throws an exception if both customer and creditor parameters are supplied",function(){
		expect( function(){
			var result = listPayments
				.withCreditor( "MD123" )
				.withCustomer( "CU123")
				.execute();
		}).toThrow( type="GoCardlessClientException.InvalidParameter" );
	});

});
</cfscript>