package ridesharing;

import java.util.Scanner;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {
    public static void main(String[] args) {
        RideTaskQueue taskQueue = new RideTaskQueue();
        Scanner scanner = new Scanner(System.in);

        System.out.println(" Welcome to QuickRide - Ride Sharing System");
        char continueInput;

        do {
            try {
                System.out.print("\nEnter Booking ID: ");
                int bookingId = scanner.nextInt();
                scanner.nextLine();

                System.out.print("Enter Start Location: ");
                String start = scanner.nextLine();

                System.out.print("Enter End Location: ");
                String end = scanner.nextLine();

                System.out.print("Enter Distance (in miles): ");
                float distance = scanner.nextFloat();
                scanner.nextLine();

                RideBooking booking = new RideBooking(bookingId, start, end, distance);
                taskQueue.addTask(booking);

                System.out.print("Add another booking? (y/n): ");
                continueInput = scanner.next().charAt(0);
                scanner.nextLine();
            } catch (Exception e) {
                System.err.println("❗ Invalid input. Please try again.");
                scanner.nextLine(); // flush
                continueInput = 'y';
            }
        } while (continueInput == 'y' || continueInput == 'Y');

        scanner.close();

        ExecutorService executor = Executors.newFixedThreadPool(3);

        for (int i = 1; i <= 3; i++) {
            executor.execute(new BookingWorker(taskQueue, "Worker-" + i));
        }

        executor.shutdown();

        while (!executor.isTerminated()) {
            // Waiting for workers to finish
        }

        System.out.println("\n All bookings processed successfully!");
    }
}
