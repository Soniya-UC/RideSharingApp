package main

import (
	"fmt"
	"sync"
)

type SharedRideQueue struct {
	queue []RideRequest
	lock  sync.Mutex
}

func NewSharedRideQueue() *SharedRideQueue {
	return &SharedRideQueue{queue: make([]RideRequest, 0)}
}

func (q *SharedRideQueue) AddTask(ride RideRequest) {
	q.lock.Lock()
	defer q.lock.Unlock()
	q.queue = append(q.queue, ride)
	fmt.Println(" Task Added:", ride.GetDetails())
}

func (q *SharedRideQueue) GetTask() (RideRequest, bool) {
	q.lock.Lock()
	defer q.lock.Unlock()
	if len(q.queue) == 0 {
		return RideRequest{}, false
	}
	ride := q.queue[0]
	q.queue = q.queue[1:]
	return ride, true
}
