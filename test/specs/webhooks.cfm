<cfscript>
describe( "webhooks",function(){

	it( "includes an error string in the result if the incoming signature is invalid", function(){
		var httpRequestData = {
			content: "{}"
			,headers: {}
		};
		httpRequestData.headers[ "Webhook-Signature" ] = "x";
		var secret = "y";
		var result = gc.webhooks().process( httpRequestData, secret );
		expect( result.isValid ).toBeFalse();
		expect( result ).toHaveKey( "error" );
		expect( result.error ).toBe( "Invalid signature" );
	});


	it( "returns the correct result if the signature is valid", function(){
		makePublic( gc.webhooks(), "computeSignature" );
		var secret="abc123";
		var requestBody='{
			"events": [
		    {
		      "id": "EV123",
		      "created_at": "2014-08-03T12:00:00.000Z",
		      "action": "confirmed",
		      "resource_type": "payments",
		      "links": {
		        "payment": "PM123"
		      },
		      "details": {
		        "origin": "gocardless",
		        "cause": "payment_confirmed",
		        "description": "Payment was confirmed as collected"
		      }
		    },
		    {
		      "id": "EV456",
		      "created_at": "2014-08-03T12:00:00.000Z",
		      "action": "failed",
		      "resource_type": "payments",
		      "links": {
		        "payment": "PM456"
		      },
		      "details": {
		        "origin": "bank",
		        "cause": "mandate_cancelled",
		        "description": "Customer cancelled the mandate at their bank branch.",
		        "scheme": "bacs",
		        "reason_code": "ARUDD-1"
		      }
		    }
		  ]
		}';
		var signature = gc.webhooks().computeSignature( requestBody, secret );
		var httpRequestData.headers[ "Webhook-Signature" ] = signature;
		httpRequestData.content = requestBody;
		var result = gc.webhooks().process( httpRequestData, secret );
		expect( result.isValid ).toBeTrue();
		expect( result ).toHaveKey( "events" );
	});

});
</cfscript>