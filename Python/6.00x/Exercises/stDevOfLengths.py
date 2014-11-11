def stdDevOfLengths(L):
    """
    L: a list of strings

    returns: float, the standard deviation of the lengths of the strings,
      or NaN if L is empty.
    """
    if L == []:
        return float('NaN')
    strLens = []
    for string in L:
        strLens.append(len(string))
    average = sum(strLens)/float(len(L))
    results = 0.00
    for strLen in strLens:
        results += (strLen - average)**2
    return (results/len(L))**0.5





L = ['a', 'z', 'p']
print stdDevOfLengths(L), 'should return 0'

L = ['apples', 'oranges', 'kiwis', 'pineapples']
print stdDevOfLengths(L), 'should return 1.8708'

L = []
print stdDevOfLengths(L), 'should return NaN'



def coeOfNums(L):
    """
    L: a list of strings

    returns: float, the standard deviation of the lengths of the strings,
      or NaN if L is empty.
    """
    average = sum(L)/float(len(L))
    results = 0.00
    for num in L:
        results += (num - average)**2
    return ((results/len(L))**0.5)/average

L = [10, 4, 12, 15, 20, 5]
print coeOfNums(L)
