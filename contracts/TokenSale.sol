//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "./ERC20.sol";

contract TokenSale {
    address payable admin;
    ERC20 public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;
    
    event Sell(address _buyer, uint256 _amount);

    constructor (ERC20 _tokenContract, uint256 _tokenPrice) {
        admin = payable(address(msg.sender));
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function multiply(uint x, uint y) internal pure returns(uint256) {
        if(y==0) {
            return 0;
        }
        uint256 c = x * y;
        require( c / x == y );
        return c;
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require (msg.value == multiply(_numberOfTokens,tokenPrice));
        require (tokenContract.balanceOf(address(this)) >= _numberOfTokens);
        require (tokenContract.transfer(msg.sender , _numberOfTokens));

        tokensSold = _numberOfTokens;
        emit Sell(msg.sender, _numberOfTokens);

    }

    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
        selfdestruct(admin);
    }
}
