x = 45
y = 120


def gcdIter(a, b):
    answer = min(a, b)
    while ((a % answer + b % answer)) != 0:
        answer -= 1      
    return answer

print gcdIter(x, y)


def gcdRecur(a, b):
    if b == 0:
        return a
    return gcdRecur(b, a % b)

print gcdRecur(x, y)
