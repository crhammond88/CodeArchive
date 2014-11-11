a = '*********************'
b = '^^^^^^^'
i = 75
flip = False

while True:
    print (a.center(i))
    print (b.center(i + 1))
    if i > 110:
        flip = True
    elif i < 40:
        flip = False
    if flip == True:
        i -= 1
    else:
        i += 1
