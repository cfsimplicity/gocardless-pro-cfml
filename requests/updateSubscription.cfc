component accessors="true" extends="baseRequest"{

	property name="id";
	property name="name" type="string"; /* Optional name for the subscription. This will be set as the description on each payment created. Must not exceed 255 characters. */
	property name="paymentReference" type="string"; /* Restrictions apply to the use of references but note that the client library does NOT enforce these. Please see the API docs */
	
	function init( required instanceVariables, required string id ){
		super.init( argumentCollection=arguments );
		this.setId( id );
		this.setEndPoint( "subscriptions/" & this.getId() );
		this.setHttpMethod( "PUT" );
		this.setApiDocsLink( this.getApiDocsLink() & "##subscriptions-update-a-subscription" );
		return this;
	}

	function withMetadata( required struct metadata ){
		super.validateMetadata( metadata );
		this.setMetadata( metadata );
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

	function execute(){
		var body = {};
		if( this.has( "metadata" ) )
			body.subscriptions.metadata = this.getMetadata();
		if( this.has( "name" ) )
			body.subscriptions.name = this.getName();
		if( this.has( "paymentReference" ) )
			body.subscriptions.payment_reference = this.getPaymentReference();
		this.setBody( body );
		super.serializeBodyToJson();
		var result = super.makeApiRequest();
		if( !Find( "200", result.httpResponse.statuscode ) ){
			super.handleGoCardlessError( result );
			return result;
		}
		result.requestSucceeded = true;
		result.resource = result.data.subscriptions;
		return result;
	}

}