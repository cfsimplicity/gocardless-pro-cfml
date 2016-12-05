component accessors="true" extends="baseRequest"{

	property name="amount" type="numeric" required="true"; /* Amount in pence or cents. */
	property name="count" type="numeric"; /* An alternative way to set end_date. The total number of payments that should be taken by this subscription. This will set end_date automatically. */
	property name="currency" type="string" required="true"; /* ISO 4217 currency code, currently only “GBP”, “EUR”, and “SEK” are supported. */
	property name="dayOfMonth" type="numeric"; /* As per RFC 2445. The day of the month to charge customers on. 1-28 or -1 to indicate the last day of the month. */
	property name="endDate" type="string"; /* Date on or after which no further payments should be created. If blank, the subscription will continue forever. Alternatively, count can be set to achieve a specific number of payments. */
	property name="interval" type="numeric"; /* Number of intervalUnits between customer charge dates. Must result in at least one charge date per year. Defaults to 1. */
	property name="intervalUnit" type="string" required="true"; /* The unit of time between customer charge dates. One of 'weekly', 'monthly' or 'yearly'. */
	property name="mandate" type="string" required="true"; /* ID of the mandate against which this subscription should be collected. */
	property name="month" type="string"; /* Name of the month on which to charge a customer. Must be lowercase. */
	property name="name" type="string"; /* Optional name for the subscription. This will be set as the description on each payment created. Must not exceed 255 characters. */
	property name="paymentReference" type="string"; /* Restrictions apply to the use of references but note that the client library does NOT enforce these. Please see the API docs */
	property name="startDate" type="string"; /* The date on which the first payment should be charged. Must be within one year of creation and on or after the mandate’s nextPossibleChargeDate. When blank, this will be set as the mandate's nextPossibleChargeDate. */

	function init( required instanceVariables ){
		super.init( argumentCollection=arguments );
		this.setHttpMethod( "POST" );
		this.setEndPoint( "subscriptions" );
		this.setApiDocsLink( this.getApiDocsLink() & "##subscriptions-create-a-subscription" );
		return this;
	}

	function withAmount( required numeric value ){
		super.validateAmount( "amount", value );
		this.setAmount( value );
		return this;
	}

	function withCount( required numeric value ){
		this.setCount( value );
		return this;
	}

	function withCurrency( required string value ){
		super.validateCurrency( "currency", value );
		this.setCurrency( value );
		return this;
	}

	function withDayOfMonth( required numeric value ){
		this.setDayOfMonth( value );
		return this;
	}

	function withEndDate( required string value ){
		super.validateDateFormat( "endDate", value );
		this.setEndDate( date );
		return this;
	}

	function withIdemPotencyKey( required string value ){
		this.setIdemPotencyKey( value );
		return this;
	}

	function withInterval( required numeric value ){
		this.setInterval( value );
		return this;
	}

	function withIntervalUnit( required string value ){
		value = LCase( value );
		if( !ListFind( "weekly,monthly,yearly", value ) )
			throw( type="GoCardlessClientException.InvalidParameter", message="Invalid 'intervalUnit' parameter '#value#'", detail="Valid values are 'weekly', 'monthly' or 'yearly'. See #this.getApiDocsLink()#" );
		this.setIntervalUnit( value );
		return this;
	}

	function withMandate( required string id ){
		this.setMandate( id );
		return this;
	}

	function withMetadata( required struct metadata ){
		super.validateMetadata( metadata );
		this.setMetadata( metadata );
		return this;
	}

	function withMonth( required string value ){
		this.setMonth( LCase( value ) );/* ?? Not sure what format this should be in? */
		return this;
	}

	function withName( required string value ){
		super.validateStringLength( "name", value, 255 );
		this.setName( value );
		return this;
	}

	function withPaymentReference( required string value ){
		this.setPaymentReference( value );
		return this;
	}

	function withStartDate( required string value ){
		super.validateDateFormat( "startDate", value );
		this.setStartDate( value );
		return this;
	}

	private void function validateRequiredParameters(){
		if( !this.has( "mandate" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'mandate' parameter", detail="You must provide the id of the mandate against which this subscription will be created. See #this.getApiDocsLink()#" );
		if( !this.has( "amount" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'amount' parameter", detail="You must provide an amount in pence/cents. See #this.getApiDocsLink()#" );
		if( !this.has( "currency" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'currency' parameter", detail="You must provide the currency: 'GBP', 'EUR' or 'SEK'. See #this.getApiDocsLink()#" );
		if( !this.has( "intervalUnit" ) )
			throw( type="GoCardlessClientException.MissingRequiredParameter", message="Missing 'intervalUnit' parameter", detail="You must provide the interval unit. One of 'weekly', 'monthly' or 'yearly'. See #this.getApiDocsLink()#" );
	}

	function execute(){
		validateRequiredParameters();
		var body = {
			subscriptions: {
				links:{
					mandate: this.getMandate()
				}
				,amount: this.getAmount()
				,currency: this.getCurrency()
				,interval_unit: this.getIntervalUnit()
			}
		};
		if( this.has( "count" ) )
			body.subscriptions.count = this.getCount();
		if( this.has( "dayOfMonth" ) )
			body.subscriptions.day_of_month = this.getDayOfMonth();
		if( this.has( "endDate" ) )
			body.subscriptions.end_date = this.getEndDate();
		if( this.has( "interval" ) )
			body.subscriptions.interval = this.getInterval();
		if( this.has( "metadata" ) )
			body.subscriptions.metadata = this.getMetadata();
		if( this.has( "month" ) )
			body.subscriptions.month = this.getMonth();
		if( this.has( "name" ) )
			body.subscriptions.name = this.getName();
		if( this.has( "paymentReference" ) )
			body.subscriptions.payment_reference = this.getPaymentReference();
		if( this.has( "startDate" ) )
			body.subscriptions.start_date = this.getStartDate();
		this.setBody( body );
		super.serializeBodyToJson();
		var result = super.makeApiRequest();
		if( !Find( "201", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.subscriptions;
		return result;
	}

}