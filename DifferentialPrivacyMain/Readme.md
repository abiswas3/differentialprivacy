\newcommand{\P}[3]{\mathbb{P}_{#2 \sim #3}\Big[#1\Big]}
\newcommand{\D}{\mathbb{D}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\E}{\mathbb{E}}
\newcommand{\max}{\text{max}}
\newcommand{\S}[1]{\Delta #1}
\newcommand{\RBinHist}{\textit{R}_{\epsilon, \delta}^{zsum}}
\newcommand{\ABinHist}{\textit{A}_{\epsilon, \delta}^{zsum}}
\newcommand{\PBinHist}{\textit{P}_{\epsilon, \delta}^{zsum}}
\newcommand{\localP}{\textit{P} = (\textit{R}, \textit{A})}
\newcommand{\epsDelta}{(\epsilon, \delta)}
\newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}

<div class="container">

## Background

* [Differential Privacy Cheat sheet](Definitions/): I define central
  differential privacy, local differential privacy and shuffle
  privacy. Introduce well the laplace mechanism - what it is and why
  it works. Simulation code to understand $(\alpha, \beta)$ accuracy
  guarantees for the laplace mehanism is provided.
* [Notes on Computation Complexity](../GraduateSchoolCourses/TCS_Toolkit-Ryan_ODonell/AsymptoticsAndGaussians/): Borrowed from Ryan O'Donnells TCS toolkit course
* [A survey on randomised response](RRSurvey/)
* [Concentration Inequalities](../ConcentrationInequalities/): Borrowed from multiple sources. Lots of online resources for this topic.
* [Composition Theorems](): **TODO**

## Population mean estimation

* [Local Privacy upper and lower bounds](PureProtocols/): Upper bound for Randomised Response for mean estimation under local privacy and general lower bound for all locally private algorithms.
* [Shuffle Privacy From Shuffling](CheuShuffleRR/): Examining Randomised Response from the lens of central privacy.
* [Separating Shuffle and Local Privacy: Albert
  Cheu](ShufflePrivacy/index.html): 
* [Shuffle: Binary sums with no communication](ShuffleSumBinaryRasmus/)  
* [Shuffle: Almost Central Almost no communication](ShuffleSumMeanEstimateRasmus/)

## Exponential Mechanism and friends

* [Exponential Mechanism](ExponentialMechanism/): A theoretical
  technique developed for when the utility of outputs being considered
  are very sensitive to perturbation. Examples include auction prices
  or voting counts. A little bit of noise could alter the final
  outcome drastically. I describe the theoretical framework with a few
  simple non practical examples. **TODO**  




<!-- * [Simultaneous Private Learning of Multiple Concepts](LearningMultiConcepts/)
* [Frequency Estimation with  local privacy: A survey](FrequencyEstimationSurvey/index.html)
 -->

<!-- * [Succint Histogram Problem -- local privacy](SuccintHist-Bassily/index.html) -->

## Survey styled writeups

* [Private Mean Estimation under distributed privacy](PrivateMeanEstimation/)
<!-- * [Private Password Lists](PrivatePassowrds): Application of the exponential mechanism (first I have seen so far) **TODO**
  * [Password Frequency list I](https://jbonneau.com/doc/BDB16-NDSS-pw_list_differential_privacy.pdf)

  * [Private Anonymous histograms](https://arxiv.org/abs/1910.03553)
* [Private Rank Aggregation/Voting](PrivateVoting): There seems to be some work in this area but not a whole lot. Wondering if it is because the problems are too hard or too similar to the primitives researchers already think about. Or am I lucky in that people have just not cared about it that much. Could be some novel work in here. Papers worth reading:
  * [Differentially Private Rank Aggregation](https://cs.colgate.edu/~mhay/assets/publications/hay2017differentially.pdf)
 -->

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
    <td class="tg-0lax">Differentially private set union : A datasets of n user, each with their own <br>set $W_i \subset U$, where U is a very large universe of items (possibly <br>unbounded). The basic laplace mechanism needs to much noise due to <br>high worst case sensitivity. They present an adaptive algorithm that keeps<br>sensitivity small for the laplace/gaussian mechanism. Once this is done, it's just <br>the well understood additive noise mechanism. <br><br>**Areas of improvement: ** (1) Algorithm is sequential and thus a federated version does not exist. (2) There are no utility guarantees presented. </td>
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

<!-- ### Secure Comparison Protocols

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky">Contribution</th>
    <th class="tg-0pky">Venue</th>
    <th class="tg-0pky">Authors</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0pky">Secure aggregation for a single round: Under the honest but curious model, the server is able to compute<br>the sum of user inputs even in the case of t dropouts. The protocol only works for a single round of computing <br>sums. </td>
    <td class="tg-0pky"><span style="font-weight:400;font-style:normal">2017 ACM SIGSAC Conference on Computer and Communications Security</span><br></td>
    <td class="tg-0pky"><span style="font-weight:400;font-style:normal">Bonawitz, Keith and Ivanov, Vladimir and Kreuter, Ben and Marcedone, Antonio and McMahan, H Brendan and Patel, Sarvar and Ramage, Daniel and Segal, Aaron and Seth, Karn</span></td>
  </tr>
  <tr>
    <td class="tg-0pky">Yao's millionaire problem: Given two millionaires a and b, both parties with to compute the value of a &lt; b without,<br>seeing each others values. A few ways to target this problem. One way is to convert the problem into private set intersection. Then use homomorphic encryption. [Link](https://eprint.iacr.org/2005/043.pdf)</td>
    <td class="tg-0pky"><span style="font-weight:400;font-style:normal">International Conference on Applied Cryptography and Network Security</span>(2005)</td>
    <td class="tg-0pky">Hsiao-Ying Lin and Wen-Guey Tzeng</td>
  </tr>
  <tr>
    <td class="tg-0pky"><span style="font-weight:400;font-style:normal">Private set intersection: Given two sets A and B, both parties want to compute A intersection B without revealing A and B. One solution, </span><br>is to use an honest server, otherwise known as [server aided PSI or third party PSI](https://decentralizedthoughts.github.io/2020-03-29-private-set-intersection-a-soft-introduction/)</td>
    <td class="tg-0pky">BLOG post</td>
    <td class="tg-0pky"><span style="font-weight:400;font-style:italic">Avishay Yanai</span></td>
  </tr>
</tbody>
</table>
 -->
<!-- ### Voting methods 

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
    <th class="tg-0lax">Contribution</th>
    <th class="tg-0lax">Venue</th>
    <th class="tg-0lax">Authors</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax">Differentially Private Rank Aggregation](https://cs.colgate.edu/~mhay/assets/publications/hay2017differentially.pdf): </td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">2017 SIAM International Conference on Data Mining</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Hay, Michael and Elagina, Liudmila and Miklau, Gerome</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
  </tr>
</tbody>
</table>
 -->


</div>