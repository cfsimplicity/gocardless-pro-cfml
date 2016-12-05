component extends="baseService"{

	function get( required string id ){
		return New requests.getPayout( instanceVariables=instance, id=id );
	}

	function list(){
		return New requests.listPayouts( instanceVariables=instance );
	}

}