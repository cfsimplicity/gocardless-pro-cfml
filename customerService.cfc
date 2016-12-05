component extends="baseService"{

	function create(){
		return New requests.createCustomer( instanceVariables=instance );
	}

	function get( required string id ){
		return New requests.getCustomer( instanceVariables=instance, id=id );
	}

	function list(){
		return New requests.listCustomers( instanceVariables=instance );
	}

	function update( required string id ){
		return New requests.updateCustomer( instanceVariables=instance, id=id );
	}

}