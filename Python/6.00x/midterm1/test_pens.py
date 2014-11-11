from pens import *



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
        #run the test
        results.append(function(*testInputs))
        #if the test fails
        if results[test] != outputs[test]:
            #return error report
            return("\n____________________________________________________\n" + "!!!Failed " + funName + " Test " +
                   str(test + 1) + "!!!\n\n" + funName + "(" + str(testInputs).strip('[]') + ")\nReturned: " + str(results[test]) + "\nReturn Type: " + str(type(results[test])) +
                   "\n\nExpected Return: " + str(outputs[test]) + "\nExpected Type: " + str(type(outputs[1])) + "\n____________________________________________________\n")
    #if all tests passed, return passed
    return("Passed " + funName + "!")
        



outputs = (False, False, True, False, True, False, True, True, False, True, True, True, True, True, True, True, True, True, True)
inputs0 = (0, 1, 5, 6, 8, 9, 13, 24, 27, 25, 26, 29, 30, 32, 33, 48, 49, 59, 69)







#if this file is executed directly, run tests
if __name__ == '__main__':
    print testInOut(numPens, outputs, inputs0)
