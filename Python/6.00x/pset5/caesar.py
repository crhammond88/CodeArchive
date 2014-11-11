import string

def buildCoder(shift):
#returns dict of letters(key) matched to cipher letters(value)
    #establish letters, seperating upper from lower for wrap around
    lettersL = tuple(string.ascii_lowercase)
    lettersU = tuple(string.ascii_uppercase)
    letters = (lettersL, lettersU)
    #create dict
    cipher = {}
    #build dict with shifted letters
    #for each case of letters
    for case in letters:
        #for each letter in the case          
        for i in range(len(case)):
            cipher[case[i]] = case[(i + shift) % 26]
    #return dict
    return cipher


def applyCoder(text, coder):
#returns text as ciphertext using coder
    #establish variable for ciphered text
    cipherText = ''
    #for each letter in text
    for i in text:
        #if it's a real letter
        if i.isalpha():
            #add ciphered letter to cipherText
            cipherText += coder[i]
        #if it's not
        else:
            #add original character
            cipherText += i
    #return cipherText
    return cipherText

def applyShift(text, shift):
#returns text as ciphertext using shift as the input to buildCoder
#wrapper function for applyCoder and buildCoder
    #return ciphered text
    return applyCoder(text, buildCoder(shift))


