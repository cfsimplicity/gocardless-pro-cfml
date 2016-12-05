<cfscript>
describe( "updateMandate()",function(){

	beforeEach( function(){
		variables.updateMandate = gc.mandates().update( "MD123" );
		prepareMock( updateMandate );
		updateMandate.$( method="sendHttpRequest",returns=mock.successfulMandateRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = updateMandate.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/mandates/MD123" );
		expect( result.requestMethod ).toBe( "PUT" );
	});

	it( "generates the correct json body", function(){
		var result = updateMandate.withMetaData( { key: "value" } ).execute();
		expect( result.requestBody ).toInclude( '{"mandates":{"metadata":' );
		expect( result.requestBody ).toInclude( '"key":"value"' );
	});

	it( "returns the mandate resource on success", function(){
		var result = updateMandate.withMetaData( { key: "value" } ).execute();
		expect( result ).toHaveKey( "resource" );
	});

});
</cfscript>