import pylab


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
    # wordList: list of strings
    wordList = []
    for line in inFile:
        wordList.append(line.strip().lower())
    print "  ", len(wordList), "words loaded."
    return wordList

def plotVowelProportionHistogram(wordList, numBins=15):
    """
    Plots a histogram of the proportion of vowels in each word in wordList
    using the specified number of bins in numBins
    """
    vowels = ['a','e','i','o','u','A','E','I','O','U']
    numVowels = []
    for word in wordList:
        num = 0
        for letter in word:
            if letter in vowels:
                num += 1
        numVowels.append(num)
    pylab.hist(numVowels, bins = numBins)
    pylab.title('Proportion of Vowels in Words')
    pylab.xlabel('Number of Vowels')
    pylab.ylabel('Number of Words')
    pylab.xlim(0,5)
    pylab.show()
    
    

if __name__ == '__main__':
    wordList = loadWords()
    plotVowelProportionHistogram(wordList)
