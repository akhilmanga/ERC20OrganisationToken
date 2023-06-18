// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract ERC20OrganisationToken is ERC20, Ownable {

struct Stakeholder {
    uint256 vestingPeriod;
    bool isWhiteListed;
}

mapping(address => Stakeholder) public stakeholders;

constructor (string memory name, string memory symbol) ERC20(name, symbol) {}

function setStakeholder(address _stakeholder, uint256 _vestingPeriod) public onlyOwner {

stakeholders[_stakeholder].vestingPeriod = _vestingPeriod;
stakeholders[_stakeholder].isWhiteListed = true;

}

function claimTokens(uint256 _amount) public {

require(stakeholders[msg.sender].isWhiteListed, "Address is not whitelisted!");
require(block.timestamp >= stakeholders[msg.sender].vestingPeriod, "vesting perios is not over!");

_mint(msg.sender, _amount);

}

}