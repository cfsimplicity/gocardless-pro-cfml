<cfscript>
describe( "reinstateMandate()",function(){

	beforeEach( function(){
		variables.reinstateMandate = gc.mandates().reinstate( "MD123" );
		prepareMock( reinstateMandate );
		reinstateMandate.$( method="sendHttpRequest",returns=mock.successfulMandateRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = reinstateMandate.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/mandates/MD123/actions/reinstate" );
		expect( result.requestMethod ).toBe( "POST" );
	});

	it( "generates the correct json body", function(){
		var result = reinstateMandate.withMetaData( { key: "value" } ).execute();
		expect( result.requestBody ).toInclude( '{"data":{"metadata":' );
		expect( result.requestBody ).toInclude( '"key":"value"' );
	});

	it( "returns the mandate resource on success", function(){
		var result = reinstateMandate.withMetaData( { key: "value" } ).execute();
		expect( result ).toHaveKey( "resource" );
	});

});
</cfscript>