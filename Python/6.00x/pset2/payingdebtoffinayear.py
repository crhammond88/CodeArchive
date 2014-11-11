balance = 330000
annualInterestRate = 0.2


mpr = annualInterestRate/12
pay = 0
bal = balance
count = 0

while bal > 0:
    bal = balance
    pay += 0.01
    month = 1
    while month < 13:
        month += 1    
        mup = bal - pay
        bal = mup + (mpr * mup)
    count += 1

print ("Guesses: " + str(count))
print ("Lowest payment: " + "%.2f" % pay)




