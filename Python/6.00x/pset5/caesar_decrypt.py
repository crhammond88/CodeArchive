from caesar_decrypt_help import * #helper code from MIT 6.00x
from caesar import *

def findBestShift(wordList, text):
#returns the best guess for a caesar shift key to decode the text
    #break text into list of words
    words = text.split(' ')
    #establish variables to check words
    high = 0
    answer = 0
    #for each possible shift (guess)
    for guess in range(1, 27):
        #establish vaild word counter for guess
        counter = 0        
        #for each word in words
        for word in words:
            #shift word by guess
            word = applyShift(word, guess)
            #if word in wordList
            if isWord(wordList, word):
                #add to counter
                counter += 1
        #if counter > high
        if counter > high:
            #high becomes counter
            high = counter
            #answer becomes current guess
            answer = guess
    #return answer
    return answer
    
        
        
def decryptStory():
#returns story in plain text
    #load wordList
    wordList = loadWords()
    #load story
    story = getStoryString()
    print story
    #return decrypted story
    return applyShift(story, findBestShift(wordList, story))



#run decryptStory if this file is executed directly
if __name__ == '__main__':
    print decryptStory()
