<cfscript>
describe( "list requests",function(){

	beforeEach( function(){
		variables.listPayments = gc.payments().list();
		prepareMock( listPayments );
		listPayments.$( method="sendHttpRequest",returns=mock.emptyResponse() );
	});

	it( "can add pagination parameters to the requst URL", function(){
		var result = listPayments.withBefore( "PM123" ).withAfter( "PM456" ).withLimit( 100 ).execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payments?after=PM456&before=PM123&limit=100" );
	});

	
	it( "concatenates url parameters", function(){
		var result = listPayments.withMandate( "MD123" ).withLimit( 100 ).execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payments?limit=100&mandate=MD123" );
	});

	it( "includes all specified parameters in URL", function(){
		var result = listPayments
			.withCreatedAtGt( "2014-05-08T17:01:06.000Z" )
			.withCreatedAtGte( "2014-05-08T17:01:06.000Z" )
			.withCreatedAtLt( "2014-05-08T17:01:06.000Z" )
			.withCreatedAtLte( "2014-05-08T17:01:06.000Z" )
			.execute();
		//dump( result.requestUrl );
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/payments?created_at[gt]=2014-05-08T17:01:06.000Z&created_at[gte]=2014-05-08T17:01:06.000Z&created_at[lt]=2014-05-08T17:01:06.000Z&created_at[lte]=2014-05-08T17:01:06.000Z" );
	});

});
</cfscript>

