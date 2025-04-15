package main

import "fmt"

type RideRequest struct {
	RideID          int
	PickupLocation  string
	DropoffLocation string
	Distance        float32
}

func (r RideRequest) GetDetails() string {
	return fmt.Sprintf("Ride ID: %d, Pickup: %s, Dropoff: %s, Distance: %.2f miles",
		r.RideID, r.PickupLocation, r.DropoffLocation, r.Distance)
}
