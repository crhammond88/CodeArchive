
/**
 * Write a description of class Flower here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Flower
{
   
   private int x;
   private int y;
   
   public Flower(int theX, int theY)
   {
       x = theX;
       y = theY;
   }
   /**
   * This function draws the flower.
   */
   public void draw()
   {
       Ellipse top = new Ellipse(x + 20, y, 20,20);
       top.setColor(Color.PINK);
       top.fill();
       Ellipse mid = new Ellipse(x + 20, y - 20, 20,20);
       top.setColor(Color.YELLOW);
       top.fill();
   }
}
