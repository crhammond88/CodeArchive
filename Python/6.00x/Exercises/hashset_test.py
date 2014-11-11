from hashset import *

p = hashSet(4)
p.insert(3)
p.insert(4)
print p
p.insert(3)
print p
p.remove(3)
print p
print p.member(4)
print p.getNumBuckets()