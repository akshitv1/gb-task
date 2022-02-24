pragma solidity ^0.4.24;

// import "/contracts/token/ERC721/StandardToken.sol";
// import "/contracts/lifecycle/Pausable.sol";

contract Auction {
    

    mapping (address => uint256) public etherContributed;
    uint32 public startDate = 1645714080; 
    uint32 public endDate = 1646059680;
    uint256 public currentBid;

    //canTransfer(msg.sender)
    // function transfer(address _to, uint256 _value) public canTransfer(msg.sender) returns (bool) {
    //     return super.transfer(_to, _value);
    // }
    // //canTransfer(_from)
    // function transferFrom(address _from, address _to, uint256 _value) public canTransfer(_from) returns (bool) {
    //     return super.transferFrom(_from, _to, _value);
    // }

    function getBidDetails(address _yourAddress) external view returns (uint256) {
        return(etherContributed[_yourAddress]);
    }

    function () external  auctionIsLive payable  {//saleIsonn whenNotPaused

        require(msg.value > currentBid);

        etherContributed[msg.sender] =  add(etherContributed[msg.sender], msg.value);
      
        currentBid = add(currentBid, msg.value);

    }

    function add(uint256 a, uint256 b) internal constant returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
      }
    //refund of ether if the softcap is not reached.
    //saleIsFinished softCapNotReached
    function refundEther(address _yourAddresss) external {

        uint256 value = etherContributed[_yourAddresss];
        etherContributed[_yourAddresss] = 0;
        _yourAddresss.transfer(value);
        
    }

    modifier auctionIsLive(){
        require((now > startDate) && (now < endDate));
        _;
    }

    function setDate(uint32 sd, uint32 ed) external returns (bool) {
        startDate = sd;
        endDate = ed;
        return true;
    }

}
