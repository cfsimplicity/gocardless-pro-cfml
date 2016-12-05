component extends="baseService"{

	function create(){
		return New requests.createRefund( instanceVariables=instance );
	}

	function get( required string id ){
		return New requests.getRefund( instanceVariables=instance, id=id );
	}

	function list(){
		return New requests.listRefunds( instanceVariables=instance );
	}

	function update( required string id ){
		return New requests.updateRefund( instanceVariables=instance, id=id );
	}

}