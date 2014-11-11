/**
 * Models a person who makes and unmakes friends
 *
 */
public class Person
{
    private String name;
    private String friends;
    private int numFriends;


    public Person (String aName)
    {
        name = aName;
        friends = "";
        numFriends = 0;
    }
    

    public void addFriend(Person friend)
    {
        friends = friends + friend.name + " ";
        numFriends = numFriends + 1;
    }


    public void unfriend(Person nonFriend)
    {
        friends = friends.replace(nonFriend.name, "");
    }

    /**
     * Returns a summary of the Person's friends
     * @return the names of friens separated by spaces
     */
    public String getFriends()
    {
        return friends;
    }
    
    public int getNumberOfFriends()
    {
        return numFriends;
    }

}
