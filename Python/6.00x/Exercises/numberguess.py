print("Please think of a number between 1 and 100.")

h = 100
l = 0

while h > 0:
    guess = (h + l)/2 
    print ("Is your secret number " + str(guess) + "?")
    check = raw_input("Enter 'h' to indicate the guess is too high. Enter 'l' to indicate the guess is too low. Enter 'c' to indicate I guessed correctly.")
    if check == 'h':
        h = guess
    elif check == 'l':
        l = guess
    elif check == 'c':  
        break
    else:
        print("I didn't understand that.")

print("Game over. Your secret number was: " + str(guess))
 
