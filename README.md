<div class=container>
# Statistical privacy

These are my notes of various textbook chapters and research papers in
differential privacy. These notes reflect my attempts to understand
the directions of research in statistical privacy. As a general guide
for these notes: Definitions are always in blue , lemmas are written
in orange and theorems are written in Green. Excerpts that provide
intuition are displayed in purple and open questions and confusions
are listed in red. The notes are divided into multiple views:

## Individual research papers/mathematical tools to understand privacy

Sometimes I study a research paper or textbook chapter in isolation to
understand its contents. Usually this is done to understand background
material that will help me tackle a problem I care about. There is
little big qpicture in those notes. In this notes I cannot always
explain why someone not interested in differential privacy should care
about these results.

### Background

* [Differential Privacy Cheat sheet](Definitions/): I define central
  differential privacy, local differential privacy and shuffle
  privacy. Introduce well the laplace mechanism - what it is and why
  it works. Simulation code to understand $(\alpha, \beta)$ accuracy
  guarantees for the laplace mehanism is provided.
* [Concentration Inequalities: building blocks to understanding
  proofs](ConcentrationInequalities/): A lot of the alogirithms in
  this area try to approximate the expected value of random
  variables. Knowing when sample means are a good representation of
  expected mean seems to be a building block for this area and machine
  learning theory.
* [Exponential Mechanism](ExponentialMechanism/): A theoretical
  technique developed for when the utility of outputs being considered
  are very sensitive to perturbation. Examples include auction prices
  or voting counts. A little bit of noise could alter the final
  outcome drastically. I describe the theoretical framework with a few
  simple non practical examples.  
* [Composition Theorems](): Todo 


### Research Papers

* [Separating Shuffle and Local Privacy: Albert
  Cheu](ShufflePrivacy/index.html): A research paper that attempts to
  understand how shuffle privacy and local privacy are different in
  theoretical guarantees for the simple mean estimation problem. I go
  through the paper and re-derive the proofs and try to build some
  intution as to why the algorithms work.
* [Shuffle: Binary sums with no communication](ShuffleSumBinaryRasmus/)  
* [Shuffle: Almost Central Almost no communication](ShuffleSumMeanEstimateRasmus/)
* [Simultaneous Private Learning of Multiple Concepts](LearningMultiConcepts/)
* [frequency Estimation with  local privacy: A survey](FrequencyEstimationSurvey/index.html)
* [Pure LDP](PureProtocols/)

<!-- * [Succint Histogram Problem -- local privacy](SuccintHist-Bassily/index.html) -->

## Specific problems and how a series a research papers connect them

Sometimes I care about a general problem or application like centrally
private mean estimation will go through material related to the
problem and analyse the solutions to get an idea of the contributionsq
with regard to that problem only. In these notes I should be able to
explain to a non technical person, why the results are
important. Additionally, I write code to simulate the alogorithms and
check for gaps in practical deployement.

* [Private Mean Estimation](PrivateMeanEstimation/): In this work, we study the problem of
  summing (aggregating) real numbers or integers, a basic primitive in
  numerous machine learning tasks. People have attempted this under
  many different assumptions and come with different solutions. These
  notes summarise the works from:
  * Laplace
  * Pagh
  * Cheu
  * Cormode
* [Private Password Lists]()


## My own work

In this seciton I describe original work that I am thinking of. Most
of this work is done under the suprvision of [Graham
Cormode](https://warwick.ac.uk/fac/sci/dcs/people/graham_cormode/)

* [Re-deriving and extending Trie heavy hitters]()

<div class=container>
