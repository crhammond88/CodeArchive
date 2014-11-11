import MapReduce
import sys

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
	# key: order_id
	# value: list contents
	key = record[1]
	mr.emit_intermediate(key, record)

def reducer(key, list_of_values):
    # key: order_id
    # value: list of records
	order = list_of_values[0]
	for lineitem in list_of_values[1:]:
		output = order + lineitem
		mr.emit(output)

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
