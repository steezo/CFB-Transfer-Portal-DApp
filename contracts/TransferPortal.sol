// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransferPortal {

// Options for the athlete's year.
    enum athleteYear {
        Freshman,
        Sophomore,
        Junior,
        Senior
    }

    // Options for the athlete's status.
    enum athleteStatus{
        Available, // Athlete is available to recieve offers.
        Returning,  // Athlete is returning to the original college.
        Paused, // Athlete is taking a break.
        Evalulating, // Athlete has closed availability and evaluating offers.
        Committed // Athlete has accepted an offer and is no longer available to receive offers.
    }

    // Details of an offer from a college.
    struct Offer {
        uint256 amount;
        uint256 expiration;
        bool active;
        string feedback;
    }

    // Details about the college that is already registered.
    struct College {
        address collegeAddress;
        string name;
        string historyData;
        string programStrengths;
        string alumniSuccess;
        string coachingStaff;
    }

    // Details about the athlete that is already registered.
    struct Athlete {
        athleteYear year;  // using enum to represent year
        athleteStatus status; // using enum to represent status
        address athleteAddress;
        bool available;

        // Mapping of college addresses to offers.
        mapping(address => Offer) offers;
        address[] colleges;
        string athleteName;
        string athleteBio;
        string sport;
        string position;
    }

    // Mapping of addresses to athletes and colleges.
    mapping(address => Athlete) public athletes;
    mapping(address => College) public colleges;

    // Arrays of athlete and college addresses.
    address[] public athleteList;
    address[] public collegeList;

    // Events for logging actions.
    event AthleteRegistered(address athlete);
    event CollegeRegistered(address college);
    event OfferMade(address college, address athlete, uint256 amount);
    event OfferModified(address college, address athlete, uint256 amount);
    event OfferAccepted(address athlete, address college, uint256 amount);

    // Athlete functions
    function registerAthlete() public {
        Athlete storage athlete = athletes[msg.sender];
        require(!athlete.available, "Athlete already registered.");
        athlete.athleteAddress = msg.sender;
        athlete.year = athleteYear.Freshman;
        athlete.status = athleteStatus.Available;
        athleteList.push(msg.sender);
        emit AthleteRegistered(msg.sender);
    }

    // Function for athlete to view the offers from colleges.
    function viewOffers() public view returns (address[] memory, Offer[] memory) {
        Athlete storage athlete = athletes[msg.sender];
        uint256 count = athlete.colleges.length;
        Offer[] memory offerList = new Offer[](count);

        for (uint256 i = 0; i < count; i++) {
            address collegeAddr = athlete.colleges[i];
            offerList[i] = athlete.offers[collegeAddr];
        }
        return (athlete.colleges, offerList);
    }

    // Function for athlete to accept an offer from a college.  The Offer must be active and not expired.
    function acceptOffer(address collegeAddr) public {
        Athlete storage athlete = athletes[msg.sender];
        Offer storage offer = athlete.offers[collegeAddr];
        require(offer.active, "Offer is not active.");
        require(athlete.status == athleteStatus.Committed);
        require(offer.expiration >= block.timestamp, "Offer has expired.");

        // Transfer funds
        payable(msg.sender).transfer(offer.amount);

        // Update state
        athlete.available = false;
        offer.active = false;

        // Emit event noting that the offer was accepted.
        emit OfferAccepted(msg.sender, collegeAddr, offer.amount);
    }

    // College registration function.
    function registerCollege(
        string memory name,
        string memory historyData,
        string memory programStrengths,
        string memory alumniSuccess,
        string memory coachingStaff
    ) public {
        College storage college = colleges[msg.sender];
        require(bytes(college.name).length == 0, "College already registered.");
        college.collegeAddress = msg.sender;
        college.name = name;
        college.historyData = historyData;
        college.programStrengths = programStrengths;
        college.alumniSuccess = alumniSuccess;
        college.coachingStaff = coachingStaff;
        collegeList.push(msg.sender);
        emit CollegeRegistered(msg.sender);
    }

    // Function for a college to make an offer to the athlete.
    function makeOffer(
        address athleteAddr,
        uint256 amount,
        uint256 expiration,
        string memory feedback
    ) public payable {
        require(msg.value == amount, "Sent value must match offer amount.");
        Athlete storage athlete = athletes[athleteAddr];
        require(athlete.available, "Athlete is not available.");
        Offer storage offer = athlete.offers[msg.sender];
        offer.amount = amount;
        offer.expiration = expiration;
        offer.active = true;
        offer.feedback = feedback;
        athlete.colleges.push(msg.sender);
        emit OfferMade(msg.sender, athleteAddr, amount);
    }

    // Function for a college to modify an offer to an athlete.
    function modifyOffer(
        address athleteAddr,
        uint256 newAmount,
        uint256 newExpiration,
        string memory feedback
    ) public payable {
        Athlete storage athlete = athletes[athleteAddr];
        Offer storage offer = athlete.offers[msg.sender];
        require(offer.active, "Offer is not active.");

        // Colleges can Aajust the amount.
        if (newAmount > offer.amount) {
            require(msg.value == newAmount - offer.amount, "Additional funds required.");
        } else if (newAmount < offer.amount) {
            payable(msg.sender).transfer(offer.amount - newAmount);
        }

        // Update fields for the offer.
        offer.amount = newAmount;
        offer.expiration = newExpiration;
        offer.feedback = feedback;

        emit OfferModified(msg.sender, athleteAddr, newAmount);
    }

    // Utility functions
    function getCollegeInfo(address collegeAddr) public view returns (College memory) {
        return colleges[collegeAddr];
    }

    function getAllColleges() public view returns (College[] memory) {
        uint256 count = collegeList.length;
        College[] memory collegeArray = new College[](count);
        for (uint256 i = 0; i < count; i++) {
            collegeArray[i] = colleges[collegeList[i]];
        }
        return collegeArray; 
    }

    // Fallback function to receive Ether
    receive() external payable {}
}