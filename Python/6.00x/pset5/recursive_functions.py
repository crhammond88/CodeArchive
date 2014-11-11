import string

def reverseString(aStr):
#returns a reversed copy of the string
    #if string is empty
    if len(aStr) == 0:
        #return empty string
        return ''
    #else return last letter of string plus a recursive call with the string minus the last letter
    return aStr[len(aStr) - 1] + reverseString(aStr[:len(aStr) - 1])

def x_ian(x, word):
#returns True if all of the letters in x are contained in the same order in word
    #if x is empty
    if len(x) == 0:
        #return True
        return True
    #else if first letter of x not in word
    elif x[0] not in word:
        #return False
        return False
    #else, return a recursive call to check for the next letter of x in the unused portion of the word
    return x_ian(x[1:], word[word.find(x[0]):])

def insertNewlines(text, lineLength):
#returns a string with new lines inserted to match desired lineLength
#as closely as possible without breaking words
    #if text is less than or equal to lineLength
    if len(text) <= lineLength:
        #return text
        return text
    #establish point in text at desired lineLength
    count = lineLength - 1
    point = text[count]
    #if point is a letter or number
    if point.isalnum():
        #move ahead until after the next thing that isn't a letter or number
        while point.isalnum():
            count += 1
            point = text[count] 
    #continue moving until the start of the next word
    try:
        while not point.isalnum():
            count += 1
            point = text[count]
    except IndexError:
        return text
    #return text until point ending with new line plus a recursive call
    #for remaining text
    return text[:count] + '\n' + insertNewlines(text[count:],lineLength) 
