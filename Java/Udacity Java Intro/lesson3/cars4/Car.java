public class Car
{
    private double milesDriven;
    private double gasInTank;
    private Picture pic;

    public void drive(double distance)
    {
        milesDriven = milesDriven + distance;
        double milesPerGallon = 50;
        double gasConsumed = distance / milesPerGallon;
        gasInTank = gasInTank - gasConsumed;
        int pixelsPerMile = 10;
        pic.translate(distance * pixelsPerMile, 0);
    }

    public void addGas(double amount)
    {
        gasInTank = gasInTank + amount;
    }

    public double getMilesDriven()
    {
        return milesDriven;
    }

    public double getGasInTank()
    {
        return gasInTank;
    }

    public Car() // Discussed later
    {
        milesDriven = 0;
        gasInTank = 0;
        pic = new Picture("car.jpg");
        pic.draw();
    }
}
