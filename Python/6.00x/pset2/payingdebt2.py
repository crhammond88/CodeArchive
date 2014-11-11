balance = 330000
annualInterestRate = 0.2


mpr = annualInterestRate/12
bal = balance
l = bal/12
h = (bal * (1 + mpr)**12)/12
epsilon = 0.01
count = 0

while abs(bal) > epsilon :
    pay = (l + h) / 2
    bal = balance
    month = 1
    while month < 13:
        month += 1    
        mup = bal - pay
        bal = mup + (mpr * mup)
    count += 1
    if bal > 0:
        l = pay
    elif bal < 0:
        h = pay
        
print ("Guesses: " + str(count))
print ("Lowest payment: " + "%.2f" % pay)
