component extends="baseService"{

	function create(){
		return New requests.createCustomerBankAccount( instanceVariables=instance );
	}

	function get( required string id ){
		return New requests.getCustomerBankAccount( instanceVariables=instance, id=id );
	}

	function list(){
		return New requests.listCustomerBankAccounts( instanceVariables=instance );
	}

	function update( required string id ){
		return New requests.updateCustomerBankAccount( instanceVariables=instance, id=id );
	}

	function disable( required string id ){
		return New requests.disableCustomerBankAccount( instanceVariables=instance, id=id );
	}

}