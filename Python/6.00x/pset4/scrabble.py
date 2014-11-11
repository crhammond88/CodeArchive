from scrabble_help import * ##helper code from MIT 6.00x
import sys



def getWordScore(word, n):
##returns the score of a word for a hand of size n
    score = 0
    ##sum the letter values
    for letter in word:
        score += SCRABBLE_LETTER_VALUES[letter]
    ##multiply by word length
    score *= len(word)
    ##check for bonus points
    if len(word) == n:
        ##add bonus points
        score += 50
    return score


def updateHand(hand, word):
##returns hand minus word
    handCopy = hand.copy() ##make a copy of hand
    for letter in word:
        handCopy[letter] -= 1
    return handCopy


def isValidWord(word, hand, wordList):
##returns True if word is in hand and wordList
    handCopy = hand.copy()##make a copy of hand
    ##check to see if word is real
    if word in wordList:
        ##check to see if word is in current hand
        for letter in word:
            if handCopy.get(letter, 0) < 1:
                return False
            handCopy[letter] -= 1
        return True
    return False



def calculateHandlen(hand):
    return sum(hand.values())

def playHand(hand, wordList, n):
    ##Psuedocode credit MIT 6.00x
    # Keep track of the total score
    score = 0
    # As long as there are still letters left in the hand:
    while calculateHandlen(hand) > 0:
        # Display the hand
        displayHand(hand)
        # Ask user for input
        word = raw_input("Enter a word or '.' to quit:")
        # If the input is a single period:
        if word == '.':
            # End the game (break out of the loop)
            break
        # Otherwise (the input is not a single period):
        else:
            # If the word is not valid:
            if not isValidWord(word, hand, wordList):
                # Reject invalid word (print a message followed by a blank line)
                print("That was not a valid word.\n")
            # Otherwise (the word is valid):
            else:
                # Tell the user how many points the word earned, and the updated total score
                points = getWordScore(word, n)
                score += points
                print("The word '" + word.upper() + "' was worth " + str(points) + " points! Score: " + str(score) + ".\n")
                # Update the hand 
                hand = updateHand(hand, word)
    # Game is over (user entered a '.' or ran out of letters), so tell user the total score
    print("\nTotal Score: " + str(score) + "\n")
    return score



def playGame(wordList):
    while True:
        choice = raw_input("Enter n to deal a new hand, r to replay the last hand, or e to end game: ").lower()
        if choice == 'n':
            hand = dealHand(HAND_SIZE)
            playHand(hand, wordList, HAND_SIZE)
        elif choice == 'r':
            playHand(hand, wordList, HAND_SIZE)
        elif choice == 'e':
            print("Thanks for playing!")
            sys.exit()
        else:
            print("Invalid command. Please try again.")

##Play the game, but only if this file is executed directly
if __name__ == '__main__':
    wordList = loadWords()
    playGame(wordList)
