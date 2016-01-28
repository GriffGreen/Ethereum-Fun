contract WillManager {
	//Making these variables public displays them in the Ethereum Wallet.
	address public willOwner;
	bytes32 public hashOfWill;
	bytes32 public hashOfWillBeingChecked;
	bool public willIsCorrect;
	bool public willCreated;
	address public lastWillChecker;
	
	function WillManager(){
    	willOwner = msg.sender;
	}
	
	// In case you sent ether by accident. Don't send funds to this contract.
	function empty(){
 	uint256 balance = address(this).balance;
     address(willOwner).send(balance);
	}
	//This function can only be called by the person who first deployed this
	//contract, it creates a new will and replaces the old will if it existed.
	function newWill(string will) {
    	if (msg.sender != willOwner) {
        	willCreated = false;
    	} else {
        	hashOfWill = sha3(will);
            willCreated = true;
    	}
	}
	//This function can be called by anyone and they can verify that the version
	//of the Will that they have is the current up to date version.
	function checkWill(string willUserIsChecking) {
                lastWillChecker = msg.sender;
                hashOfWillBeingChecked = sha3(willUserIsChecking);  
	if (hashOfWillBeingChecked == hashOfWill) {
            willIsCorrect = true;
	    } else {
           	willIsCorrect = false;
    	}
	}
}
