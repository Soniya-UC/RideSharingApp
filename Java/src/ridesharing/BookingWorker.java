package ridesharing;

import java.io.FileWriter;

import java.io.IOException;

public class BookingWorker implements Runnable {
    private final RideTaskQueue taskQueue;
    private final String workerId;

    public BookingWorker(RideTaskQueue queue, String workerId) {
        this.taskQueue = queue;
        this.workerId = workerId;
    }

    @Override
    public void run() {
        while (true) {
            RideBooking booking = taskQueue.getTask();
            if (booking == null) {
                System.out.println(workerId + " found no tasks. Exiting...");
                break;
            }

            System.out.println(workerId + " processing: " + booking.getInfo());

            try {
                Thread.sleep((int) (Math.random() * 3000 + 1000));

                logBooking(booking);
                System.out.println(workerId + " completed: " + booking.getInfo());
            } catch (InterruptedException e) {
                System.err.println(workerId + " was interrupted.");
                Thread.currentThread().interrupt();
                break;
            } catch (IOException e) {
                System.err.println(workerId + " failed to log: " + e.getMessage());
            }
        }
    }

    private void logBooking(RideBooking booking) throws IOException {
        try (FileWriter writer = new FileWriter("booking_log.txt", true)) {
            writer.write("Completed: " + booking.getInfo() + "\n");
        }
    }
}
