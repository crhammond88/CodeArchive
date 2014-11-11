def find_second(search, target):
    first = search.find(target)
    return search.find(target, first + 1)


danton = "De l'audace, encore de l'audace, toujours de l'audace"
print find_second(danton, 'audace')
#>>> 25

twister = "she sells seashells by the seashore"
print find_second(twister,'she')
#>>> 13
