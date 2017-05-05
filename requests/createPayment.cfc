component accessors="true" extends="baseRequest"{

	property name="amount" type="numeric" required="true"; /* Amount in pence (GBP), cents (EUR), or öre (SEK). */
	property name="appFee" type="numeric"; /* The amount to be deducted from the payment as the OAuth app’s fee, in pence or cents. */
	property name="chargeDate"; /* A future date in format yyyy-mm-dd on which the payment should be collected. If not specified, the payment will be collected as soon as possible. This must be on or after the mandate’s next_possible_charge_date, and will be rolled-forwards by GoCardless if it is not a working day. */
	property name="currency" required="true"; /* ISO 4217 currency code, currently only “GBP”, “EUR”, and “SEK” are supported. */
	property name="description"; /* A human-readable description of the payment. This will be included in the notification email GoCardless sends to your customer if your organisation does not send its own notifications  */
	property name="mandate" required="true"; /* ID of the mandate against which this payment should be collected. */
	property name="reference"; /* Restrictions apply to the use of references but note that the client library does NOT enforce these. Please see the API docs */


	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "POST" );
		this.setEndPoint( "payments" );
		this.setApiDocsLink( this.getApiDocsLink() & "##payments-create-a-payment" );
		return this;
	}

	function withAmount( required numeric value ){
		super.validateAmount( "amount", value );
		this.setAmount( value );
		return this;
	}

	function withAppFee( required numeric value ){
		super.validateAmount( "appFee", value );
		this.setAppFee( value );
		return this;
	}

	function withChargeDate( required string value ){
		super.validateDateFormat( "chargeDate", value );
		this.setChargeDate( value );
		return this;
	}

	function withCurrency( required string value ){
		super.validateCurrency( "currency", value );
		this.setCurrency( value );
		return this;
	}

	function withDescription( required string value ){
		this.setDescription( value );
		return this;
	}

	function withMandate( required string id ){
		this.setMandate( id );
		return this;
	}

	function withReference( required string value ){
		this.setReference( forceQuotedNumberValue( value ) );
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

	private void function validateRequiredParameters(){
		if( !this.has( "mandate" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'mandate' parameter", detail="You must provide the id of the mandate against which this payment will be created. See #this.getApiDocsLink()#" );
		if( !this.has( "amount" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'amount' parameter", detail="You must provide an amount in pence/cents. See #this.getApiDocsLink()#" );
		if( !this.has( "currency" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'currency' parameter", detail="You must provide the currency: 'GBP', 'EUR' or 'SEK'. See #this.getApiDocsLink()#" );
	}

	function execute(){
		validateRequiredParameters();
		var body = {
			payments: {
				links:{
					mandate: this.getMandate()
				}
				,amount: this.getAmount()
				,currency: this.getCurrency()
			}
		};
		if( this.has( "appFee" ) )
			body.payments.app_fee = this.getAppFee();
		if( this.has( "chargeDate" ) )
			body.payments.charge_date = this.getChargeDate();
		if( this.has( "description" ) )
			body.payments.description = this.getDescription();
		if( this.has( "reference" ) )
			body.payments.reference = this.getReference();
		if( this.has( "metadata" ) )
			body.payments.metadata = this.getMetadata();
		this.setBody( body );
		super.serializeBodyToJson();
		var result = super.makeApiRequest();
		if( !Find( "201", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.payments;
		return result;
	}

}