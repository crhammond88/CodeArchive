def print_multiplication_table(n):
    i = 1
    while i < n+1:
        j = 1
        while j < n+1:
            print str(i) + " * " + str(j) + " = " + str(i*j)
            j += 1
        i += 1

print_multiplication_table(3)
