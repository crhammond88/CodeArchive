from scrabble import *

def isInHand (word, hand):
    ##returns True if word is in hand
    handCopy = hand.copy()##make a copy of hand
    ##check to see if word is in current hand
    for letter in word:
        if handCopy.get(letter, 0) < 1:
            return False
        handCopy[letter] -= 1
    return True

def compChooseWord(hand, wordList, n):
    ##Pseudocode credit MIT 6.00x
    # Create a new variable to store the maximum score seen so far (initially 0)
    score = 0
    # Create a new variable to store the best word seen so far (initially None)  
    word = None
    # For each word in the wordList
    for i in wordList:
        # If you can construct the word from your hand
        if isInHand(i, hand) == True:
            # Find out how much making that word is worth
            currentScore = getWordScore(i, n)
            # If the score for that word is higher than your best score
            if currentScore > score:
                # Update your best score, and best word accordingly
                score = currentScore
                word = i
    # return the best word you found.
    return word



def compPlayHand(hand, wordList, n):
    ##establish score variable
    score = 0
    ##while the hand still has letters
    while calculateHandlen(hand) > 0:
        ##choose word
        word = compChooseWord(hand, wordList, n)
        ##if no words remain
        if word == None:
            #end hand
            break
        ##display hand
        displayHand(hand)
        ##tell the user how many points the word earned and the updated total score
        points = getWordScore(word, n)
        score += points
        print("The word '" + word.upper() + "' was worth " + str(points) + " points! Total Score: " + str(score) + ".\n")
        ##update the hand 
        hand = updateHand(hand, word)
    ##tell user the total score
    print("Total Score: " + str(score) + "\n")
    return score


def playCompGame(wordList):
    while True:
        choice = raw_input("Enter n to deal a new hand, r to replay the last hand, or e to end game: ").lower()
        choice1 = raw_input("Enter u to play the hand yourself, or c for the computer to play the hand: ").lower()
        if (choice == 'n' and choice1 == 'u'):
            hand = dealHand(HAND_SIZE)
            playHand(hand, wordList, HAND_SIZE)
        elif (choice == 'r' and choice1 == 'u'):
            playHand(hand, wordList, HAND_SIZE)
        elif (choice == 'n' and choice1 == 'c'):
            hand = dealHand(HAND_SIZE)
            compPlayHand(hand, wordList, HAND_SIZE)
        elif (choice == 'r' and choice1 == 'c'):
            compPlayHand(hand, wordList, HAND_SIZE)         
        elif choice == 'e':
            print("Thanks for playing!")
            sys.exit()
        else:
            print("Invalid command. Please try again.")



##Play the game, but only if this file is executed directly
if __name__ == '__main__':
    wordList = loadWords()
    playCompGame(wordList)
