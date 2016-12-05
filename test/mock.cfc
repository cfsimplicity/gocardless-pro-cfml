component{

	function init(){
		return this;
	}

	struct function emptyResponse(){
		return { fileContent: "", statuscode: "200" };
	}

	struct function failedHttpResponse(){
		return { fileContent: "", statuscode: "401" };
	}

	struct function successfulCustomerRequest( statuscode=200 ){
		return {
			fileContent: '{"customers":{"id":"CU123","created_at":"2014-05-08T17:01:06.000Z","email":"user@example.com","given_name":"Frank","family_name":"Osborne","address_line1":"27 Acer Road","address_line2":"Apt 2","address_line3":null,"city":"London","region":null,"postal_code":"E8 3GX","country_code":"GB","language":"en","swedish_identity_number":null,"metadata":{"salesforce_id":"ABCD1234"}}}'
			,statuscode: statuscode
		};
	}

	struct function successfulCustomerBankAccountRequest( statuscode=200 ){
		return {
			fileContent: '{"customer_bank_accounts":{"id":"BA123","created_at":"2014-05-08T17:01:06.000Z","account_holder_name":"Frank Osborne","account_number_ending":"11","country_code":"GB","currency":"GBP","bank_name":"BARCLAYS BANK PLC","metadata":{},"enabled":true,"links":{"customer":"CU123"}}}'
			,statuscode: statuscode
		};
	}

	struct function successfulEventRequest( statuscode=200 ){
		return {
			fileContent: '{"events":{"id":"EV123","created_at":"2014-04-08T17:01:06.000Z","resource_type":"payments","action":"confirmed","details":{"origin":"gocardless","cause":"payment_confirmed","description":"Payment confirmed"},"metadata":{},"links":{"payment":"PM123"}}}'
			,statuscode: statuscode
		};
	}

	struct function successfulMandateRequest( statuscode=200 ){
		return {
			fileContent: '{"mandates":{"id":"MD123","created_at":"2014-05-08T17:01:06.000Z","reference":"REF-123","status":"pending_submission","scheme":"bacs","next_possible_charge_date":"2014-11-10","metadata":{"contract":"ABCD1234"},"links":{"customer_bank_account":"BA123","creditor":"CR123"}}}'
			,statuscode: statuscode
		};
	}

	struct function successfulPaymentRequest( statuscode=200 ){
		return {
			fileContent: '{"payments":{"id":"PM123","created_at":"2014-05-08T17:01:06.000Z","charge_date":"2014-05-21","amount":100,"app_fee":1,"description":"Wine","currency":"GBP","status":"pending_submission","reference":"WINEBOX001","metadata":{"order_dispatch_date":"2014-05-22"},"amount_refunded":0,"links":{"mandate":"MD123","creditor":"CR123"}}}'
			,statuscode: statuscode
		};
	}

	struct function successfulPayoutRequest( statuscode=200 ){
		return {
			fileContent: '{"payouts":{"id":"PO123","amount":1000,"deducted_fees":10,"currency":"GBP","created_at":"2014-06-20T13:23:34.000Z","reference":"ref-1","arrival_date":"2014-06-27","status":"pending","links":{"creditor_bank_account":"BA123","creditor":"CR123"}}}'
			,statuscode: statuscode
		};
	}

	struct function successfulRefundRequest( statuscode=200 ){
		return {
			fileContent: '{"refunds":{"id":"RF123","created_at":"2014-05-08T17:01:06.000Z","amount":100,"currency":"GBP","reference":"Nude Wines refund","metadata":{"reason":"late delivery"},"links":{"payment":"PM123"}}}'
			,statuscode: statuscode
		};
	}

	struct function successfulSubscriptionRequest( statuscode=200 ){
		return {
			fileContent:'{"subscriptions":{"id":"SB123","created_at":"2014-10-20T17:01:06.000Z","amount":2500,"currency":"GBP","status":"active","name":"Monthly Magazine","start_date":"2014-11-03","end_date":null,"interval":1,"interval_unit":"monthly","day_of_month":1,"month":null,"payment_reference":null,"upcoming_payments":[{"charge_date":"2014-11-03","amount":2500},{"charge_date":"2014-12-01","amount":2500},{"charge_date":"2015-01-02","amount":2500},{"charge_date":"2015-02-02","amount":2500},{"charge_date":"2015-03-02","amount":2500},{"charge_date":"2015-04-01","amount":2500},{"charge_date":"2015-05-01","amount":2500},{"charge_date":"2015-06-01","amount":2500},{"charge_date":"2015-07-01","amount":2500},{"charge_date":"2015-08-03","amount":2500}],"metadata":{"order_no":"ABCD1234"},"links":{"mandate":"MD123"}}}'
			,statuscode: statuscode
		};
	}

}