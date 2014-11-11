public class CountryNames
{
    /**
     * Gets the name with the proper article
     * @param name the country name
     * @return the name prepended with the proper article
     */
    public String getCompleteName(String name)
    {

         //your code goes here
        String cname = name;
        System.out.println(name.substring(0,0));
        if ("aeiouAEIOU".contains(name.substring(0,1)));
        {
            cname = "l'" + name;
        }
        return cname;
            
    }

}
