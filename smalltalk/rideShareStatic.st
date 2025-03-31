"------ Ride Class ------"

Object subclass: Ride [
    | id from to miles |

    Ride class >> createWith: rideId from: start to: destination distance: dist [
        ^ self new setupWith: rideId from: start to: destination distance: dist.
    ]

    setupWith: rideId from: start to: destination distance: dist [
        id := rideId.
        from := start.
        to := destination.
        miles := dist.
        ^ self.
    ]

    fareAmount [
        self subclassResponsibility
    ]

    printDetails [
        Transcript show: 'ID: ', id printString; cr.
        Transcript show: 'Start: ', from; cr.
        Transcript show: 'End: ', to; cr.
        Transcript show: 'Miles: ', miles printString; cr.
    ]
]

"--- Standard Ride Implementation ---"
Ride subclass: RegularRide [
    fareAmount [
        ^ miles * 2
    ]

    printDetails [
        super printDetails.
        Transcript show: 'Type: Regular'; cr.
        Transcript show: 'Cost: $', (self fareAmount) printString; cr; cr.
    ]
]

"--- Premium Ride Implementation ---"
Ride subclass: LuxuryRide [
    fareAmount [
        ^ miles * 3
    ]

    printDetails [
        super printDetails.
        Transcript show: 'Type: Premium'; cr.
        Transcript show: 'Cost: $', (self fareAmount) printString; cr; cr.
    ]
]

"--- Driver Class ---"
Object subclass: Chauffeur [
    | driverId fullName score rides |

    Chauffeur class >> register: id named: name rated: rating [
        ^ self new initializeWith: id name: name rating: rating.
    ]

    initializeWith: id name: name rating: rating [
        driverId := id.
        fullName := name.
        score := rating.
        rides := OrderedCollection new.
        ^ self.
    ]

    assign: aRide [
        rides add: aRide.
    ]

    showDriverDetails [
        Transcript show: '--- Driver Profile ---'; cr.
        Transcript show: 'ID: ', driverId printString; cr.
        Transcript show: 'Name: ', fullName; cr.
        Transcript show: 'Rating: ', score printString; cr.
        Transcript show: 'Rides Assigned: ', rides size printString; cr; cr.
        rides do: [:r | r printDetails].
    ]
]

"--- Rider Class ---"
Object subclass: Passenger [
    | userId riderName myRides |

    Passenger class >> onboard: id named: name [
        ^ self new setup: id name: name.
    ]

    setup: id name: name [
        userId := id.
        riderName := name.
        myRides := OrderedCollection new.
        ^ self.
    ]

    book: aRide [
        myRides add: aRide.
    ]

    viewHistory [
        Transcript show: '----- Rider Info -----'; cr.
        Transcript show: 'Id: ', userId printString; cr.
        Transcript show: 'Name: ', riderName; cr.
        Transcript show: 'Bookings: ', myRides size printString; cr; cr.
        myRides do: [:r | r printDetails].
    ]
]

"--- Execution Script ---"
| ride1 ride2 driver rider |

ride1 := RegularRide createWith: 101 from: 'Downtown' to: 'Airport' distance: 10.
ride2 := LuxuryRide createWith: 102 from: 'Cinema' to: 'University' distance: 14.

driver := Chauffeur register: 1 named: 'Dave Jon ' rated: 4.8.
driver assign: ride1.
driver assign: ride2.

rider := Passenger onboard: 1001 named: 'Soniya'.
rider book: ride1.
rider book: ride2.

driver showDriverDetails.
Transcript cr.
rider viewHistory.