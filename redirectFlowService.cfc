component extends="baseService"{

	function create(){
		return New requests.createRedirectFlow( instanceVariables=instance );
	}

	function get( required string id ){
		return New requests.getRedirectFlow( instanceVariables=instance, id=id );
	}

	function complete( required string id ){
		return New requests.completeRedirectFlow( instanceVariables=instance, id=id );
	}

}