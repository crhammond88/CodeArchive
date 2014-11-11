a = 4
b = 7


def iterPower(base, exp):
    if exp == 0:
        return 1
    answer = base
    for i in range(exp - 1):
        answer *= base
        print(".")
    return answer

print iterPower(a, b) 
        

def recurPower(base, exp):
    print(".")
    if exp == 0:
        return 1
    else:
        return base * recurPower(base, exp - 1)

print recurPower(a, b) 


def recurPowerNew(base, exp):
    print(".")
    if exp == 0:
        return 1
    elif exp % 2 ==  0:
        return recurPowerNew(base * base, exp / 2)
    else:
        return base * recurPowerNew(base, exp - 1)

print recurPowerNew(a, b)
