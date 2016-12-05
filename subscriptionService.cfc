component extends="baseService"{

	function create(){
		return New requests.createSubscription( instanceVariables=instance );
	}

	function get( required string id ){
		return New requests.getSubscription( instanceVariables=instance, id=id );
	}

	function list(){
		return New requests.listSubscriptions( instanceVariables=instance );
	}

	function update( required string id ){
		return New requests.updateSubscription( instanceVariables=instance, id=id );
	}

	function cancel( required string id ){
		return New requests.cancelSubscription( instanceVariables=instance, id=id );
	}

}