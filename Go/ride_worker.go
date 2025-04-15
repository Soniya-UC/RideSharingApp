package main

import (
	"fmt"
	"math/rand"
	"os"
	"sync"
	"time"
)

func RideWorker(wg *sync.WaitGroup, queue *SharedRideQueue, workerName string) {
	defer wg.Done()
	for {
		ride, ok := queue.GetTask()
		if !ok {
			fmt.Println(workerName, "found no tasks, exiting...")
			return
		}

		fmt.Println(workerName, "processing:", ride.GetDetails())
		time.Sleep(time.Duration(rand.Intn(3000)+1000) * time.Millisecond)

		err := logRideCompletion(ride)
		if err != nil {
			fmt.Println(workerName, "failed to log completion:", err)
		} else {
			fmt.Println(workerName, "completed:", ride.GetDetails())
		}
	}
}

func logRideCompletion(ride RideRequest) error {
	f, err := os.OpenFile("ride_log.txt", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		return err
	}
	defer f.Close()
	_, err = f.WriteString("Completed: " + ride.GetDetails() + "\n")
	return err
}
