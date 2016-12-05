component extends="baseService"{

	function create(){
		return New requests.createPayment( instanceVariables=instance );
	}

	function get( required string id ){
		return New requests.getPayment( instanceVariables=instance, id=id );
	}

	function list(){
		return New requests.listPayments( instanceVariables=instance );
	}

	function update( required string id ){
		return New requests.updatePayment( instanceVariables=instance, id=id );
	}

	function cancel( required string id ){
		return New requests.cancelPayment( instanceVariables=instance, id=id );
	}

	function retry( required string id ){
		return New requests.retryPayment( instanceVariables=instance, id=id );
	}

}