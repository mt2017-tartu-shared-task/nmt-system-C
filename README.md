"Researchers" In-class Machine Translation Shared Task 2017 Submission

This repository is a result of our participation in the shared task.<br>
We went through the process of building, analysing, and improving the neural machine translation system.

Poster: [link]() 

The shared task was for Estonian-English language pair. 
It included working with ~19.000.000 sentence pairs.

Shared task main page: [link](https://github.com/mt2017-tartu-shared-task) <br>
Shared task on course page: [link](https://courses.cs.ut.ee/2017/MT/fall/Main/SharedTask)

Sections below summarize key milestones we went through.  

##  Baseline system
- Our baseline system was OpenNMT-py model with default parameters.
- As a result, we got 22.25 BLEU points on the shared dev set.

More details: [link](https://github.com/mt2017-tartu-shared-task/nmt-system-C/blob/master/reports/Milestone%20report.pdf)

## Baseline system manual evaluation
- We manually analyzed 40 baseline translations. 
- Our main observation was that the most of the errors in our results were caused by fact, that machine used synonyms, which have a little different meaning and it changes sense of the sentences. Several times some words were missed or was used incorrect tense.
- Take a look at our the motivating example produced by baseline system:

Example 1.
Estonian: Meie oskus aidata luua väärtuspõhiseid teenuseid võib anda tulemuseks kiirema väärtusteni jõudmise.
Human English Translation: Our ability to help create asset-based services can result in faster time to value.
Machine English Translation: Our ability to help create valuable services can result in faster values.

Example 2.
Estonian: Te kontrollite kogu kasutuskogemust.
Human English Translation: You control everything about the experience.
Machine English Translation: You're checking all the experience.

More details: [link](https://github.com/mt2017-tartu-shared-task/nmt-system-C/blob/master/reports/MT_report%233.pdf)

## Final system
- In order to address translation issues found after our manual evaluation we train model with Nematus framework (with default parameters) and translate with ensemble decoding (using three best models). For translation we also tune best value of beam size. 
- The trained system gave us 16.8 BLEU points on the shared dev set that means decrease over the baseline. 

More details: [link](https://github.com/mt2017-tartu-shared-task/nmt-system-C/blob/master/reports/MT_report%234.pdf)

## Final system manual evaluation
- Generally speaking, results are slighly worse: grammar is approximately on same level, but use of incorrect words is really often.
- Lets now look at how does our Motivating example looks like with our final system:

Example 1.
Estonian: Meie oskus aidata luua väärtuspõhiseid teenuseid võib anda tulemuseks kiirema väärtusteni jõudmise.
Human English Translation: Our ability to help create asset-based services can result in faster time to value.
Machine English Translation: Our ability to help create value-based services can lead to faster values.

Example 2.
Estonian: Te kontrollite kogu kasutuskogemust.
Human English Translation: You control everything about the experience.
Machine English Translation: You'll check all the use.

- As a result you can see that baseline translation is better. Final system translation is less fluent and often use incorrect words (but overall structure of sentence looks fine). 

Do not forget to check our poster: [__POSTER_LINK__]

## What we also tried or wanted to try
We also tried to continue training baseline system one week more. After reaching 20 epochs (in baseline was 13 epochs) results converge, so,
there were no need to train default system more. <br>
Training with Nematus continued one week. We wanted to train model for more time (one-two week more), because we found GPU quite late and one week was not enough. <br>


## Final words
- __1st_sentence: your_results_on_the_test_set_and_interpretation_(feel_later)__
- General difficulties were finding GPUs for training. Finally, Google Cloud GPU (one Tesla K80) was used.
- It is necessary to be up-to-date with modern frameworks, some of them may propose what you need (for example, Nematus propose ensemble decoding while OpenNMT-py not).



## Team members:
1. [link] (https://github.com/slavikkom)
2. [link] (https://github.com/dil-delada) 

Project board: [link](https://github.com/mt2017-tartu-shared-task/nmt-system-C/projects/1)

