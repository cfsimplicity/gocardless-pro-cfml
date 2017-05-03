component accessors="true" extends="baseRequest"{

	property name="description"; /* A description of the item the customer is paying for. This will be shown on the hosted payment pages. */
	//property name="links"; // for creditor, not supported
	property name="prefilledCustomer" type="struct";
	//property name="scheme"; //not supported
	property name="sessionToken";
	property name="successRedirectUrl";/* The URL to redirect to upon successful mandate setup. You must use a URL beginning https in the live environment. */
	
	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "POST" );
		this.setEndPoint( "redirect_flows" );
		this.setApiDocsLink( this.getApiDocsLink() & "##redirect-flows-create-a-redirect-flow" );
		variables.prefilledCustomer = {};
		return this;
	}

	function withDescription( required string value ){
		this.setDescription( value );
		return this;
	}

	function withSessionToken( required string value ){
		this.setStringValue( "sessionToken", value );
		return this;
	}

	function withSuccessRedirectUrl( required string value ){
		this.setSuccessRedirectUrl( value );
		return this;
	}

	function withPrefilledCustomerAddressLine1( required string value ){
		variables.prefilledCustomer.address_line1 = value;
		return this;
	}

	function withPrefilledCustomerAddressLine2( required string value ){
		variables.prefilledCustomer.address_line2 = value;
		return this;
	}

	function withPrefilledCustomerAddressLine3( required string value ){
		variables.prefilledCustomer.address_line3 = value;
		return this;
	}

	function withPrefilledCustomerCity( required string value ){
		variables.prefilledCustomer.city = value;
		return this;
	}

	function withPrefilledCustomerCompanyName( required string value ){
		variables.prefilledCustomer.company_name = value;
		return this;
	}

	function withPrefilledCustomerCountryCode( required string value ){
		variables.prefilledCustomer.country_code = value;
		return this;
	}

	function withPrefilledCustomerEmail( required string value ){
		variables.prefilledCustomer.email = value;
		return this;
	}

	function withPrefilledCustomerFamilyName( required string value ){
		variables.prefilledCustomer.family_name = value;
		return this;
	}

	function withPrefilledCustomerGivenName( required string value ){
		variables.prefilledCustomer.given_name = value;
		return this;
	}

	function withPrefilledCustomerLanguage( required string value ){
		variables.prefilledCustomer.language = value;
		return this;
	}

	function withPrefilledCustomerPostalCode( required string value ){
		variables.prefilledCustomer.postal_code = value;
		return this;
	}

	function withPrefilledCustomerSwedishIdentityNumber( required string value ){
		variables.prefilledCustomer.swedish_identity_number = value;
		return this;
	}

	private void function validateRequiredParameters(){
		if( !this.has( "sessionToken" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'sessionToken' parameter", detail="You must provide a session token to identify the user. See #this.getApiDocsLink()#" );
		if( !this.has( "successRedirectUrl" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'successRedirectUrl' parameter", detail="You must provide a url to which GoCardless can redirect after the mandate has been successfully set up. See #this.getApiDocsLink()#" );
	}

	private boolean function hasPrefilledCustomer(){
		return !StructIsEmpty( this.getPrefilledCustomer() );
	}

	function execute(){
		validateRequiredParameters();
		var body = {
			redirect_flows: {
				session_token: this.getSessionToken()
				,success_redirect_url: this.getSuccessRedirectUrl()
			}
		};
		if( this.has( "description" ) )
			body.redirect_flows.description = this.getDescription();
		if( hasPrefilledCustomer() )
			body.redirect_flows.prefilled_customer = this.getPrefilledCustomer();
		this.setBody( body );
		super.serializeBodyToJson();
		super.ensureJsonKeyValueIsQuoted( "session_token" );
		var result = super.makeApiRequest();
		if( !Find( "201", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.redirect_flows;
		return result;
	}

}