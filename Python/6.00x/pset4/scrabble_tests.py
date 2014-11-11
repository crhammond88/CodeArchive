from scrabble import *

##test hands
hand0 = {'f': 1, 'o': 2, 'b': 1, 'a': 1, 'r': 1}
hand1 = {'f': 0, 'o': 0, 'b': 0, 'a': 0, 'r': 0}
hand2 = {'f': 3, 'o': 2, 'b': 1, 'a': 1, 'r': 10, 'z': 0}
hand3 = {'h':1, 'i':1, 'c':1, 'z':1, 'm':2, 'a':1}
hand4 = {'w':1, 's':1, 't':2, 'a':1, 'o':1, 'f':1}
hand5 = {'n':1, 'e':1, 't':1, 'a':1, 'r':1, 'i':2}
#test inputs
testhands = (hand0, hand1, hand2, hand3, hand4, hand5)
handsizes = (6, 0, 17, 7, 7, 7)


##test isValidWord
def testValid(hands):
    wordList = ['foo', 'bar', 'foobar', 'fizzbuzz', 'pineapple']
    if len(hands) == 3:
        return "Passed isValidWord!"
    hand = hands[0] 
    if hand == hand1:
        if not isValidWord("", hand, wordList):
            return testValid(hands[1:])
    if ((isValidWord('foo', hand, wordList) == True) and (isValidWord('bar', hand, wordList) == True) and (isValidWord('foobar', hand, wordList) == True)):
        if((isValidWord('', hand, wordList) == False) and (isValidWord('apple', hand, wordList) == False) and (isValidWord('fob', hand, wordList) == False) and (isValidWord('fizzbuzz', hand, wordList) == False)):
            return testValid(hands[1:])
        return "Failed isValidWord: False"
    return "Failed isValidWord: True"

               
#test calculateHandlen
def testHandlen(hands, answers):
    if len(hands) == 0:
        return "Passed calculateHandlen!"
    if (calculateHandlen(hands[0]) == answers[0]):
        return testHandlen(hands[1:], answers[1:])
    return "Failed testHandlen:\nThe dict " + str(hands[0]) + " did not equal " + str(answers[0])

#test playHand
def testHand(hands, handsizes):
    wordList = loadWords()
    count = 0
    for i in hands:
        playHand(i, wordList, handsizes[count])
        count += 1
        print("\nTest playHand " + str(count) + " completed.\n")
    return "Finished tests for playHand!"

#perform tests
print testValid(testhands)
print testHandlen(testhands, handsizes)
print testHand(testhands, handsizes)
