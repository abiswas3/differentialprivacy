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
* [Notes on Computation Complexity](): **TODO**  
* [A survey on randomised response](RRSurvey/)
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
  simple non practical examples. **TODO**  
* [Composition Theorems](): **TODO**


### Research Papers

* [Shuffle Privacy From Shuffling](CheuShuffleRR/): In this paper we take the well studied Randomised Response method which is optimal for local privacy and tweak it to get approximate central privacy.
* [Separating Shuffle and Local Privacy: Albert
  Cheu](ShufflePrivacy/index.html): A research paper that attempts to
  understand how shuffle privacy and local privacy are different in
  theoretical guarantees for the simple mean estimation problem. I go
  through the paper and re-derive the proofs and try to build some
  intution as to why the algorithms work.
* [Shuffle: Binary sums with no communication](ShuffleSumBinaryRasmus/)  
* [Shuffle: Almost Central Almost no communication](ShuffleSumMeanEstimateRasmus/)
* [Simultaneous Private Learning of Multiple Concepts](LearningMultiConcepts/)
* [Frequency Estimation with  local privacy: A survey](FrequencyEstimationSurvey/index.html)
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
  numerous machine learning tasks. What solutions have researchers come up with for central, local and shuffle privacy:
  * Laplace mechanism - Textbook for DP
  * [Lower bounds for local differential privacy](https://arxiv.org/pdf/1103.2626.pdf)
  * [Ghazi, Rasmus Pagh -- binary sums and histograms](ShuffleSumBinaryRasmus/)  
  * [Ghazi, Pagh -- real number sums](ShuffleSumMeanEstimateRasmus/)
  * [Cheu](ShufflePrivacy/index.html)
  * [Cormode]((FrequencyEstimationSurvey/index.html))
* [Private Password Lists](PrivatePassowrds): Application of the exponential mechanism (first I have seen so far) **TODO**
  * [Password Frequency list I](https://jbonneau.com/doc/BDB16-NDSS-pw_list_differential_privacy.pdf)
  * [Private Anonymous histograms](https://arxiv.org/abs/1910.03553)
* [Private Rank Aggregation/Voting](PrivateVoting): There seems to be some work in this area but not a whole lot. Wondering if it is because the problems are too hard or too similar to the primitives researchers already think about. Or am I lucky in that people have just not cared about it that much. Could be some novel work in here. Papers worth reading:
  * [Differentially Private Rank Aggregation](https://cs.colgate.edu/~mhay/assets/publications/hay2017differentially.pdf)

### Sample Mean Extraction
s

### Population Mean Extraction

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-1wig{font-weight:bold;text-align:left;vertical-align:top}
.tg .tg-0lax{text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0lax"></th>
    <th class="tg-1wig">Contribution</th>
    <th class="tg-1wig">Venue</th>
    <th class="tg-1wig">Authors</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Distributed mean estimation using randomised response : Amplification by shuffling</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Thirtieth Annual ACM-SIAM Symposium on Discrete Algorithms (2019)</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Erlingsson, Ulfar and Feldman, Vitaly and Mironov, Ilya and Raghunathan, Ananth and Talwar, Kunal and Thakurta, Abhradeep</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Distributed mean estimation using randomised response : d-histogram problem</td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Annual International Cryptology Conference (2019)</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Balle, Borja and Bell, James and Gasc{\'o}n, Adria and Nissim, Kobbi</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Distributed mean estimation using randomised response -</td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Annual International Conference on the Theory and Applications of Cryptographic Techniques (2019)</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Cheu, Albert and Smith, Adam and Ullman, Jonathan and Zeber, David and Zhilyaev, Maxim</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Distributed mean estimation using binomial noise </td>
    <td class="tg-0lax"><span style="font-style:normal">Information-Theoretic Cryptography, </span><br><span style="font-style:normal">ITC 2020</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Balcer, Victor and Cheu, Alber</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Distributed mean estimation using correlated noise - binary population<br></td>
    <td class="tg-0lax">ICML 2020</td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">B Ghazi, R Kumar, P Manurangsi, R Pagh</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Distributed mean estimation using correlated noise - integer valued population. </td>
    <td class="tg-0lax">ICML 2021</td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Badih Ghazi, Noah Zeger Golowich, Shanmugasundaram Ravikumar, Pasin Manurangsi, Ameya Avinash Velingker, Rasmus Pagh</span></td>
  </tr>
</tbody>
</table>

### N-gram extraction / private set union

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0lax{text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0lax"></th>
    <th class="tg-0lax">Contribution</th>
    <th class="tg-0lax">Venue</th>
    <th class="tg-0lax">Authors</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Differentially private set union : A datasets of n user, each with their own <br>set $W_i \subset U$, where U is a very large universe of items (possibly <br>unbounded). The basic laplace mechanism needs to much noise due to <br>high worst case sensitivity. They present an adaptive algorithm that keeps<br>sensitivity small for the laplace/gaussian mechanism. Once this is done, it's just <br>the well understood additive noise mechanism. <br><br>**Areas of improvement: ** (1) Algorithm is sequential and thus a federated version<br>does not exist. </td>
    <td class="tg-0lax">ICML 2020</td>
    <td class="tg-0lax">Gopi, Gulhane, Kulkarni, Shen, Shokouhi, Yekhanin</td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Differentially private n gram<br>extraction: The setup is very similar as the previous problem. Now. instead of items users<br>have sequences with each element from a very large universe. They iteratively use set union,<br>to construct a private ngram extraction method.<br><br>**Areas of improvement: ** (1) Cannot be distributed (2) How does McMahan and Grahams <br>trie heavy hitter algorithm compare to this. Once again it will allow us to compare sampling vs<br>additive noise. </td>
    <td class="tg-0lax">NIPS 2021</td>
    <td class="tg-0lax">Kim, Gopi, Kulkarni, Yekhanin</td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
  </tr>
</tbody>
</table>

### Secure Comparison Protocols

### Voting methods 



## My own work

In this seciton I describe original work that I am thinking of. Most
of this work is done under the suprvision of [Graham
Cormode](https://warwick.ac.uk/fac/sci/dcs/people/graham_cormode/)

* [Sample and threshold](): **Work by Graham before we started working together: Under Submission for AI Stats**
* [Connecting Central , Shuffle and Sampling Privacy](EquivalenceOfPrivacyModels/): **Some of the proofs are incorrect, I am in the process of fixing them**

<div class=container>
