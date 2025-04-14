package ridesharing;

public class RideBooking {
    private final int bookingId;
    private final String startLocation;
    private final String endLocation;
    private final float miles;

    public RideBooking(int bookingId, String startLocation, String endLocation, float miles) {
        this.bookingId = bookingId;
        this.startLocation = startLocation;
        this.endLocation = endLocation;
        this.miles = miles;
    }

    public String getInfo() {
        return "Booking ID: " + bookingId + ", From: " + startLocation + ", To: " + endLocation + ", Distance: " + miles + " miles";
    }
}
