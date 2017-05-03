<cfscript>
describe( "getRedirectFlow()",function(){

	beforeEach( function(){
		variables.mockSuccessfulHttpResponse = {
			fileContent: '{"redirect_flows":{"id":"RE123","description":"Test purchase","session_token":"123","scheme":null,"success_redirect_url":"https://localhost/complete","created_at":"2016-11-04T12:32:04.455Z","links":{"creditor":"CR123"},"redirect_url":"https://pay-sandbox.gocardless.com/flow/RE123"}}'
			,statuscode: 200
		};
		variables.getRedirectFlow = gc.redirectFlows().get( "RE123" );
		prepareMock( getRedirectFlow );
		getRedirectFlow.$( method="sendHttpRequest",returns=mockSuccessfulHttpResponse );
	});

	it( "generates the correct http attributes", function(){
		var result = getRedirectFlow.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/redirect_flows/RE123" );
		expect( result.requestMethod ).toBe( "GET" );
	});

	it( "returns the redirectFlow resource on success", function(){
		var result = getRedirectFlow.execute();
		var flow = result.resource;
		expect( flow.id ).toBe( "RE123" );
		expect( flow.redirect_url ).toBe( "https://pay-sandbox.gocardless.com/flow/RE123" );
		expect( flow.links.creditor ).toBe( "CR123" );
	});

});
</cfscript>