component accessors="true" extends="baseRequest"{

	property name="id";
	property name="addressLine1";
	property name="addressLine2";
	property name="addressLine3";
	property name="city";
	property name="companyName";
	property name="countryCode";
	property name="email";
	property name="familyName";
	property name="givenName";
	property name="language";
	property name="postalCode";
	property name="region";
	property name="swedishIdentityNumber";
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setId( id );
		this.setEndPoint( "customers/" & this.getId() );
		this.setHttpMethod( "PUT" );
		this.setApiDocsLink( this.getApiDocsLink() & "##customers-update-a-customer" );
		return this;
	}

	function withAddressLine1( required string value ){
		this.setAddressLine1( value );
		return this;
	}

	function withAddressLine2( required string value ){
		this.setAddressLine2( value );
		return this;
	}

	function withAddressLine3( required string value ){
		this.setAddressLine3( value );
		return this;
	}

	function withCity( required string value ){
		this.setCity( value );
		return this;
	}

	function withCompanyName( required string value ){
		this.setCompanyName( value );
		return this;
	}

	function withCountryCode( required string value ){
		this.setCountryCode( value );
		return this;
	}

	function withEmail( required string value ){
		this.setEmail( value );
		return this;
	}

	function withFamilyName( required string value ){
		this.setFamilyName( value );
		return this;
	}

	function withGivenName( required string value ){
		this.setGivenName( value );
		return this;
	}

	function withLanguage( required string value ){
		this.setLanguage( value );
		return this;
	}

	function withMetadata( required struct metadata ){
		super.validateMetadata( metadata );
		this.setMetadata( metadata );
		return this;
	}

	function withPostalCode( required string value ){
		this.setPostalCode( forceQuotedNumberValue( value ) );
		return this;
	}

	function withRegion( required string value ){
		this.setRegion( value );
		return this;
	}

	function withSwedishIdentityNumber( required string value ){
		this.setSwedishIdentityNumber( value );
		return this;
	}

	function execute(){
		var body = {};
		if( this.has( "addressLine1" ) )
			body.customers.address_line1 = this.getAddressLine1();
		if( this.has( "addressLine2" ) )
			body.customers.address_line2 = this.getAddressLine2();
		if( this.has( "addressLine3" ) )
			body.customers.address_line3 = this.getAddressLine3();
		if( this.has( "city" ) )
			body.customers.city = this.getCity();
		if( this.has( "companyName" ) )
			body.customers.company_name = this.getCompanyName();
		if( this.has( "countryCode" ) )
			body.customers.country_code = this.getCountryCode();
		if( this.has( "email" ) )
			body.customers.email = this.getEmail();
		if( this.has( "familyName" ) )
			body.customers.family_name = this.getFamilyName();
		if( this.has( "givenName" ) )
			body.customers.given_name = this.getGivenName();
		if( this.has( "language" ) )
			body.customers.language = this.getLanguage();
		if( this.has( "metadata" ) )
			body.customers.metadata = this.getMetadata();
		if( this.has( "postalCode" ) )
			body.customers.postal_code = this.getPostalCode();
		if( this.has( "region" ) )
			body.customers.region = this.getRegion();
		if( this.has( "swedishIdentityNumber" ) )
			body.customers.swedish_identity_number = this.getSwedishIdentityNumber();
		this.setBody( body );
		super.serializeBodyToJson();
		var result = super.makeApiRequest();
		if( !Find( "200", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.customers;
		return result;
	}

}