Pseudocode Notes:
    1. Use simple language
    2. Use indentation
    3. Use keywords:
        BEGIN and END define sections.
        IF, ELSE, ENDIF for conditions.
        FOR, WHILE, DO for loops.
        INUPT and OUTPUT for user interaction.
        DEFINE to declare variables and functions.
        RETURN for function outputs.
    4. Avoid language-specific syntax

## Key Features

    1. Athletes can:
        - Register themselves
        - View offers from colleges
        - Accept valid offers
    2. Colleges can:
        - Register with detailed information
        - Make offers to athletes
        - Accept valid offers
    3. The System:
        - Maintains lists of all athletes and college
        - Handles transfer of funds
        - Emits events for important actions

## Data Structures

 - Enums
    enum athleteYear:
        Freshman
        Sophomore
        Junior
        Senior
        5th-Yr-Senior
        6th-Yr-Senior
    
    enum athleteStatus:
        Available
        Returning
        Paused
        Evaluating
        Committed

 - Structures
    struct Offer:
        amount: number
        expiration: timestamp
        active: boolean
        feedback: string

    struct College:
        collegeAddress: collegeAddress
        name: string
        historyData: string
        programStrengths: string
        alumniSuccess: string
    
    struct Athlete:
        year: athleteYear
        status: athleteStatus
        athleteAddress: address
        available: boolean
        offers: mapping(address => Offer)
        colleges: array of addresses
        athleteName: string
        athleteBio: string
        sport: string
        position: string

 - State Variables

    athetes: mapping(address => Athlete)
    colleges: mapping(address => College)
    athleteList: array of addresses
    collegeList: array of addresses

 - Events        

    AthleteRegistered(athlete: address)
    CollegeRegistered(college: address)
    OfferMade(college: address)
    OffeerModified(college: address, athlete: address, amount: number)
    OfferAccepted(athlete: address, college: address, amount: number)

## Functions

### Athlete functions
 
    function registerAthlete():
        IF athlete already registered at sender's address THEN
            throw error "Athlete already registered"

        Create new athlete at sender's address
        Set athlete.athleteAddress = sender's address
        // Assuming that every athlete begins as an incoming freshman.
        Set athlete.year = Freshman 
        Set athlete.status = Available
        Add sender's address to athleteList
        Emit AthleteRegistered event with sender's address
    
    function viewOffers() returns (addresses[], offers[]):
        Get athlete at sender's address
        count = length of athlete's array of colleges
        reate empty array offerList of size count

        FOR each college address in athlete's colleges:
            Add corresponding offer to offerList

        RETURN (athlete's colleges array, offerList)

    function acceptOfer(colegeAddress):
        Get athlete at sender's address
        Get offer from athlete's offers mapping using collegeAddress

        IF offer is not active THEN
            throw error "Offer is no longer active"

        IF athlete status is Committed THEN
            throw error "Athlete is already Committed"
        
        IF offer has expired THEN
            throw error "Offer has Expired"

        Transfer offer amount to athlete's address
        Set athlete.available = false
        Set offer.active = false
        Emit OfferAccepted event

    ## College Functions

    function registerCollege(name, historyData, programStrengths, alumniSuccess):
        Get college at sender's address
        IF college name is not empty THEN
            throw error "College already registered"

        Set college.collegeAddress = sender's address
        Set college.name = name
        Set college.historyData = historyData
        Set college.programStrengths = programStrengths
        Set college.alumniSucess = alumniSuccess
        Add sender's address to collegeList
        Emit CollegeRegistered event

    function makeOffer(athleteAddress, amount, expiration, feedback):
        IF sent value doesn't match amount THEN
            throw error "Sent value must match offer amount"

        Get athlete at athleteAddress

        IF athlete is not available THEN
            throw error "Athlete is not available"

        Create new offer in athlete's offers mapping
        Set offer.amount = amount
        Set offer.expiration = expiration
        Set offer.active = true
        Set offer.feedback = feedback
        Add sender's address to athlete's colleges array
        Emit OfferMade event

    function modifyOffer(athleteAddress, newAmount, newExpiration, feedback):
        Get athlete at athleteAddress
        Get existing offer from athlete's offers mapping

        IF offer is not active THEN
            throw "Offer is not active"
        
        IF newAmount > current offer amount THEN
            IF sent value doesn't  match difference THEN
                throw error "Additional funds required"
        ELSE IF newAmount < current offer amount THEN
            Transfer difference back to college
        
        Update offer with new values
        Emit OfferModified event

### Utility Functions

    function getCollegeInfo(collegeAddress) returns (College):
        RETURN college at collegeAddress

    function getAllColleges() returns (array of College):
        count = length of collegeList
        Create empty array collegeArray of size count

        FOR each address in collegeList:
            Add corresponding college to collegeArray

        RETURN collegeArray

### Special Functions

    function receive():
        Accept incoming Ether transfer
    
### Upcoming Features

    Athlete Dashboard
        - athlete data
        - college offers
        - cumulative offer total from colleges

    College Dashboard
        - college data
        - athletes in recruitment
        - cumulative offers to all athletes in recruitment
    
    System Dashboard
        - all athletes
        - all colleges
        - cumulative offers total
