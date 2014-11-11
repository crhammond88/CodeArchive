from scrabble_v2 import *

def getInt(string):
    while True:
        #get desired number from user
        number = raw_input(string)
        #attempt to convert input to int
        try:
            #convert number to int
            number = int(number)
            #return the number
            return number
        #except error if not int
        except ValueError:
            #prompt the user to enter a viable number
            print("Please enter a number.")

def playBetterGame(wordList):
    #establish highscore variables
    highscore = 0
    highscorehands = 0
    #play until the user wants to stop
    while True:
        #establish variables for hands and scoring
        hands = 0
        score = 0
        compScore = 0
        #while hands is not 1 to 20
        while hands not in range(1,21):
           hands = getInt("Welcome! How many hands do you want to play? (Limit 20): ")
        #save starting hand number for highscore
        totalhands = hands
        #until hand size has been entered correctly
        while True:
            #get desired hand size from user
            HAND_SIZE = getInt("How many letters do you want in each hand? (Limit 5 - 25): ")
            if HAND_SIZE in range(5, 26):
                break
            print("Minimum 5 - Maximum 25")
        #while there are hands left to play
        while (hands > 0):
            print("Hands Remaining: " + str(hands) + "\n\nYou're turn!\n")
            #deal the hand for the turn
            hand = dealHand(HAND_SIZE)
            #user plays
            score += playHand(hand, wordList, HAND_SIZE)
            print("\nYOU: " + str(score) + " COMP: " + str(compScore) + "\n\n")
            print("It's the computer's turn!\n")
            #comp plays
            compScore += compPlayHand(hand, wordList, HAND_SIZE)
            print("\nYOU: " + str(score) + " COMP: " + str(compScore) + "\n\n")
            hands -= 1
        #if the player wins
        if score > compScore:
            print "YAY".center(60, '!')
            print("Congrats!!! You beat the computer! You're awesome!\n")
        #if they lose
        else:
            print("You lost to the epic computer. Don't blame yourself, you're only human!\n")
        #check highscore
        if score > highscore:
            #update highscore
            highscore = score
            highscorehands = totalhands
        print("Highest Score: " + str(highscore) + " in " + str(highscorehands) + " Hands with " + str(HAND_SIZE) + " letters.")
        #check to see if the user wants to play again
        playAgain = None
        while True:
            playAgain = raw_input("Would you like to play again? (Y or N): ").lower()
            #if they don't want to play again
            if playAgain == 'n':
                print("Thanks for playing!")
                #end game
                sys.exit()
            #if they do
            elif playAgain == 'y':
                #break loop to restart game
                break
            


#play the game, but only if this file is executed directly
if __name__ == '__main__':
    wordList = loadWords()
    playBetterGame(wordList)
