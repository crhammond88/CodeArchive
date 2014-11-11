#TEST THE RETURN OF A FUNCTION WITH ANY NUMBER OF ARGUMENTS
#Created By: Chris Hammond
#How to Use:
#Complete each section indicating that input is required


###***INPUT REQUIRED***###
#import functions to test from a valid python file
from isprime import *


primeList = loadPrimes()


def unpackInputs(test, inputs):
#returns a string of inputs to execute as code
    #create answer list
    answer = []
    #for each argument
    for argument in inputs:
        #add the input for the current test to answer
        answer.append(argument[test])
    #return answer
    return answer




def testInOut(function, outputs, *inputs):
#returns the results of a test for the function
#outputs and inputs must be lists, tuples, or strings of equal length
#outputs are correct outputs of the function for the given inputs
#desired outputs must match the order of inputs
#supports multiple inputs
    #create function name as string for error reporting
    funName = function.__name__
    #create list to hold test results
    results = []
    #for each desired test
    for test in range(len(outputs)):
        #find correct inputs for current test
        testInputs = unpackInputs(test, inputs)
        #print message to indicate that each test has started
        print("Attempting Test " + str(test + 1) + ": " + funName  + '...')
        #run the test
        results.append(function(*testInputs))
        #if the test fails
        if results[test] != outputs[test]:
            #return error report
            return("\n____________________________________________________\n" + "!!!Failed " + funName + " Test " +
                   str(test + 1) + "!!!\n\n" + funName  + "\nReturned: " + str(results[test]) + "\nReturn Type: " + str(type(results[test])) +
                   "\n\nExpected Return: " + str(outputs[test]) + "\nExpected Type: " + str(type(outputs[1])) + "\n____________________________________________________\n")
        #if the test doesn't fail, print passed
        print("   Passed!")
    #if all tests passed, return passed
    return("All Tests Passed for " + funName + "!")




###***INPUT REQUIRED***###
#create lists, strings, or tuples containing the tests for the function, correctly matching RETURNS and ARGUMENTS
outputs = (True,False,True,False,True,False,True,False,True,False,False,True,False,True)
inputs0 = (2,6,7,15,29,30,37,49,61,63,8649,12703,222224488462986,19134702400093278081449423917)
inputs1 = []
for i in range(len(outputs)):
    inputs1.append(primeList)



###***INPUT REQUIRED***###
#run test and print results, but only if this file is executed directly
#replace the comment with name of function to be tested
#add additional arguments if needed
if __name__ == '__main__':
    print testInOut(isPrime, outputs, inputs0, inputs1)
