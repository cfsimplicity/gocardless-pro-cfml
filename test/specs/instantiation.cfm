<cfscript>
describe( "when instantiated",function(){

	it( "defaults to the sandbox environment", function(){
		expected = "https://api-sandbox.gocardless.com/";
		actual = gc.getInstanceVariables().baseGoCardlessUrl;
		expect( actual ).toBe( expected );
		gc = New root.gocardless( "dummyAccessToken", "sandboox" );// handle typo
		actual = gc.getInstanceVariables().baseGoCardlessUrl;
		expect( actual ).toBe( expected );
	});

	it( "can be set to the live environment", function(){
		expected = "https://api.gocardless.com/";
		gc = New root.gocardless( "dummyAccessToken", "live" );
		actual = gc.getInstanceVariables().baseGoCardlessUrl;
		expect( actual ).toBe( expected );
	});

});
</cfscript>