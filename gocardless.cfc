component{

	variables.baseGoCardlessUrls = {
		live = "https://api.gocardless.com/"
		,sandbox = "https://api-sandbox.gocardless.com/"
	};

	variables.instance = {
		clientVersion = "0.2.0"
		,goCardlessApiVersion = "2015-07-06"
		,engineIsColdFusion = ( server.coldfusion.productname IS "ColdFusion Server" )
		,engineIsLucee = ( server.coldfusion.productname IS "Lucee" )
	};

	
	function init( required string access_token, string environment="sandbox" ){
		instance.access_token = access_token;
		instance.environment = environment;
		instance.baseGoCardlessUrl = ( environment IS "live" )? baseGoCardlessUrls.live : baseGoCardlessUrls.sandbox;
		variables.customerService = New customerService( instanceVariables=instance );
		variables.customerBankAccountService = New customerBankAccountService( instanceVariables=instance );
		variables.eventService = New eventService( instanceVariables=instance );
		variables.mandateService = New mandateService( instanceVariables=instance );
		variables.paymentService = New paymentService( instanceVariables=instance );
		variables.payoutService = New payoutService( instanceVariables=instance );
		variables.redirectFlowService = New redirectFlowService( instanceVariables=instance );
		variables.refundService = New refundService( instanceVariables=instance );
		variables.subscriptionService = New subscriptionService( instanceVariables=instance );
		variables.webhookService = New webhookService( instanceVariables=instance );
		return this;
	}

	public struct function getInstanceVariables(){
		return instance;
	}

	public function customers(){
		return variables.customerService;
	}

	public function customerBankAccounts(){
		return variables.customerBankAccountService;
	}

	public function events(){
		return variables.eventService;
	}

	public function mandates(){
		return variables.mandateService;
	}

	public function payments(){
		return variables.paymentService;
	}

	public function payouts(){
		return variables.payoutService;
	}

	public function redirectFlows(){
		return variables.redirectFlowService;
	}

	public function refunds(){
		return variables.refundService;
	}

	public function subscriptions(){
		return variables.subscriptionService;
	}

	public function webhooks(){
		return variables.webhookService;
	}

}