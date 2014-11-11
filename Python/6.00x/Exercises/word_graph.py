import pylab
import collections

wordList = []

inFile = open('words.txt')
for line in inFile:
    words = line.split(' ')
    for word in words:
        if word != '\n':
            wordList.append(word.lower())


def producePlot(wordList):
    letterDict = {'a':0, 'b':0, 'c':0, 'd':0, 'e':0, 'f':0, 'g':0, 'h':0, 'i':0, \
                  'j':0, 'k':0, 'l':0, 'm':0, 'n':0, 'o':0, 'p':0, 'q':0, 'r':0, \
                  's':0, 't':0, 'u':0, 'v':0, 'w':0, 'x':0, 'y':0, 'z':0}
    for word in wordList:
        letterDict[word[0]] += 1
    letterFreq = collections.OrderedDict(sorted(letterDict.items()))
    pylab.figure(1)
    pylab.plot(range(1,27), letterFreq.values(), 'r.')
    pylab.plot(range(1,27), letterFreq.values(), 'b-.')
    x = 1
    for letter in letterFreq.keys():
        y = letterFreq[letter]
        pylab.annotate(letter.upper(), (x, y),(x + 0.25, y - 100))
        x += 1
    letterList = letterFreq.keys()
    assert type(letterList) is list
    xlabels =[' ']
    xlabels.extend(letterList)
    print xlabels
    pylab.xticks(range(27), xlabels, rotation = -25)
    pylab.title('Frequency of English Words Beginning with Letter')
    pylab.xlabel('Letters of the English Alphabet')
    pylab.ylabel('Number of Words Starting with Letter')
    pylab.show()


producePlot(wordList)
