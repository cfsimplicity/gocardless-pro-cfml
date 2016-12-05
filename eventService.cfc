component extends="baseService"{

	function get( required string id ){
		return New requests.getEvent( instanceVariables=instance, id=id );
	}

	function list(){
		return New requests.listEvents( instanceVariables=instance );
	}

}