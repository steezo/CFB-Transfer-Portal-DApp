// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "../libraries/DataTypes.sol";

contract TransferPortalStorage {
    // Main storage mappings
    mapping(address => DataTypes.PlayerProfile) internal players;
    mapping(address => DataTypes.College) internal colleges;
    mapping(uint256 => DataTypes.Offer) internal offers;

    // Index mappings for efficient queries
    mapping(string => address[]) internal playersBySport;
    mapping(string => address[]) internal collegesBySport;
    
    // Counter for offer IDs
    uint256 internal nextOfferId;

    // Arrays for iteration
    address[] internal allPlayers;
    address[] internal allColleges;
} 