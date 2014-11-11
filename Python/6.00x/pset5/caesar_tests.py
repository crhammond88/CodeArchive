from caesar import *

#test buildCoder
print buildCoder(3)
print
print buildCoder(9)

print "\n\n"

#test applyCoder
foo = "Hello, world!"
print foo
foo = applyCoder(foo, buildCoder(3))
print foo
foo = applyCoder(foo, buildCoder(23))
print foo

print "\n\n"

#test applyShift
bar = 'This is a test.'
print bar
bar = applyShift(bar, 8)
print bar
bar = applyShift(bar, 18)
print bar
