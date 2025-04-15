package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"sync"
)

func main() {
	fmt.Println(" Welcome to the Ride-Sharing System!")
	rideQueue := NewSharedRideQueue()
	scanner := bufio.NewScanner(os.Stdin)

	for {
		fmt.Print("\nEnter Ride ID: ")
		scanner.Scan()
		rideID, _ := strconv.Atoi(scanner.Text())

		fmt.Print("Enter Pickup Location: ")
		scanner.Scan()
		pickupLocation := scanner.Text()

		fmt.Print("Enter Dropoff Location: ")
		scanner.Scan()
		dropoffLocation := scanner.Text()

		fmt.Print("Enter Distance (in miles): ")
		scanner.Scan()
		distance, _ := strconv.ParseFloat(scanner.Text(), 32)

		ride := RideRequest{
			RideID:          rideID,
			PickupLocation:  pickupLocation,
			DropoffLocation: dropoffLocation,
			Distance:        float32(distance),
		}
		rideQueue.AddTask(ride)

		fmt.Print("\nWould you like to add another ride? (y/n): ")
		scanner.Scan()
		if strings.ToLower(scanner.Text()) != "y" {
			break
		}
	}

	// Launching 3 worker goroutines
	var wg sync.WaitGroup
	for i := 1; i <= 3; i++ {
		wg.Add(1)
		go RideWorker(&wg, rideQueue, fmt.Sprintf("Worker-%d", i))
	}

	wg.Wait()
	fmt.Println("\n All ride requests processed!")
}
