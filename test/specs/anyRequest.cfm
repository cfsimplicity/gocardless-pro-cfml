<cfscript>
describe( "any request",function(){

	beforeEach( function(){
		variables.mockGoCardlessErrorResponse = {
			fileContent: '{"error":{"documentation_url":"https://developer.gocardless.com/##validation_failed","message":"Validation failed","type":"validation_failed","code":422,"request_id":"dd50eaaf-8213-48fe-90d6-5466872efbc4","errors":[{"message":"must be a number","field":"branch_code","request_pointer":"/customer_bank_accounts/branch_code"},{"message":"is the wrong length (should be 8 characters)","field":"branch_code","request_pointer":"/customer_bank_accounts/branch_code"}]}}'
			,statuscode: "422 (Unprocessable Entity)"
		};
		variables.createPayment = gc.payments().create();
		prepareMock( createPayment );
	});

	it( "will report successful processing by GoCardless", function(){
		createPayment.$( method="sendHttpRequest",returns=mock.successfulPaymentRequest( 201 ) );
		var result = createPayment.withAmount( 100 ).withCurrency( "GBP" ).withMandate( "MD123" ).execute();
		expect( result.requestSucceeded ).toBe( true );
	});

	it( "will report details of GoCardless errors", function(){
		createPayment.$( method="sendHttpRequest",returns=mockGoCardlessErrorResponse );
		var result = createPayment.withAmount( 100 ).withCurrency( "GBP" ).withMandate( "MD123" ).execute();
		expect( result.requestSucceeded ).toBe( false );
		expect( result.error ).toBe( "Response error from GoCardless: 422 (Unprocessable Entity). Validation failed. See the returned 'data.error' for more details." );
		expect( result.data ).toHaveKey( "error" );
	});

	it( "throws an exception if metadata is invalid",function(){
		var structWithTooManyKeys = { one:1, two:2, three:3, four:4 };
		expect( function(){
			var result = createPayment.withMetaData( structWithTooManyKeys );
		}).toThrow( type="GoCardlessClientException.InvalidParameter" );
		var structWithTooLongKey = {};
		structWithTooLongKey[ RepeatString( "a", 51) ] = "foo";
		expect( function(){
			var result = createPayment.withMetaData( structWithTooLongKey );
		}).toThrow( type="GoCardlessClientException.InvalidParameter" );
		var structWithTooLongValue = { a: RepeatString( "a", 501 ) };
		expect( function(){
			var result = createPayment.withMetaData( structWithTooLongValue );
		}).toThrow( type="GoCardlessClientException.InvalidParameter" );
	});

});
</cfscript>