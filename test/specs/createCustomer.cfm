<cfscript>
describe( "createCustomer()",function(){

	beforeEach( function(){
		variables.mockSuccessfulHttpResponse = {
			fileContent: '{"customers":{"id":"CU123","created_at":"2014-05-08T17:01:06.000Z","email":"user@example.com","given_name":"Frank","family_name":"Osborne","address_line1":"27 Acer Road","address_line2":"Apt 2","address_line3":null,"city":"London","region":null,"postal_code":"E8 3GX","country_code":"GB","language":"en","swedish_identity_number":null,"metadata":{"salesforce_id":"ABCD1234"}}}'
			,statuscode: 201
		};
		variables.createCustomer = gc.customers().create();
		prepareMock( createCustomer );
		createCustomer.$( method="sendHttpRequest",returns=mockSuccessfulHttpResponse );
	});

	it( "generates the correct http attributes", function(){
		var result = createCustomer
			.withFamilyName( "Osborne" )
			.withGivenname( "Frank" )
			.withIdemPotencyKey( 123 )
			.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/customers" );
		expect( result.requestMethod ).toBe( "POST" );
		expect( result.idemPotencyKey ).toBe( 123 );
	});

	it( "generates the correct json body", function(){
		var result = createCustomer
			.withAddressLine1( "line 1" )
			.withAddressLine2( "line 2" )
			.withAddressLine3( "line 3" )
			.withCity( "city" )
			.withCompanyName( "company" )
			.withCountryCode( "GB" )
			.withEmail( "name@example.com" )
			.withFamilyName( "Osborne" )
			.withGivenName( "Frank" )
			.withLanguage( "en" )
			.withMetaData( { key: "value" } )
			.withPostalCode( "postcode" )
			.withRegion( "region" )
			.withSwedishIdentityNumber( "swid" )
			.execute();
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
		expect( result.requestBody ).toInclude( '"metadata":{"key":"value"}' );
		expect( result.requestBody ).toInclude( '"postal_code":"postcode"' );
		expect( result.requestBody ).toInclude( '"region":"region"' );
		expect( result.requestBody ).toInclude( '"swedish_identity_number":"swid"' );
	});

	it( "returns the customer resource on success", function(){
		var result = createCustomer
			.withFamilyName( "Osborne" )
			.withGivenName( "Frank" )
			.execute();
		var customer = result.resource;
		expect( customer.id ).toBe( "CU123" );
		var result = createCustomer
			.withCompanyName( "Company" )
			.execute();
		var customer = result.resource;
		expect( customer.id ).toBe( "CU123" );
	});

	it( "adds an error key to the result if creation is not successful", function(){
		createCustomer.$( method="sendHttpRequest",returns=mock.failedHttpResponse() );
		var result = createCustomer
			.withCompanyName( "Company" )
			.execute();
		expect( result ).toHaveKey( "error" );
	});

	describe( "exceptions",function(){

		it( "Throws an exception if required parameters are missing",function() {
			expect( function(){
				var result = createCustomer.execute();
			}).toThrow( type="GoCardlessClientException.MissingRequiredParameter" );
		});

	});

});
</cfscript>