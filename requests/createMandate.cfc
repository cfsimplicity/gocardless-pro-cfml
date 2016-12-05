component accessors="true" extends="baseRequest"{

	property name="creditor"; /* ID of the associated creditor. Only required if your account manages multiple creditors. */
	property name="customerBankAccount" required="true"; /* ID of the associated customer bank account which the mandate is created and submits payments against. */
	property name="reference"; /* Restrictions apply to the use of references but note that the client library does NOT enforce these. Please see the API docs */
	property name="scheme"; /* Direct Debit scheme to which this mandate and associated mandates are submitted. Can be supplied or automatically detected from the customer’s bank account. Currently only “autogiro”, “bacs”, and “sepa_core” are supported. */


	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "POST" );
		this.setEndPoint( "mandates" );
		this.setApiDocsLink( this.getApiDocsLink() & "##mandates-create-a-mandate" );
		return this;
	}

	function withCreditor( required string id ){
		this.setCreditor( id );
		return this;
	}

	function withCustomerBankAccount( required string id ){
		this.setCustomerBankAccount( id );
		return this;
	}

	function withMetadata( required struct metadata ){
		super.validateMetadata( metadata );
		this.setMetadata( metadata );
		return this;
	}

	function withIdemPotencyKey( required string value ){
		this.setIdemPotencyKey( value );
		return this;
	}

	function withReference( required string value ){
		this.setStringValue( "reference", value );
		return this;
	}

	function withScheme( required string value ){
		this.setScheme( value );
		return this;
	}

	private void function validateRequiredParameters(){
		if( !this.has( "customerBankAccount" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'customerBankAccount' parameter", detail="You must provide the id of the customer bank account against which this mandate will be created. See #this.getApiDocsLink()#" );
	}

	function execute(){
		validateRequiredParameters();
		var body = {
			mandates: {
				links:{
					customer_bank_account: this.getCustomerBankAccount()
				}
			}
		};
		if( this.has( "creditor" ) )
			body.mandates.links.creditor = this.getCreditor();
		if( this.has( "metadata" ) )
			body.mandates.metadata = this.getMetadata();	
		if( this.has( "reference" ) )
			body.mandates.reference = this.getReference();
		if( this.has( "scheme" ) )
			body.mandates.scheme = this.getScheme();
		this.setBody( body );
		super.serializeBodyToJson();
		var result = super.makeApiRequest();
		if( !Find( "201", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.mandates;
		return result;
	}

}