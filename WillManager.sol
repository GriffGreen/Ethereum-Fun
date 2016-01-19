contract WillManager {
    //Making these variables public displays them in the mist browser.
    //The Mist Browser 0.38 has lots of bugs, expect to have to refresh the contract 
    //and to have to increase the suggested gas amount for calling functions to work.
    address public WillOwner;
    bytes32 public HashOfWill;
    bytes32 public HashOfWillBeingChecked;
    bool public WillIsCorrect;
    bool public WillCreated;
    address public LastWillChecker;
    
    function WillManager(){
        WillOwner = msg.sender; 
    }
    
    // In case you sent funds by accident. Don't send funds to this contract.
    function empty(){
     uint256 balance = address(this).balance;
     address(WillOwner).send(balance);
    }
    //This function can only be called by the person who first deployed this
    //contract, it creates a new will and replaces the old will if it existed.
    function NewWill(string Will) {
        if (msg.sender != WillOwner) {
            WillCreated = false;
        }else{
            HashOfWill = sha3(Will);
            WillCreated = true;
        }
    }
    //This function can be called by anyone and they can verify that the version
    //of the Will that they have is the current up to date version.
    function CheckWill(string WillUserIsChecking) {
        LastWillChecker = msg.sender;
        HashOfWillBeingChecked = sha3(WillUserIsChecking);   
        if (HashOfWillBeingChecked == HashOfWill) {
            WillIsCorrect = true;
        }else{
            WillIsCorrect = false;
        }
    }
}
