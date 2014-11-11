from scrabble_v2 import *

##set up test variables
wordList = loadWords()
words = ("appels","acta","immanent","tnnnt","wrong")
words0 = ("appels","acta","immanent","None","barf")
hand0 = {'a': 1, 'p': 2, 's': 1, 'e': 1, 'l': 1}
hand1 = {'a': 2, 'c': 1, 'b': 1, 't': 1}
hand2 = {'a': 2, 'e': 2, 'i': 2, 'm': 2, 'n': 2, 't': 2}
hand3 = {'x': 2, 'z': 2, 'q': 2, 'n': 2, 't': 2}
hand4 = {'f': 1, 'o': 2, 'b': 1, 'a': 1, 'r': 1}
answers = (True, True, True, False, False)
hands = (hand0, hand1, hand2, hand3, hand4)
sizes = (6, 5, 12, 12, 6)
scores = (110, 24, 105, 0, 36)

##test isInHand
def testInHand(words, hands, answers):
    if len(words) == 0:
        return "Passed isInHand test!\n"
    word = words[0]
    hand = hands[0]
    answer = answers[0]
    if (isInHand(word, hand) == answer):
        return testInHand(words[1:],hands[1:],answers[1:])
    return "Failed isInHand test on word " + word + "."


##test compChooseWord
def testChooseWord(hands, sizes, words):
    if len(words) == 0:
        return "Finished compChooseWord test!\n"
    word = words[0]
    hand = hands[0]
    size = sizes[0]
    print("Comp chooses: " + str(compChooseWord(hand, wordList, size)) + ".\nExpected word: " + word + ".")
    return testChooseWord(hands[1:],sizes[1:],words[1:])


##test compPlayHand
def testcompPlayHand(hands, sizes, scores):
    count = 0
    for i in hands:
        compPlayHand(i, wordList, sizes[count])
        print("Expected score: " + str(scores[count]))
        count += 1
        print("\nTest playHand " + str(count) + " completed.\n")
    return "Finished tests for playHand!"

    
print testInHand(words, hands, answers)
print testChooseWord(hands, sizes, words0)
print testcompPlayHand(hands, sizes, scores)
