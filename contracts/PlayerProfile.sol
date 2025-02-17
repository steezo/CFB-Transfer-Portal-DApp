// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./libraries/DataTypes.sol";

contract PlayerProfile is Ownable, ReentrancyGuard {

    // State variables
    mapping(address => DataTypes.Player) public players;
    mapping(address => bool) public verifiedPlayers;
    address public owner;

    // Events
    event PlayerRegistered(address indexed playerAddress, string playerName);
    event PlayerVerified(address indexed playerAddress);
    event PlayerStatusUpdated(address indexed playerAddress, DataTypes.PlayerStatus newStatus);
    event PlayerYearUpdated(address indexed playerAddress, DataTypes.PlayerYear newYear);
    event EnteredTransferPortal(address indexed playerAddress, uint256 timestamp);
    event ExitedTransferPortal(address indexed playerAddress, uint256 timestamp);
    
    // Modifiers
    modifier onlyVerfiedPlayer() {
        require(verifiedPlayers[msg.sender], "Player not verified");
        _;
    }

    modifier playerExists() {
        require(players[msg.sender].playerAddress != address(0), "Player not registered");
        _;
    }

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Registration function
    function registerPlayer(
        string memory _name,
        string memory _bio,
        string memory _sport,
        string memory _position,
        string memory _currentSchool
    ) external {
        require(players[msg.sender].playerAddress == address(0), "Player already registered");
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(bytes(_sport).length > 0, "Sport cannot be empty");
        require(bytes(_position).length > 0, "Position cannot be empty");

        players[msg.sender] = DataTypes.Player({
            year: DataTypes.PlayerYear.Freshman,
            status: DataTypes.PlayerStatus.Available,
            playerAddress: msg.sender,
            available: true,
            playerName: _name,
            playerBio: _bio,
            sport: _sport,
            position: _position,
            currentSchool: _currentSchool,
            isInTransferPortal: false,
            timestamp: block.timestamp
        });
        emit PlayerRegistered(msg.sender, _name);
    }
    
    // Verification function (only by the owner)
    function verifyPlayer(address _playerAddress) external onlyOwner {
        require(players[_playerAddress].playerAddress != address(0), "Player not registered");
        require(!verifiedPlayers[_playerAddress], "Player already verified");

        verifiedPlayers[_playerAddress] = true;
        emit PlayerVerified(_playerAddress);
    }

    // Update player status function
    function updateStatus

}