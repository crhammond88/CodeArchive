from fix_function import *

#test jumpAndBackpedal
secrets = (7, 0, 1, 999)

def isMyNumber(guess):
    if guess < secret:
        return -1
    if guess == secret:
        return 0
    return 1

for i in range(len(secrets)):
    secret = secrets[i]
    passedj = True
    if secret != jumpAndBackpedal(isMyNumber):
        print("Failed jumpAndBackpedal: Test " + str(i + 1))
        passedj = False
if passedj:
    print("Passed jumpAndBackpedal!")


