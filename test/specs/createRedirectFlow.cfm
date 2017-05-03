<cfscript>
describe( "createRedirectFlow()",function(){

	beforeEach( function(){
		variables.mockSuccessfulHttpResponse = {
			fileContent: '{"redirect_flows":{"id":"RE123","description":"Test purchase","session_token":"123","scheme":null,"success_redirect_url":"https://localhost/complete","created_at":"2016-11-04T12:32:04.455Z","links":{"creditor":"CR123"},"redirect_url":"https://pay-sandbox.gocardless.com/flow/RE123"}}'
			,statuscode: 201
		};
		variables.createRedirectFlow = gc.redirectFlows().create();
		prepareMock( createRedirectFlow );
		createRedirectFlow.$( method="sendHttpRequest",returns=mockSuccessfulHttpResponse );
	});

	it( "generates the correct http attributes and json body", function(){
		var result = createRedirectFlow
			.withSessionToken( "123" )
			.withSuccessRedirectUrl( "https://localhost/complete" )
			.withDescription( "Test purchase" )
			.withPrefilledCustomerAddressLine1( "line 1" )
			.withPrefilledCustomerAddressLine2( "line 2" )
			.withPrefilledCustomerAddressLine3( "line 3" )
			.withPrefilledCustomerCity( "city" )
			.withPrefilledCustomerCompanyName( "company" )
			.withPrefilledCustomerCountryCode( "GB" )
			.withPrefilledCustomerEmail( "name@example.com" )
			.withPrefilledCustomerFamilyName( "Osborne" )
			.withPrefilledCustomerGivenName( "Frank" )
			.withPrefilledCustomerLanguage( "en" )
			.withPrefilledCustomerPostalCode( "postcode" )
			.withPrefilledCustomerSwedishIdentityNumber( "swid" )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/redirect_flows" );
		expect( result.requestMethod ).toBe( "POST" );
		expect( result.requestBody ).toInclude( '"session_token":"123"' );
		expect( result.requestBody ).toInclude( '"success_redirect_url":"https://localhost/complete"' );
		expect( result.requestBody ).toInclude( '"description":"Test purchase"' );
		expect( result.requestBody ).toInclude( '"prefilled_customer":' );
		expect( result.requestBody ).toInclude( '"address_line1":"line 1"' );
		expect( result.requestBody ).toInclude( '"address_line2":"line 2"' );
		expect( result.requestBody ).toInclude( '"address_line3":"line 3"' );
		expect( result.requestBody ).toInclude( '"city":"city"' );
		expect( result.requestBody ).toInclude( '"company_name":"company"' );
		expect( result.requestBody ).toInclude( '"country_code":"GB"' );
		expect( result.requestBody ).toInclude( '"email":"name@example.com"' );
		expect( result.requestBody ).toInclude( '"family_name":"Osborne"' );
		expect( result.requestBody ).toInclude( '"given_name":"Frank"' );
		expect( result.requestBody ).toInclude( '"language":"en"' );
		expect( result.requestBody ).toInclude( '"postal_code":"postcode"' );
		expect( result.requestBody ).toInclude( '"swedish_identity_number":"swid"' );
	});

	it( "serialises a numeric session token as a JSON string enclosed in quotes", function(){
		var result = createRedirectFlow
			.withSessionToken( 123 )
			.withSuccessRedirectUrl( "https://localhost/complete" )
			.execute();
		expect( result.requestBody ).toInclude( '"session_token":"123"' );
	});

	it( "returns the redirectFlow resource on success", function(){
		var result = createRedirectFlow
			.withSessionToken( "123" )
			.withSuccessRedirectUrl( "https://localhost/complete" )
			.execute();
		var flow = result.resource;
		expect( flow.id ).toBe( "RE123" );
		expect( flow.redirect_url ).toBe( "https://pay-sandbox.gocardless.com/flow/RE123" );
		expect( flow.links.creditor ).toBe( "CR123" );
	});

	it( "adds an error key to the result if creation is not successful", function(){
		createRedirectFlow.$( method="sendHttpRequest",returns=mock.failedHttpResponse() );
		var result = createRedirectFlow
			.withSessionToken( "123" )
			.withSuccessRedirectUrl( "https://localhost/complete" )
			.withDescription( "Test purchase" )
			.execute();
		expect( result ).toHaveKey( "error" );
	});

	describe( "exceptions",function(){

		it( "Throws an exception if required parameters are missing",function() {
			expect( function(){
				var result = createRedirectFlow
					.execute();
			}).toThrow( type="GoCardlessClientException.MissingRequiredParameter" );
		});

	});

});
</cfscript>