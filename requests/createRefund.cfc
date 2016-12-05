component accessors="true" extends="baseRequest"{

	property name="amount" type="numeric" required="true"; /* Amount in pence (GBP), cents (EUR), or öre (SEK). */
	property name="reference"; /* Restrictions apply to the use of references but note that the client library does NOT enforce these. Please see the API docs */
	property name="totalAmountConfirmation" required="true";/* Total expected refunded amount in pence/cents/öre. If there are other partial refunds against this payment, this value should be the sum of the existing refunds plus the amount of the refund being created. */
	property name="payment" required="true";/* ID of the payment against which the refund is being made. */


	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "POST" );
		this.setEndPoint( "refunds" );
		this.setApiDocsLink( this.getApiDocsLink() & "##refunds-create-a-refund" );
		return this;
	}

	function withAmount( required numeric value ){
		super.validateAmount( "amount", value );
		this.setAmount( value );
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

	function withReference( required string value ){
		this.setStringValue( "reference", value );
		return this;
	}

	function withTotalAmountConfirmation( required numeric value ){
		super.validateAmount( "amount", value );
		this.setTotalAmountConfirmation( value );
		return this;
	}

	function withPayment( required string id ){
		this.setPayment( id );
		return this;
	}

	private void function validateRequiredParameters(){
		if( !this.has( "payment" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'payment' parameter", detail="You must provide the id of the payment against which this refund will be created. See #this.getApiDocsLink()#" );
		if( !this.has( "amount" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'amount' parameter", detail="You must provide an amount in pence/cents. See #this.getApiDocsLink()#" );
		if( !this.has( "totalAmountConfirmation" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'total_amount_confirmation' parameter", detail="You must provide the total expected refunded amount. See #this.getApiDocsLink()#" );
	}

	function execute(){
		validateRequiredParameters();
		var body = {
			refunds: {
				links:{
					payment: this.getPayment()
				}
				,amount: this.getAmount()
				,total_amount_confirmation: this.getTotalAmountConfirmation()
			}
		};
		if( this.has( "metadata" ) )
			body.refunds.metadata = this.getMetadata();
		if( this.has( "reference" ) )
			body.refunds.reference = this.getReference();
		this.setBody( body );
		super.serializeBodyToJson();
		var result = super.makeApiRequest();
		if( !Find( "201", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.refunds;
		return result;
	}

}