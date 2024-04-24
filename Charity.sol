// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract Charity {
    struct Donation {
        address donor;
        uint256 amount;
        uint256 timestamp;
    }

    address public owner;
    Donation[] public donations;
    mapping(address => bool) public beneficiaries;

    event DonationReceived(address indexed donor, uint256 amount);
    event FundsAllocated(address indexed beneficiary, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function donate() external payable {
        require(msg.value > 0, "Donation amount must be greater than 0");

        donations.push(Donation(msg.sender, msg.value, block.timestamp));
        emit DonationReceived(msg.sender, msg.value);
    }

    function allocateFunds(address[] calldata _beneficiaries, uint256[] calldata _amounts) external onlyOwner {
        require(_beneficiaries.length == _amounts.length, "Beneficiaries and amounts array length mismatch");

        for (uint256 i = 0; i < _beneficiaries.length; i++) {
            require(beneficiaries[_beneficiaries[i]], "Invalid beneficiary address");
            require(address(this).balance >= _amounts[i], "Insufficient contract balance");

            emit FundsAllocated(_beneficiaries[i], _amounts[i]);
        }
    }

    function addBeneficiary(address _beneficiary) external onlyOwner {
        beneficiaries[_beneficiary] = true;
    }

    function removeBeneficiary(address _beneficiary) external onlyOwner {
        beneficiaries[_beneficiary] = false;
    }

    function getDonationCount() external view returns (uint256) {
        return donations.length;
    }
}
