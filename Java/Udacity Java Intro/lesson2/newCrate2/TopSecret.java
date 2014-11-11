// BlueJ project: lesson2/crate2

public class TopSecret
{
    public static void main(String[] args)
    {
        Rectangle frontFace = new Rectangle(20, 30 ,100, 40);
        Line leftLine = new Line(20, 30, 50, 10);
        Line topLine = new Line(50, 10, 150, 10);
        Line middleLine = new Line(120, 30, 150, 10);
        Line rightLine = new Line(150, 10, 150, 50);
        Line bottomLine = new Line(120, 70, 150, 50);

        frontFace.draw();
        leftLine.draw();
        topLine.draw();
        middleLine.draw();
        rightLine.draw();
        bottomLine.draw();
        
        Text secret = new Text(20, 30, "TOP SECRET");
        secret.draw();
    }
}
