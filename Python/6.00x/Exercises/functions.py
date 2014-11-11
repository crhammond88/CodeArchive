a = {'a':[1],'b':[2,7,5,6,7,8,9],'c':[3],'d':[4],'e':[5,6,7,8,9]}
b = {'b':[]}
def lenIter (aStr):
    count = 0
    for c in aStr:
        count += 1
    return count



def lenRecur (aStr):
    if aStr == '':
        return 0
    else:
        return 1 + lenRecur(aStr[1:])



def isIn (char, aStr):
    if aStr == '':
        return False
    l = 0
    h = len(aStr) - 1
    num = abs((l+h)/2)
    guess = aStr[num]
    
    if char == guess:
        return True
    elif char > guess:
            return isIn(char, aStr[num + 1:])
    elif char < guess:
            return isIn(char, aStr[:num])


def oddTuples (aTup):
    return aTup[::2]



def howMany(aDict):
    count = 0
    for value in aDict.values():
        count += (len(value))
    return count
                  

def biggest(aDict):
    result = None
    size = -1
    for key in aDict:
        if size < len(aDict[key]):
            size = len(aDict[key])
            result = key
    return result
        

    
print biggest(b)
