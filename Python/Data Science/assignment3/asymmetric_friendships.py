import MapReduce
import sys

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: friend pair
    # value: ordered friendship
    key = frozenset(record)
    value = record
    mr.emit_intermediate(key, value)

def reducer(key, list_of_values):
    # key: friend pair
    # value: ordered friendships
	if len(list_of_values) == 1:
		output = (list_of_values[0][0], list_of_values[0][1])
		mr.emit(output)
		reverseOut = (list_of_values[0][1], list_of_values[0][0])
		mr.emit(reverseOut)

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
