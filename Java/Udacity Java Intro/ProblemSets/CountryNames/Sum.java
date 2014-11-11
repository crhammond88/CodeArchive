public class Sum
{
   /**
    * Gets the sum of all the even numbers less than or equal to the given number
    * @param n the given number, the ceiling
    * @return the sum of all the even numbers less that the ceiling
    */
   public int sum(int n)
   {
       int i = 2;
       int sum = 0;
       while(i <= n)
       {
           sum += i;
           i += 2;
        }
       return sum;
   }
}