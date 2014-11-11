/**
 * Models a person who makes and unmakes friends
 *
 */
public class Person
{
    private String name;
    private String friends; 
    private int x;
    private int y;

    // TODO: Update the person constructor to use the this reference
    //
    // For example, you update:
    // x = xCoord;
    // to
    // this.x = xCoord;
    //
    // HINT:
    // You can change the names of the input variables xCoord and yCoord
    // to x and y respectively. And you can assign them to this object's
    // and x and y coordinates by using the this reference. For example:
    // this.x = x;
    //
    // It looks a bit cleaner this way stylistically    
    public Person (String name, String pictureName, int xCoord, int yCoord)
    {
        this.name = name;
        friends = "";
        Picture picture = new Picture(pictureName);
        x = xCoord;
        y = yCoord;
        picture.translate(xCoord, yCoord);
        picture.draw();
    }

    public void addFriend(Person friend)
    {
        friends = friends + friend.name + " ";
        SmallCircle circle = new SmallCircle(x, y);
        circle.fill();
        Line line = new Line(x, y, friend.x, friend.y);
        line.draw();
    }

    public void unfriend(Person nonFriend)
    {
        friends = friends.replace(nonFriend.name, "");
    }

    public String getFriends()
    {
        return friends;
    }

}
