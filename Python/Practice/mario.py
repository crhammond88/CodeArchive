height = 24

while height > 23:
    print("How tall do you want your pyramid?")
    height = input()

i = 2

while height != 0:
    print((' ' * (height - 1)) + ('#' * i))
    i += 1
    height -= 1
