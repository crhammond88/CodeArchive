balance = 5000
annualInterestRate = 0.2
monthlyPaymentRate = 0.04


bal = balance
mpr = annualInterestRate/12
month = 1
totalpay = 0

while month < 13:
    print ("Month: " + str(month))
    month += 1
    pay = monthlyPaymentRate * bal
    print ("Minimum monthly payment: " + ("%.2f" % pay))
    totalpay += pay
    mup = bal - pay
    bal = mup + (mpr * mup)
    print ("Remaining balance: " + ("%.2f" % bal))

print ("Total paid: " + ("%.2f" % totalpay))
print ("Remaining balance: " + ("%.2f" % bal))



