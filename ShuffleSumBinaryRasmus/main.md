
\newcommand{\P}[3]{\mathbb{P}_{#2 \sim #3}\Big[#1\Big]}
\newcommand{\D}{\mathbb{D}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\max}{\text{max}}
\newcommand{\S}[1]{\Delta #1}
\newcommand{\RBinHist}{\textit{R}_{\epsilon, \delta}^{zsum}}
\newcommand{\ABinHist}{\textit{A}_{\epsilon, \delta}^{zsum}}
\newcommand{\PBinHist}{\textit{P}_{\epsilon, \delta}^{zsum}}
\newcommand{\localP}{\textit{P} = (\textit{R}, \textit{A})}
\newcommand{\epsDelta}{(\epsilon, \delta)}

<div class="container">
# Private Counting from Anonymous Messages: Near-Optimal Accuracy with Vanishing Communication Overhead

[Paper being discussed](./binarySums.pdf) abstract published @ FORC Foundations of Responsible Computing
 2020 and full paper @ ICML 2020.

## Problem Statement 

```In this work, we study the problem of summing (aggregating) binary numbers.
```

The following screenshot is taken from the [official talk](https://www.youtube.com/watch?v=wkF_uBo-bLo) by one of the authors and provides an overview of shuffle privacy.
<img src="pngs/overview.png" height="300px" width="600px"></img>


## Contribution

For the simple problem of binary sum estimation, if I want to send 1 message per user only then the accuracy bounds by given by [[2][2]] and [[1][1]] are tight. You cannot do better! **This paper proves a lower bound**. If there is wiggle room on the number of messages each user can send; then the accuracy of the central case is achievable -- they get arbitrarily close the discrete laplace mechanism. They also claim their algorithms are practical by running evaluations. **TODO ARI: Run the code yourself and verify.**

<!-- They improve the bounds on the number of messages by making it disappear as $n$ goes to infinity. -->

<img src="pngs/related_work.png" height="300px" width="600px"></img>

### Main Theorem 

For every $\epsilon \leq O(1)$ and every $\delta, \gamma \in (0, 1/2)$, there is $(\epsilon, \delta)$-DP protocol for binary summation in the multi message shuffled model, with error equal to a vector of independent Discrete Laplace random variables each with paramter $\frac{\epsilon(1 - \gamma)}{2}$ and with an expected number of messages sent per user equal to $1 + O(\frac{B\log^2(1/\delta)}{\gamma\epsilon^2n})$, each consisting of $\log B + 1$bits.

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#binShuffleSumOptimal">Main proof</button>
<div class=collapse id=binShuffleSumOptimal>


</div>


### Lower Bound if communication is restricted

Let $\delta=\frac{1}{n^{\Omega(1)}}$ and $\epsilon \leq O(1)$, then **any** $(\epsilon, \delta)$-DP protocol for binary summation in the single message shuffled model should incur a squared error of $\Omega(\log n)$. However, if you allow **almost** single message then the error can get really close to central models.

## Background Material to understand the proofs 

### Distributed D-Mechanisms

They define a D-Mechanism as the process of adding independent noise to each dimension of the final output of tha analyser/curator in central DP -- similar to the laplace mechanism defined [in](Definitions/). The distributed D-Mechanism is the protocol of achieving the same distribution by splitting the noise into $n$ components.

#### Privacy

For any $\epsilon > 0$ and $\delta \in (0,1)$, the D-Distributed Mechanism is $(\epsilon, \delta)$-DP in the shuffled model for $\Delta$-summation **if and only if** if the D Mechanism is $(\epsilon, \delta)$-DP in the central model for $\Delta$-summation.

#### Error

The error of such a shuffled protocol is $D - \mathbb{E}[D]$, the mean squared error is just the variance of the distribution.

#### Communication 

The expected number of messages is at most $\Delta + \mathbb{E}[D]/n$ where each messages is composed of 1's.


### Infinitely Divisible Distributions

[Examples of such distributions](https://stats.libretexts.org/Bookshelves/Probability_Theory/Probability_Mathematical_Statistics_and_Stochastic_Processes_(Siegrist)/05%3A_Special_Distributions/5.04%3A_Infinitely_Divisible_Distributions)

One of the tricks of the paper is to use the guarantees of central privacy but finding distributions that can distribute the same noise over $n$ users. The authors use the poisson distribution and the negative binomial distribution to build intuition, but these distributions are not able to shrink the error close to central DP. Lemma 15 in the paper proves that any infinitely divisible distribution on non-negative distributions will never come close to Central DP. 

Then the authors go on to sample the discrete laplace distribution using the difference of negative binomials. However, by doing this we lose privacy. So the final game is to use what they call correlated distributed mechanisms to bring back the privacy -- where they use noise from a second different infinitely divisible distribution to get the privacy back. They don't lose accuracy in expectation but it does add variance.


#### Poisson 

[Proof by induction](https://llc.stat.purdue.edu/2014/41600/notes/prob1805.pdf) showing that $Poisson(\lambda)$ is infinitely divisble.

If we can show that the poisson mechanism is DP like the laplace mechanism, we're done in therms of the privacy proof. The error would just be the variance of the distribution. Note: The standard concentration bounds don't work for Poisson distributions  as it is not a sub-gaussian distribution -- [see this writeup](https://math.stackexchange.com/questions/2533280/poisson-random-variable-is-not-sub-gaussian). So to prove privacy, we need a special poisson concentration lemma


##### Lemma : Poisson concentration

##### Theorem: Privacy of the Poisson Mechanism

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#poissonPrivacy">Proof: Poisson mechanism is private</button>
<div class=collapse id=poissonPrivacy>


</div>


#### Negative Binomial distribution

**Key Observation:** Sampling from a discrete laplace distributoon (2 sided geometric distribution) is equivalent to sampling from the difference of two Negative Binomial distributions.

<div class="question"> There are some statements in the paper where they claim that because the mean and variance of the poisson is the same, it leads to lot of communication when $\frac{\epsilon}{\Delta} << 1$. I do not have any intuition behind this statement. They then claim by using the negative binomial distribution this dependence can be shrunk from $(\frac{\epsilon}{\Delta})^2$ in the Poisson case to $\frac{\epsilon}{\Delta}$ in the negative binomial case. I did not realy understanding anything about the distinction between the two and why one is better. I just treat them as separate examples for now.
</div>

##### Theorem: Privacy of the Negative Binomial mechanism

For any every $\epsilon, \delta \in (0, 1)$ and $\Delta \in \N$. Let $p=e^{-.2\epsilon/Delta}$ and $r=3\big(1 + \log(1/\delta)\big)$. The $NB(r, p)$ mechanism is $(\epsilon, \delta)$-DP.

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#nbPrivacy">Proof: negative binomial mechanism is private</button>
<div class=collapse id=nbPrivacy>


</div>


## References 

[1]: https://arxiv.org/abs/1808.01394 "Distributed differential privacy via shuffling"
[2]: https://arxiv.org/pdf/1903.02837.pdf "The privacy blanket of the shuffle model"

</div>