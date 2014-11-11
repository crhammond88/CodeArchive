public class Person
{
    private String name;
    private String friends;

    public Person(String aName)
    {
        name = aName;
        friends = "";
    }

    public void addFriend(Person friend)
    {
        friends = friends + " " + friend.name;
    }

    public void unfriend(Person nonFriend)
    {
        friends = friends.replace(" " + nonFriend.name, "");
    }
}
