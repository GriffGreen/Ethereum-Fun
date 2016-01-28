/// title: Will Manager to for a Non-Devs' Enjoyment!
/// author: Griff Green
/// notice: This Contract gives the user a chance to interact with the blockchain as a novice, 
///it is not really for Will Validation

contract WillManager {
	/// notice: Making these variables public displays them in the Ethereum Wallet.
	address public willOwner;
	bytes32 public hashOfWill;
	bytes32 public hashOfWillBeingChecked;
	bool public willIsCorrect;
	bool public willCreated;
	address public lastWillChecker;
	
	/// notice: This function is called when the contract is deployed and it sets the account 
	///deploying it as the 'Will owner'	
	function WillManager(){
	    	willOwner = msg.sender;
	}
	
	/// notice: In case you sent ether to 'this' by accident this function will send the funds 
	///to the 'Will owner.' Don't send funds to this contract
	function empty(){
 		uint256 balance = address(this).balance;
     		address(willOwner).send(balance);
	}
	/// notice: This function will only update the 'Hash of will' if called by the 'Will owner'
	///otherwise it will make 'Will created' display 'No' 
	function newWill(string will) {
    		if (msg.sender != willOwner) {
        		willCreated = false;
    	} else {
        	hashOfWill = sha3(will);
            	willCreated = true;
    	}
	}
	/// notice: This function can be called by anyone and is used to verify that the version
	///of the Will that they have is the current up-to-date version
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
