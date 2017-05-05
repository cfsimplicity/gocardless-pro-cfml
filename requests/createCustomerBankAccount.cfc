component accessors="true" extends="baseRequest"{

	property name="accountHolderName" required="true";/* Name of the account holder, as known by the bank. Usually this matches the name of the linked customer. This field will be transliterated, upcased and truncated to 18 characters. */
	property name="accountNumber";/* Bank account number. Alternatively you can provide an iban */
	property name="bankCode"; /* Alternatively you can provide an iban */
	property name="branchCode"; /* Alternatively you can provide an iban */
	property name="countryCode"; /* ISO 3166-1 alpha-2 code. Defaults to the country code of the iban if supplied, otherwise is required. */
	property name="currency"; /* ISO 4217 currency code, defaults to national currency of countryCode. */
	property name="customer" required="true";/* ID of the customer that owns this bank account. */
	property name="iban"; /* International Bank Account Number. Alternatively you can provide local details. IBANs are not accepted for accounts in SEK. */
	/* links[customer_bank_account_token] NOT SUPPORTED */

	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "POST" );
		this.setEndPoint( "customer_bank_accounts" );
		this.setApiDocsLink( this.getApiDocsLink() & "##customer-bank-accounts-create-a-customer-bank-account" );
		return this;
	}

	function withAccountHolderName( required string value ){
		this.setAccountHolderName( value );
		return this;
	}

	function withAccountNumber( required string value ){
		this.setAccountNumber( forceQuotedNumberValue( value ) );
		return this;
	}

	function withBankCode( required string value ){
		this.setBankCode( forceQuotedNumberValue( value ) );
		return this;
	}

	function withBranchCode( required string value ){
		this.setBranchCode( forceQuotedNumberValue( value ) );
		return this;
	}

	function withCountryCode( required string value ){
		this.setCountryCode( value );
		return this;
	}

	function withCurrency( required string value ){
		super.validateCurrency( "currency", value );
		this.setCurrency( value );
		return this;
	}

	function withCustomer( required string id ){
		this.setCustomer( id );
		return this;
	}

	function withIban( required string value ){
		this.setIban( value );
		return this;
	}

	function withIdemPotencyKey( required string value ){
		this.setIdemPotencyKey( value );
		return this;
	}

	function withMetadata( required struct metadata ){
		super.validateMetadata( metadata );
		this.setMetadata( metadata );
		return this;
	}

	private void function validateRequiredParameters(){
		if( !this.has( "customer" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'customer' parameter", detail="You must provide the id of the customer who owns this bank account. See #this.getApiDocsLink()#" );
		if( !this.has( "accountHolderName" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'account_holder_name' parameter", detail="You must provide the name of the account holder. See #this.getApiDocsLink()#" );
	}

	function execute(){
		validateRequiredParameters();
		var body = {
			customer_bank_accounts: {
				account_holder_name: this.getAccountHolderName()
				,links:{
					customer: this.getCustomer()
				}
			}
		};
		if( this.has( "accountNumber" ) )
			body.customer_bank_accounts.account_number = this.getAccountNumber();
		if( this.has( "bankCode" ) )
			body.customer_bank_accounts.bank_code = this.getBankCode();
		if( this.has( "branchCode" ) )
			body.customer_bank_accounts.branch_code = this.getBranchCode();
		if( this.has( "countryCode" ) )
			body.customer_bank_accounts.country_code = this.getCountryCode();
		if( this.has( "currency" ) )
			body.customer_bank_accounts.currency = this.getCurrency();
		if( this.has( "iban" ) )
			body.customer_bank_accounts.iban = this.getIban();
		if( this.has( "metadata" ) )
			body.customer_bank_accounts.metadata = this.getMetadata();	
		this.setBody( body );
		super.serializeBodyToJson();
		var result = super.makeApiRequest();
		if( !Find( "201", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.customer_bank_accounts;
		return result;
	}

}