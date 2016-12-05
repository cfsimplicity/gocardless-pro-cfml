<cfscript>
describe( "cancelMandate()",function(){

	beforeEach( function(){
		variables.successfullyCancelledMandate = {
			fileContent: '{"mandates":{"id":"MD123","created_at":"2014-05-08T17:01:06.000Z","reference":"REF-123","status":"cancelled","scheme":"bacs","next_possible_charge_date":null,"metadata":{"contract":"ABCD1234"},"links":{"customer_bank_account":"BA123","creditor":"CR123"}}}'
			,statuscode: 200
		};
		variables.cancelMandate = gc.mandates().cancel( "MD123" );
		prepareMock( cancelMandate );
		cancelMandate.$( method="sendHttpRequest",returns=successfullyCancelledMandate );
	});

	it( "generates the correct http attributes", function(){
		var result = cancelMandate.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/mandates/MD123/actions/cancel" );
		expect( result.requestMethod ).toBe( "POST" );
	});

	it( "generates the correct json body", function(){
		var result = cancelMandate.withMetaData( { key: "value" } ).execute();
		expect( result.requestBody ).toInclude( '{"data":{"metadata":' );
		expect( result.requestBody ).toInclude( '"key":"value"' );
	});

	it( "returns the mandate resource on success", function(){
		var result = cancelMandate.withMetaData( { key: "value" } ).execute();
		expect( result ).toHaveKey( "resource" );
		expect( result.resource.status ).toBe( "cancelled" );
	});

});
</cfscript>