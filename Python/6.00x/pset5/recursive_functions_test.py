from recursive_functions import *


#test reverseString
strings = ('apples', 'pineapples', '', 'a', 'race car', 'desserts', 'O hai! How are you?')
rstrings = ('selppa', 'selppaenip', '', 'a', 'rac ecar', 'stressed', '?uoy era woH !iah O')
passed = True

for i in range(len(strings) - 1):
    if strings[i] != reverseString(rstrings[i]):
        print("Failed reverseString on test " + str(i + 1))
        passed = False
if passed == True:
    print("Passed reverseString!")
        


#test x_ian
xs = ('eric', 'john', 'alvin', 'sarina', 'a','','word', 'tim')
words = ('algebraic', 'mahjong', 'palavering', 'czarina', 'apple', 'string','word','tick')
answers = (True, False, True, False, True, True, True, False)
passedx = True

for i in range(len(xs) - 1):
    if x_ian(xs[i], words[i]) != answers[i]:
        print("Failed x_ian on test " + str(i + 1))
        passedx = False
if passedx == True:
    print("Passed x_ian!")
    

print '\n\n'


#test insertNewlines
str1 = 'While I expect new intellectual adventures ahead, nothing will compare to the exhilaration of the world-changing accomplishments that we produced together.'
str2 = 'Nuh-uh! We let users vote on comments and display them by number of votes. Everyone knows that makes it impossible for a few persistent voices to dominate the discussion.'
str3 = 'Tiny DOOM!'
str4 = 'Hello, bug!'
strs = (str1, str2, str3, str4)
numbers = (15, 20, 50, 1)

for i in range(len(strs)):
    print insertNewlines(strs[i],numbers[i]) + '\n\n'
