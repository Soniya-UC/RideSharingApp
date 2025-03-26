#include <iostream>
#include <string>
#include <vector>
#include <iomanip>

using namespace std;

class Ride {
protected:
    int rideID;
    string pickupLocation;
    string dropoffLocation;
    float distance;
    float fare;

public:
    Ride(int rideID, const string& pickupLocation, const string& dropoffLocation, float distance)
        : rideID(rideID), pickupLocation(pickupLocation), dropoffLocation(dropoffLocation), distance(distance), fare(0) {}

    virtual void calculateFare() = 0;  // Pure virtual function
    virtual void rideDetails() const {
        cout << "Ride ID: " << rideID << endl
             << "Pickup Location: " << pickupLocation << endl
             << "Dropoff Location: " << dropoffLocation << endl
             << "Distance: " << distance << " miles" << endl
             << "Fare: $" << fare << endl;
    }

    float getFare() const { return fare; }

    virtual ~Ride() = default;
};

// Derived class StandardRide
class StandardRide : public Ride {
public:
    StandardRide(int rideID, const string& pickupLocation, const string& dropoffLocation, float distance)
        : Ride(rideID, pickupLocation, dropoffLocation, distance) {}

    void calculateFare() override {
        fare = distance * 2;  // Standard rate: $2 per mile
    }
};

// Derived class PremiumRide
class PremiumRide : public Ride {
public:
    PremiumRide(int rideID, const string& pickupLocation, const string& dropoffLocation, float distance)
        : Ride(rideID, pickupLocation, dropoffLocation, distance) {}

    void calculateFare() override {
        fare = distance * 3;  // Premium rate: $3 per mile
    }
};

// Driver class
class Driver {
private:
    int driverID;
    string name;
    float rating;
    vector<Ride*> assignedRides;

public:
    Driver(int driverID, const string& name, float rating)
        : driverID(driverID), name(name), rating(rating) {}

    void addRide(Ride* ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        cout << "Driver ID: " << driverID << endl;
        cout << "Name: " << name << endl;
        cout << "Rating: " << rating << endl;
        cout << "Assigned Rides: " << assignedRides.size() << endl;

        float totalFare = 0;
        for (const auto& ride : assignedRides) {
            ride->rideDetails();
            totalFare += ride->getFare();  // Sum up the fares for all assigned rides
            cout << endl;
        }
        cout << "Total Fare for all assigned rides: $" << totalFare << endl;
    }

    const vector<Ride*>& getAssignedRides() const {
        return assignedRides;
    }

    ~Driver() {
        for (Ride* ride : assignedRides) {
            delete ride;
        }
    }
};

// Rider class
class Rider {
private:
    int riderID;
    string name;
    vector<Ride*> requestedRides;

public:
    Rider(int riderID, const string& name)
        : riderID(riderID), name(name) {}

    void requestRide(Ride* ride) {
        requestedRides.push_back(ride);
        cout << name << " has requested a ride!" << endl;
    }

    void viewRides() const {
        cout << "Ride History for " << name << ":" << endl;
        for (const auto& ride : requestedRides) {
            ride->rideDetails();
            cout << endl;
        }
    }

    ~Rider() {
        for (Ride* ride : requestedRides) {
            delete ride;
        }
    }
};

int main() {
    // Create driver and rider instances
    Driver driver1(1, "Soniya", 4.7);
    Driver driver2(2, "Padam", 4.9);

    Rider rider1(1, "Jack");
    Rider rider2(2, "Jill");

    int rideID;
    string pickupLocation, dropoffLocation;
    float distance;
    int rideType;
    char addAnotherRide;

    // Create a list to hold rides of different types (StandardRide, PremiumRide)
    vector<Ride*> rideList;

    // Request rides dynamically for rider 1
    cout << "Rider 1 is ready to request rides!" << endl;
    do {
        // Input for dynamic ride creation
        cout << "Enter Ride Type (1 for Standard, 2 for Premium): ";
        cin >> rideType;

        cout << "Enter Ride ID: ";
        cin >> rideID;
        cin.ignore();

        cout << "Enter Pickup Location: ";
        getline(cin, pickupLocation);

        cout << "Enter Dropoff Location: ";
        getline(cin, dropoffLocation);

        cout << "Enter Distance (in miles): ";
        cin >> distance;

        Ride* newRide = nullptr;

        // Create the ride based on user input
        if (rideType == 1) {
            newRide = new StandardRide(rideID, pickupLocation, dropoffLocation, distance);
        } else if (rideType == 2) {
            newRide = new PremiumRide(rideID, pickupLocation, dropoffLocation, distance);
        } else {
            cout << "Invalid choice!" << endl;
            continue;
        }

        // Calculate fare for the ride
        newRide->calculateFare();

        // Add the ride to the list of rides
        rideList.push_back(newRide);

        // Ask if the rider wants to request another ride
        cout << "Would you like to request another ride for this rider? (y/n): ";
        cin >> addAnotherRide;
        cin.ignore();

    } while (addAnotherRide == 'y' || addAnotherRide == 'Y');

    // View all requested rides for Rider 1
    rider1.viewRides();

    // Demonstrate polymorphism by calling fare() and rideDetails() on each ride in the list
    cout << "\nDemonstrating polymorphism for Rider 1's rides:\n";
    for (const auto& ride : rideList) {
        ride->rideDetails();   // Polymorphic call
        cout << "Fare: $" << ride->getFare() << endl << endl;
    }

    // Clean up allocated memory
    for (auto& ride : rideList) {
        delete ride;
    }

    return 0;
}