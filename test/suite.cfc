component extends="testbox.system.BaseSpec"{

	variables.mock = New mock();

	/* function beforeAll(){} */

	/* function afterAll(){} */

	function run( testResults,testBox ){

		describe( "gocardless-pro-cfml test suite",function() {
     
			beforeEach( function( currentSpec ) {
			  variables.gc = New root.gocardless( "dummyAccessToken" );
			});

			/* afterEach( function( currentSpec ) {}); */

			var specs=DirectoryList( ExpandPath( "specs" ),false,"name","*.cfm" );
			// run every file in the specs folder
			for( var file in specs ){
				include "specs/#file#";	
			}

		});

	}

}