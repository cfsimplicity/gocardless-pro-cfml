<cfscript>
describe( "completeRedirectFlow()",function(){

	beforeEach( function(){
		variables.mockSuccessfulHttpResponse = {
			fileContent: '{"redirect_flows":{"id":"RE123","description":"Test purchase","session_token":"123","scheme":null,"success_redirect_url":"https://localhost/complete","created_at":"2016-11-04T12:32:04.455Z","links":{"creditor":"CR123","mandate":"MD123","customer":"CU123","customer_bank_account":"BA123"}}}'
			,statuscode: 200
		};
		variables.completeRedirectFlow = gc.redirectFlows().complete( "RE123" );
		prepareMock( completeRedirectFlow );
		completeRedirectFlow.$( method="sendHttpRequest",returns=mockSuccessfulHttpResponse );
	});

	it( "generates the correct http attributes and json body", function(){
		var result = completeRedirectFlow
			.withSessionToken( 123 )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/redirect_flows/RE123/actions/complete" );
		expect( result.requestMethod ).toBe( "POST" );
		expect( result.requestBody ).toInclude( '"session_token":"123"' );
	});

	it( "returns the correct resource on success", function(){
		var result = completeRedirectFlow
			.withSessionToken( 123 )
			.execute();
		var flow = result.resource;
		expect( flow.links.creditor ).toBe( "CR123" );
		expect( flow.links.customer ).toBe( "CU123" );
		expect( flow.links.customer_bank_account ).toBe( "BA123" );
		expect( flow.links.mandate ).toBe( "MD123" );
	});

	it( "adds an error key to the result if completion is not successful", function(){
		completeRedirectFlow.$( method="sendHttpRequest",returns=mock.failedHttpResponse() );
		var result = completeRedirectFlow
			.withSessionToken( 123 )
			.execute();
		expect( result ).toHaveKey( "error" );
	});

});
</cfscript>