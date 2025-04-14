package ridesharing;

import java.util.LinkedList;
import java.util.Queue;
import java.util.concurrent.locks.ReentrantLock;

public class RideTaskQueue {
    private final Queue<RideBooking> bookings = new LinkedList<>();
    private final ReentrantLock queueLock = new ReentrantLock();

    public void addTask(RideBooking booking) {
        queueLock.lock();
        try {
            bookings.offer(booking);
            System.out.println(" Added: " + booking.getInfo());
        } finally {
            queueLock.unlock();
        }
    }

    public RideBooking getTask() {
        queueLock.lock();
        try {
            return bookings.poll();
        } finally {
            queueLock.unlock();
        }
    }

    public boolean isEmpty() {
        queueLock.lock();
        try {
            return bookings.isEmpty();
        } finally {
            queueLock.unlock();
        }
    }
}
