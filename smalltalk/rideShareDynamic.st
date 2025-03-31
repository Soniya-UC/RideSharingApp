"----ACCEPT----2025-03-27T23:43:28.764969-05:00"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance fare |

    "Initialization of ride details"
    Ride class >> initializeRideID: anID pickup: aPickup dropoff: aDropoff distance: aDistance [
        rideID := anID.
        pickupLocation := aPickup.
        dropoffLocation := aDropoff.
        distance := aDistance.
        fare := 0.
    ]

    "Calculate fare (default implementation)"
    Ride class >> fare [
        fare := distance * 2. "Default fare calculation: $2 per mile"
    ]

    "Display ride details"
    Ride class >> rideDetails [
        'Ride ID: ', rideID printOn: ' ', 'Pickup Location: ', pickupLocation printOn: ' ',
        'Dropoff Location: ', dropoffLocation printOn: ' ',
        'Distance: ', distance printOn: ' miles',
        ' Fare: $', fare printOn: ''.
    ]
]

"Specific Ride Subclasses"
Object subclass: StandardRide [
    "Overriding fare calculation"
    StandardRide class >> fare [
        fare := distance * 2. "Standard rides cost $2 per mile"
    ]
]

Object subclass: PremiumRide [
    "Overriding fare calculation"
    PremiumRide class >> fare [
        fare := distance * 3. "Premium rides cost $3 per mile"
    ]
]

"Driver Class"
Object subclass: Driver [
    | driverID name rating assignedRides |

    "Initialize driver with ID, name, rating"
    Driver class >> initializeDriver: anID name: aName rating: aRating [
        driverID := anID.
        name := aName.
        rating := aRating.
        assignedRides := OrderedCollection new.
    ]

    "Add a ride to the driver's ride list"
    Driver class >> addRide: aRide [
        assignedRides add: aRide.
    ]

    "Get driver info and display completed rides"
    Driver class >> getDriverInfo [
        'Driver ID: ', driverID printOn: ' ', 'Name: ', name printOn: ' ', 'Rating: ', rating printOn: ''.
        assignedRides do: [:ride |
            ride rideDetails.
            ' ' printOn: ''.
        ].
    ]
]

"Rider Class"
Object subclass: Rider [
    | riderID name requestedRides |

    "Initialize rider with ID and name"
    Rider class >> initializeRider: anID name: aName [
        riderID := anID.
        name := aName.
        requestedRides := OrderedCollection new.
    ]

    "Request a ride (add ride to the requested list)"
    Rider class >> requestRide: aRide [
        requestedRides add: aRide.
        'Ride requested by: ', name printOn: ' '.
    ]

    "View requested rides history"
    Rider class >> viewRides [
        'Ride History for ', name printOn: ': '.
        requestedRides do: [:ride |
            ride rideDetails.
            ' ' printOn: ''.
        ].
    ]
]

"System Demonstration"
| driver1 rider1 ride1 ride2 ride3 |
driver1 := Driver new initializeDriver: 1 name: 'John' rating: 4.7.
rider1 := Rider new initializeRider: 1 name: 'Alice'.

"Creating Rides"
ride1 := StandardRide new initializeRideID: 101 pickup: 'Park' dropoff: 'Airport' distance: 10.
ride2 := PremiumRide new initializeRideID: 102 pickup: 'Mall' dropoff: 'Hotel' distance: 5.
ride3 := StandardRide new initializeRideID: 103 pickup: 'Station' dropoff: 'Library' distance: 8.

"Rider requesting rides"
rider1 requestRide: ride1.
rider1 requestRide: ride2.
rider1 requestRide: ride3.

"Driver adding rides to their list"
driver1 addRide: ride1.
driver1 addRide: ride2.
driver1 addRide: ride3.

"Demonstrate Polymorphism"
rider1 viewRides.

driver1 getDriverInfo.

"Invoke fare and rideDetails polymorphically"
| rides |
rides := OrderedCollection with: ride1 with: ride2 with: ride3.

rides do: [:ride |
    ride fare. "Calculates fare based on the type of ride (Standard or Premium)"
    ride rideDetails. "Displays ride details"
].

