<cfscript>
describe( "getMandate()",function(){

	beforeEach( function(){
		variables.getMandate = gc.mandates().get( "MD123" );
		prepareMock( getMandate );
		getMandate.$( method="sendHttpRequest",returns=mock.successfulMandateRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = getMandate.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/mandates/MD123" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "returns the mandate resource on success", function(){
		var result = getMandate.execute();
		var mandate = result.resource;
		expect( mandate.id ).toBe( "MD123" );
		expect( mandate.links.creditor ).toBe( "CR123" );
	});

});
</cfscript>