<div class=container>
# Separting local and Shuffle Privacy

\newcommand{\P}[3]{\mathbb{P}_{#2 \sim #3}\Big[#1\Big]}
\newcommand{\D}{\mathbb{D}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\RBinHist}{\textit{R}_{\epsilon, \delta}^{zsum}}
\newcommand{\ABinHist}{\textit{A}_{\epsilon, \delta}^{zsum}}
\newcommand{\PBinHist}{\textit{P}_{\epsilon, \delta}^{zsum}}
\newcommand{\localP}{\textit{P} = (\textit{R}, \textit{A})}
\newcommand{\epsDelta}{(\epsilon, \delta)}

## Background Material 

This is material that we need to be able to derive the proofs in the
paper. [1][1] Identify a class of
distributions and argue that, if $\eta$ is sampled from such a
distribution, adding η to a 1-sensitive sum ensures differential
privacy of that sum.

1-sensitive sums show up with computing sums on histograms with
elements 1 or 0 on two datasets that differ by one record only.

### Smooth Distributions {#definition-smooth}

A distribution $\D$ is smooth over $\Z$ is $(\epsilon,
\delta, k)$ smooth, if $\forall k' \in [-k, k]$ if the event E

$$\P{E \geq e^{|k'|\epsilon}}{Y}{\D} \leq \delta$$ or 

$$\P{E < e^{|k'|\epsilon}}{Y}{\D} > 1 - \delta$$

The second equation looks a lot like a concentration inequality
i.e. it is saying that the value of the event being concentrated
within the window is quite high.

This already looks a lot like Differential Privacy, which says, for DP
to hold the ratio of the probabilities of a function outputting the
same value on neigbhouring datasets is bounded by an exponential
function as shown above with probability 1 - $\delta$

The Event $E$ is defined as the following

$$E=\frac{\P{Y'=Y}{Y'}{D}}{\P{Y'=Y+k'}{Y'}{D}}$$

It's saying if I draw a random variable from $Y \sim \D$; the
probability of drawing another variable $Y' \sim \D$ within a window
of [Y, Y+k'] is quite close to the original probability of drawing $Y$
to begin with.

<!-- [Heading IDs](#custom-id)
-->
### Lemma: Adding Noise from smooth distributions is a DP mechanism {#lemma-smooth}

Let $f: \Z^n \rightarrow \Z$ be a function such that it is 1 sensitive
i.e. $|f(x) - f(x')| \leq 1$ ffor all $x \sim x'$. Let $\D$ be a
(\epsilon, \delta, 1) smooth distribution. Then the algorithm that
takes $x \sim \Z^n$, and outputs $f(x) + \eta$ where $\eta \sim D$ is
DP.

### Lemma: The binomial distribution is smooth

To show in a minute

## Introduction 

There has been a lot of work on local privacy. See here **TODO**. A
new paradigm of privacy is shuffle privacy. In this paper, the authors
try and understand the guarantees of shuffle privacy with respect to
local privacy for the histogram sum estimation problem. There are two
major findings:

1. The authors present a protocol in the shuffled model that estimates
   histograms with error independent of the domain size. This implies
   an arbitrarily large gap in sample complexity between the shuffled
   and local models. **So all known local models depend on domain
   size**
2. Local and shuffle privacy are equivalent when we impose the
   constraints of pure differential privacy and single-message
   randomizers.

## A simplified histogram

Before estimating all histograms, the authors look at the binary
histogram or binary sums where the cells of the histogram are
constrained to have values in $\{0, 1\}$.

**PUT PICTURE**

### An algorithm for binary sums that satisfies shuffle privacy

<div class="algorithm">

**RANDOMISER:** $\RBinHist$

Input: 

* $x \in \{0,1\}$
* $(\epsilon, \delta) \in [0,1]$

Method: 

1. $1 - p = \frac{50}{\epsilon^2 n}\log(\frac{2}{\delta})$
2. $z \sim Bernoulli(p)$

Output: 

3. Output x+z copies of 1s (At the most 2 bits)

**ANANLYSER: **$\RBinHist$

Input: 

* $n$ outputs of $\RBinHist$: which is a steam of 1's i.e $y \in \{ 1\}^*$
* $(\epsilon, \delta) \in [0,1]$

Method: 

1. $1 - p = \frac{50}{\epsilon^2 n}\log(\frac{2}{\delta})$
2. $c* = \frac{1}{n}|y|$ where |.| is the length of a stream

Output:

3. if c* > 1 : return (c* - p) else: return 0
   

</div>

### Theorem: The above proptocol is DP for the shuffled model {#theorem-binHistDP}

For any $\epsilon, \delta \in [0,1]$ and any $n \in \N$ such that $n
\geq \frac{100}{\epsilon^2}\log(\frac{2}{\delta})$, the protocol
$(\PBinHist = \RBinHist, \ABinHist)$ has the following properties: 

1. $\PBinHist$ is $\epsDelta$-differentially private in the shuffled
   model. 
   
2. For $\beta > \delta^25$, the error $|\PBinHist(X) -
   \frac{1}{n}\sum_{i=1}^n x_i| \leq \alpha$ with probability $1 -
   \beta$ 

3. If $X=(0,...0)$, then $PBinHist(X)=0$ i.e. we have 0 error. <div
   class=question></div>
   
<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#binHistProof">Proof</button>

<div class=collapse id=binHistProof>

We are ready to show things

</div>

## Histogram summing the full version

### Theorem: The above proptocol is DP for the shuffled model {#theorem-HistDP}

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#histProof">Proof</button>

<div class=collapse id=histProof>

We are ready to show things

</div>


# Privacy definitions cheat sheet

## Central Differential Privacy {#definition-centralDP}

An algorithm $M : X^n \rightarrow Z$ satisfies
$(\epsilon,\delta)$-differential privacy if

$$ \P{M(x) \in T}{x}{X^n} \leq e^{\epsilon}\P{M(x') \in T}{x'}{X^n} + \delta$$

$\forall x \sim x'$ and $\forall T \subseteq Z$. Two datasets are $x
\sim x'$ if they differ by one row or record. Note: For DP to apply,
the above in equality must hold for **all** subsets of the range of
the alorithm. Another way of viewing the above inequality is in terms
of concentration measures:

With probablity 1 - $\delta$. 

$$ \frac{ \P{M(x) \in T}{x}{X^n}}{ \P{M(x') \in T}{x'}{X^n}} \leq e^{\epsilon}$$

Usually $\delta = o(1/n)$ is accepted as workable or efficient. This
is saying if datasets are neighbouring, central DP gurantees that the
algorithm outputs are concentrated near each other with high probability.

## Local Models  {#definition-localModel}

First introduced in [[2][2]]

A protocol P in the (non-interactive) local model consists of two
randomized algorithms:

* A randomiser $\textit{R}: X \rightarrow Y$ that takes as input a
  single user’s data and outputs a message.
* An analyser $\textit{A}: Y^* \rightarrow Z$ that takes as input all
  user messages and computes the output of the protocol.

We denote the protocol $\textit{P} = (\textit{R}, \textit{A})$. We
assume that the number of users n is public and available to both
$\textit{R}$ and $\textit{A}$. $Let ⃗x \in X^n$. The evaluation of the
protocol \textit{P} on input ⃗x is 

$$P(x) = (A \circ R)(x) = A\Big(R(x_1), \dots, R(x_n)\Big)$$


## Local Differential Privacy {#definition-localDP}

A local protocol $\localP$ satisfies $\epsDelta$-differential privacy
for n users if its randomizer $R : X \rightarrow Y$ is
$\epsDelta$-differentially private (for datasets of size one). In
other words, the output of the randomiser for any two inputs must be
concentrated with high probability 1 - $\delta$

$$ \frac{ \P{R(x) \in T}{x}{X}}{ \P{R(x') \in T}{x'}{X}} \leq
e^{\epsilon}$$ for all subsets $T \subseteq Y$

## Shuffled Model {#definition-shuffleModel}

A protocol $P$ in the shuffled model consists of three randomized
algorithms. The first and last algorithm is identical to the local
model. There is a middle shuffle phase. Formally,

* A randomiser $\textit{R}: X \rightarrow Y$ that takes as input a
  single user’s data and outputs a message.
* A shuffler $S : Y^* \rightarrow Y^*$. that concatenates all message
  vectors and then applies a uniformly random permutation to (the
  order of) the concatenated vector. For example, when there are three
  users each sending two messages, there are 6! permutations and all
  are equally likely to be the output of the shuffler.**NOTE: There is
  no special shuffling algorithm. It's always uniformly random on all
  permutations**
* An analyser $\textit{A}: Y^* \rightarrow Z$ that takes as input the
  shuffled messages and computes the output of the protocol.

The evaluation of the protocol $P=(R,A)$ on input $x$ is

$$P(x) = (A \circ S \circ R)(x) = A\Big(S\big[R(x_1), \dots, R(x_n)\big]\Big)$$

## Shuffle Privacy {#definition-shuffleDP}

A shuffled protocol $P = (R,A)$ satisfies $\epsDelta$-differential
privacy for $n$ users if the algorithm $(S \circ R) : X^n \rightarrow
Y^∗$ is $\epsDelta$-differentially private.

This is saying, for two neighbouring datasets $x \sim x'$, the
probability of seeing the same permutation after shuffling the outputs
of all the local randomisers is concentrated with high probability 1 -
$\delta$.

The hope is the following: Because we have this shuffle phase, perhaps
we can add a little less noise to the local randomisers thereby
getting a little bit more accuracy. 

## Important Papers

[1]: https://arxiv.org/pdf/1908.11358.pdf  "On the power of multiple anonymous messages"
1. [On the power of multiple anonymous messages](https://arxiv.org/pdf/1908.11358.pdf)

[2]: https://arxiv.org/pdf/0803.0924.pdf  "What can we learn privately"
2. [What can we learn privately](https://arxiv.org/pdf/0803.0924.pdf)
</div>
