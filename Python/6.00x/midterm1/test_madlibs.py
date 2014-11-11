from madlibs import *

listOfAdjs = ['fair', 'fun', 'harmless', 'tall', 'ugly', 'ill','ravenous','creepy', 'plaid']
listOfNouns = ['hand', 'World', 'Programming', 'looks', 'style', 'Tim', 'GoodYear', 'tires', 'zombies', 'humans', 'yesterday', 'store', 'pants', 'something', 'grandpa']
listOfVerbs = ['wish', 'kiss', 'know', 'kill', 'shop', 'run', 'play', 'love', 'attacking', 'attacks', 'found', 'looked']

#test generateForm
story0 = 'I really wish I could kiss the hand of that maiden!'
story1 = 'Hello, World! Programming is really fun!'
story2 = "You know that saying 'If looks could kill?' Well, my style is harmless, I shop at GoodWill."
story3 = 'The ravenous zombies started attacking yesterday'
story4 = 'At the creepy thrift store I found a pair of plaid pants that looked like something your grandpa might wear'
stories = (story3, story4, story0, story1, story2)
madstory0 = 'The [ADJ] [NOUN] started [VERB] [NOUN]'
madstory1 = 'At the [ADJ] thrift [NOUN] I [VERB] a pair of [ADJ] [NOUN] that [VERB] like [NOUN] your [NOUN] might wear'
madstory2 = 'I really [VERB] I could [VERB] the [NOUN] of that maiden!'
madstory3 = 'Hello, [NOUN]! [NOUN] is really [ADJ]!'
madstory4 = "You [VERB] that saying 'If [NOUN] could [VERB]?' Well, my [NOUN] is [ADJ], I [VERB] at GoodWill."
madstories = (madstory0, madstory1, madstory2, madstory3, madstory4)
#for if the solution causes an extra space to be added at the end of the string
madstories1 = []
for i in range(len(madstories)):
    madstories1.append(str(madstories[i]) + ' ')
passedf = True
madLibs = []

for i in range(len(stories)):
    madLibs.append(generateForm(stories[i], listOfAdjs, listOfNouns, listOfVerbs))
    if (madLibs[i] != madstories[i] and madLibs[i] != madstories1[i]):
        passedf = False
        print('Failed generateForm: TEST ' + str(i + 1))
        print('\ngenerateForm Returned: ' + str(madLibs[i]) + '\nType: ' + str(type(madLibs[i])))
        print('\nCorrect Answer: ' + str(madstories[i]) + '\nType: ' +str(type(madstories[i])) + '\n_________________\n' )
if passedf:
    print('Passed generateForm!\n')

#test generateTemplates
#requires generateForm test to complete successfully
templates = []
passedt = True
answer0 = ['[ADJ]', '[NOUN]', '[VERB]', '[NOUN]']
answer1 = ['[ADJ]', '[NOUN]', '[VERB]', '[ADJ]', '[NOUN]','[VERB]','[NOUN]','[NOUN]']
answer2 = ['[VERB]', '[VERB]', '[NOUN]']
answer3 = ['[NOUN]', '[NOUN]', '[ADJ]']
answer4 = ['[VERB]', '[NOUN]','[VERB]', '[NOUN]','[ADJ]','[VERB]']
answers = (answer0, answer1, answer2, answer3, answer4)


for i in range(len(answers)):
    templates.append(generateTemplates(str(madLibs[i])))
    if templates[i] != answers[i]:
        passedt = False
        print('Failed generateTemplates: TEST ' + str(i + 1))
        print('\ngenerateTemplates Returned: ' + str(templates[i]) + '\nType: ' + str(type(templates[i])))
        print('\nCorrect Answer: ' + str(answers[i]) + '\nType: ' +str(type(answers[i])) + '\n_________________\n' )
if passedt:
    print('Passed generateTemplates!\n')
        



#test verifyWord        
words = ('fun', 'zombies', 'kill', 'hop', 'attacking', '') 
madTemplates = ('[ADJ]', '[NOUN]', '[VERB]', '[VERB]', '[NOUN]', '[ADJ]')
returns = (True,True,True,False,False,False)
verifies = []
passedv = True


for i in range(len(words)):
    verifies.append(verifyWord(words[i], madTemplates[i], listOfAdjs, listOfNouns, listOfVerbs))
    if verifies[i] != returns[i]:
        passedv = False
        print('Failed verifyWord: TEST ' + str(i + 1))
        print('\nverifyWord Returned: ' + str(verifies[i]) + '\nType: ' + str(type(verifies[i])))
        print('\nCorrect Answer: ' + str(returns[i]) + '\nType: ' +str(type(returns[i])) + '\n_________________\n' )
if passedv:
    print('Passed verifyWord!\n')
        


