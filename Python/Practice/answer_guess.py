def form(x):
    return ((x-9)**2)-81

def answer(limit=100):
    test = -1
    guess = -limit
    answers = []
    while guess < limit:
        guess+=1
        test = ((guess-9)**2)-81
        if test == 0:
            answers.append(guess)
    return answers

def go():
    return answer(100)


    
def path(a,c, limit=100):
    test = -1
    guess = -limit
    while True:
        guess+=1
        test = (a**2)+guess**2-(c**2)
        if test == 0:
            break
        if guess > limit:
            return "FAILED"
    return guess   

def point(x):
    return x**2-(4.0*x)-3
