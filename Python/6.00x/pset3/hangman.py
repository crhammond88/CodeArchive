import sys

# -----------------------------------
# Helper code (MIT 6.00x)

import random
import string

WORDLIST_FILENAME = "words.txt"
def loadWords():
    """
    Returns a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print "Loading word list from file..."
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r', 0)
    # line: string
    line = inFile.readline()
    # wordlist: list of strings
    wordlist = string.split(line)
    print "  ", len(wordlist), "words loaded."
    return wordlist

def chooseWord(wordlist):
    """
    wordlist (list): list of words (strings)

    Returns a word from wordlist at random
    """
    return random.choice(wordlist)

wordlist = loadWords()

# end of helper code
# -----------------------------------



def isGuessed(secretWord, lettersGuessed):
    for i in secretWord:
        if i not in lettersGuessed:
            return False
    return True

def printGuessed(secretWord, lettersGuessed):
        graphic = []
        for i in secretWord:
            if i in lettersGuessed:
                graphic.append(str(i))
            else:
                graphic.append(" _")
        print "".join(graphic)


def playAgain (wins, conWins):
    print("Totals Wins: " + str(wins) + "\nConsecutive Wins: " + str(conWins) + "\n\n\n")
    play = ""
    while (play != 'Y') and (play != 'N'):
        play = raw_input("Would you like to play again? (Y or N): ").upper()
    if play == 'Y':
        return True
    else:
        return False


def endGame():
    print("Thanks for playing!")
    sys.exit()

def hangman():
    wins = 0
    conWins = 0 ##consecutive wins

    while True:

        secretWord = chooseWord(wordlist)
        letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
        lettersGuessed = []
        guesses = 5 + (len(secretWord)/2)

        
        print("\n\nLet's play Hangman!\nThe word is " + str(len(secretWord)) + " letters long.\n\n")

        while True:
            if isGuessed(secretWord, lettersGuessed) == True:
                ##increase WINS and conWins
                wins += 1
                conWins += 1
                ##print secret word and victory message
                print(((secretWord.center(30, '*')).center((75 - len(secretWord)),'-')).upper() + "\n\n\nVictory is yours! Congrats!\n\n")
                ##ask the user if the want to play again
                play = playAgain(wins, conWins)
                if play == True:
                    break
                else:
                    endGame()

            elif guesses == 0:
                ##reset conWins
                conWins = 0
                print("Game Over\n\n\nThe word was " + secretWord.upper() + ".\nFailure is just an opportunity to improve! Please play again.\n\n")
                play = playAgain(wins, conWins)
                if play == True:
                    break
                else:
                    endGame()
            else:
                print("Letters available: " + "".join(letters))
                print("Guesses remaining: " + str(guesses))
                printGuessed(secretWord, lettersGuessed)
                while True:
                    guess = raw_input("Please guess a letter: ")
                    if guess.isalpha() and len(guess) == 1:
                        guess.lower()
                        if guess not in letters:
                            print("You've already guessed that letter!")
                        elif guess in secretWord:
                            print("\n\nYou found one!\n\n")
                            lettersGuessed.append(guess)
                            letters.remove(guess)
                            break
                        else:
                            print("\n\nSorry, that letter isn't in the word!\n\n")
                            letters.remove(guess)
                            guesses -= 1
                            break


            
            
        
hangman()

     

