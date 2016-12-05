component extends="baseService"{

	function create(){
		return New requests.createMandate( instanceVariables=instance );
	}

	function get( required string id ){
		return New requests.getMandate( instanceVariables=instance, id=id );
	}

	function list(){
		return New requests.listMandates( instanceVariables=instance );
	}

	function update( required string id ){
		return New requests.updateMandate( instanceVariables=instance, id=id );
	}

	function cancel( required string id ){
		return New requests.cancelMandate( instanceVariables=instance, id=id );
	}

	function reinstate( required string id ){
		return New requests.reinstateMandate( instanceVariables=instance, id=id );
	}

}