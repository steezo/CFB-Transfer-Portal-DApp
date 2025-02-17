// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Library to hold all shared data structures
library DataTypes {
    // Options for the athlete's year.
    enum PlayerYear {
        Freshman,
        Sophomore,
        Junior,
        Senior
    }

    // Options for the athlete's status.
    enum PlayerStatus {
        Available, // Athlete is available to receive offers.
        Returning,  // Athlete is returning to the original college.
        Paused, // Athlete is taking a break.
        Evaluating, // Athlete has closed availability and evaluating offers.
        Committed // Athlete has accepted an offer and is no longer available to receive offers.
    }
    
    // Details about the athlete that is already registered.
    struct Player {
        PlayerYear year;  // using enum to represent year
        PlayerStatus status; // using enum to represent status
        address playerAddress;
        bool available;
        string playerName;
        string playerBio;
        string sport;
        string position;
        string currentSchool;
        bool isInTransferPortal;
        uint256 timestamp;
    }

    // Events
    event PlayerRegistered(address indexed playerAddress, string playerName);
    event PlayerVerified(address indexed playerAddress);
    event PlayerStatusUpdated(address indexed playerAddress, PlayerStatus newStatus);
    event PlayerYearUpdated(address indexed playerAddress, PlayerYear newYear);
    event EnteredTransferPortal(address indexed playerAddress, uint256 timestamp);
    event ExitedTransferPortal(address indexed playerAddress, uint256 timestamp);

    // Player/Athlete related structures
    struct PlayerProfile {
        string name;
        string bio;
        address walletAddress;
        bool isActive;
        PlayerDetails details;
        TransferStatus transferStatus;
    }

    struct PlayerDetails {
        string sport;
        string position;
        uint256 yearOfEligibility;
        string[] achievements;
        string[] stats;
    }

    struct TransferStatus {
        bool inPortal;
        uint256 entryDate;
        Status currentStatus;
        address committedTo;
    }

    // College related structures
    struct College {
        string name;
        string location;
        address walletAddress;
        bool isVerified;
        CollegeDetails details;
        mapping(string => SportProgram) sportPrograms;
    }

    struct CollegeDetails {
        string conference;
        string division;
        string[] accreditations;
        string website;
    }

    struct SportProgram {
        string sport;
        string headCoach;
        uint256 scholarshipsAvailable;
        bool isActive;
    }

    // Offer related structures
    struct Offer {
        address collegeAddress;
        address playerAddress;
        uint256 offerId;
        uint256 timestamp;
        OfferDetails details;
        OfferStatus status;
    }

    struct OfferDetails {
        string sport;
        uint256 scholarshipAmount;
        string[] terms;
        uint256 validUntil;
    }

    // Enums
    enum Status {
        Available,
        Reviewing,
        Committed,
        Signed
    }

    enum OfferStatus {
        Pending,
        Accepted,
        Declined,
        Expired,
        Withdrawn
    }
} 