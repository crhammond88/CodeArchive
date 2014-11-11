a = "boom"
b = ['b','o','m']




def test ():
    for i in a:
        if i not in b:
            return False
    return True


print test()
