component extends="baseService"{

	public struct function process( required struct httpRequestData, required string secret ){
		var result = {
			isValid: false
		};
		if( IsNull( httpRequestData.headers[ "Webhook-Signature" ] ) ){
			result.error = "Missing signature";
			return result;
		}
		result.payload = httpRequestData.content;
		result.signature = httpRequestData.headers[ "Webhook-Signature" ];
		//Because of the "application/json" contentType, CF returns the content as binary. Lucee returns it as a json string.
	 	if( IsBinary( result.payload ) )
	 		result.payload = convertBinaryToString( result.payload );
		if( !IsJson( result.payload ) ){
			result.error="Invalid JSON payload";
			return result;
		}
		if( !isValidSignature( result.signature, result.payload, secret ) ){
			result.error = "Invalid signature";
			header statuscode="498" statustext="Token Invalid";
			return result;
		}
		var data = DeserializeJson( result.payload );
		result.events = data.events;
		result.isValid = true;
		return result;
	}

	private string function convertBinaryToString( required binary input ){
		return CharSetEncode( input,"utf-8" );
	}

	private boolean function isValidSignature( required string signature, required string payload, required string secret ){
		var computedSignature = computeSignature( payload, secret );
		return ( signature IS computedSignature );
	}

	private string function computeSignature( required string payload, required string secret ){
		var charset = "utf-8";
		var algorithm	=	"HmacSHA256";
		var secretBytes = secret.getBytes( charset );
		var payloadBytes = payload.getBytes( charset );
		var secretObject = CreateObject( "java","javax.crypto.spec.SecretKeySpec" ).init( secretBytes, algorithm );
		var mac = CreateObject( "java","javax.crypto.Mac" ).getInstance( algorithm );
		mac.init( secretObject );
		return LCase( BinaryEncode( mac.doFinal( payloadBytes ), "hex" ) );
	}

}