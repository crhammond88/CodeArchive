import MapReduce
import sys

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
	matrix = record[0]
	row = record[1]
	column = record [2]
	value = record[3]

	if matrix == 'a':
		place = column
		info = [place, value]
		output = [matrix, info] 
		for i in range(5):
			loc = (row, i)
			mr.emit_intermediate(loc, output)
	else:
		place = row
		info = [place, value]
		output = [matrix, info] 
		for i in range(5):
			loc = (i, column)
			mr.emit_intermediate(loc, output)

def reducer(key, list_of_outputs):
	# key: location in matrix
	# value: list of values
	products = []
	aValues = {}
	bValues = {}
	for output in list_of_outputs:
		matrix = output[0]
		if matrix == 'a':
			aValues[output[1][0]] = output[1][1]
		else:
			bValues[output[1][0]] = output[1][1]
	for loc in aValues:
		try:
			product = aValues[loc] * bValues[loc]
		except KeyError:
			product = 0
		products.append(product)
	answer = sum(products)
	output = (key[0], key[1], answer)
	mr.emit(output)

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
