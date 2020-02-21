pragma solidity >=0.4.22 <0.6.0;

contract MarvelShop {
    
    
    struct MarvelCharacter{
        uint id;
        string name;
        uint256 priceTag;
        address owner;
        string imagePath;
        bool haveOwner;
    }
    
    uint C_ID = 0;
    
    uint[] collectionMarvelCharaterId;
    mapping (uint => MarvelCharacter) marvelCharacter;
    event PurchaseCharacterErrorLog(address indexed buyer,string reason);
    event SoldCharacter(address indexed buyer,uint id);

    
    function addCharacter(string memory name,uint256 priceTag ,string memory imagePath) public returns(uint id){
        uint Id = C_ID++;
        
        marvelCharacter[Id] = MarvelCharacter(Id,name, priceTag, address(0x0000000000000000000000000000000000000000), imagePath,false);
        collectionMarvelCharaterId.push(Id);
        
        return Id;
    }
    
    function sellCharacter(uint id) public payable returns(bool){
        if(msg.value != marvelCharacter[id].priceTag){
            emit PurchaseCharacterErrorLog(msg.sender,"Error, invalid value !!");
            msg.sender.transfer(msg.value);
            return false;
        }
        
        if(marvelCharacter[id].haveOwner){
            emit PurchaseCharacterErrorLog(msg.sender,"Error, this character is have owner!!");
            msg.sender.transfer(msg.value);
            return false;
        }
        
         marvelCharacter[id].owner = msg.sender;
         marvelCharacter[id].haveOwner = true;
        emit SoldCharacter(msg.sender,id);
        
        return true;
    }
    
    function getChracterById(uint Id) public view returns(uint,string memory,uint256,address,string memory,bool){
        return (marvelCharacter[Id].id,marvelCharacter[Id].name,marvelCharacter[Id].priceTag,marvelCharacter[Id].owner,marvelCharacter[Id].imagePath,marvelCharacter[Id].haveOwner);
    }
    
    function getAllCharacter() public view returns(uint[] memory){
        return collectionMarvelCharaterId;
    }
    
    function getNextValId() public view returns(uint){
        return C_ID;
    }
    
}






