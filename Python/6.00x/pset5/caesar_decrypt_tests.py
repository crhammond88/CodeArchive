from caesar_decrypt import *

wordList = loadWords()

#test findBestShift
bar = "Hello, how are you?"
bar1 = applyShift(bar, 25)
guessbar = findBestShift(wordList, bar1)
if guessbar == 1:
    print("Passed findBestShift Test 1!")
else:
    print("Failed findBestShift Test 1.\nCorrect: 1\nGuess: " + str(guessbar))


foo = 'Hello, world!'
foo1 = applyShift(foo, 8)
guessfoo = findBestShift(wordList, foo1)
foo2 = applyShift(foo1, guessfoo)
if foo2 == foo:
    print("Passed findBestShift Test 2!")
else:
    print("Failed findBestShift Test 2.\nCorrect: 18\nGuess: " + str(guessfoo) + "\nOriginal: " + foo + "\nCiphered: " +foo1 + "\nDecrypted:" + foo2)



words = "I've got a lovely bunch of coconuts! Here they are, standing in a row. Big ones, small ones, some the size of your head! Give em a twist, a flick of the wrist, that's what the showman said."
words1 = applyShift(words, 25)
guesswords = findBestShift(wordList, words1)
words2 = applyShift(words1, guesswords)
if words2 == words:
    print("Passed findBestShift Test 3!")
else:
    print("Failed findBestShift Test 3.\nGuess: " + str(guesswords) + "\nOriginal: " + words + "\nCiphered: " + words1 + "\nDecrypted:" + words2)
