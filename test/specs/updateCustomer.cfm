<cfscript>
describe( "updateCustomer()",function(){

	beforeEach( function(){
		variables.updateCustomer = gc.customers().update( "CU123" );
		prepareMock( updateCustomer );
		updateCustomer.$( method="sendHttpRequest",returns=mock.successfulcustomerRequest() );
	});

	it( "generates the correct http attributes", function(){
		var result = updateCustomer.execute();
		expect( result.requestUrl ).toBe( "https://api-sandbox.gocardless.com/customers/CU123" );
		expect( result.requestMethod ).toBe( "PUT" );
	});

	it( "generates the correct json body", function(){
		var result = updateCustomer
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
		var result = updateCustomer.withMetaData( { key: "value" } ).execute();
		expect( result ).toHaveKey( "resource" );
	});

});
</cfscript>