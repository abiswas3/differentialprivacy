\newcommand{\P}[3]{\mathbb{P}_{#2 \sim #3}\Big[#1\Big]}
\newcommand{\D}{\mathbb{D}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\RBinHist}{\textit{R}_{\epsilon, \delta}^{zsum}}
\newcommand{\ABinHist}{\textit{A}_{\epsilon, \delta}^{zsum}}
\newcommand{\PBinHist}{\textit{P}_{\epsilon, \delta}^{zsum}}
\newcommand{\RHist}{\textit{R}_{\epsilon, \delta}^{hist}}
\newcommand{\AHist}{\textit{A}_{\epsilon, \delta}^{hist}}
\newcommand{\PHist}{\textit{P}_{\epsilon, \delta}^{hist}}
\newcommand{\localP}{\textit{P} = (\textit{R}, \textit{A})}
\newcommand{\epsDelta}{(\epsilon, \delta)}
<div class=container>
# Separting local and Shuffle Privacy

<div class="question">Is there a major difference between mean estimation for histograms and regular mean estimation of a discrete population? [[5][5]] does the same problem as this paper but not for histograms. Therefore histograms as they are bucketted, must be easier?</div>

## Main Takeaways

The authors propose a protocol for computing sums for histograms with
error independent of the domain size/number of bins $d$ given a fixed
privacy budget. This implies an arbitrarily large gap in sample
complexity between the shuffled and local models. The problem was
motivated by the following observation:

```a locally private d-bin histogram has, on some bin, error scaling with √log d. But when users trust the analyzer with their raw data (the
central model), there is an algorithm that achieves error independent
of d on every bin.
```


The best known sample complexity for the local model can be found in
[[3][3]] and for the central model in [[4][4]].

## Background Material 

This is material that we need to be able to derive the proofs in the
paper. Researchers in [[1][1]] identified a class of distributions and
argue that, if $\eta$ is sampled from such a distribution, adding
$\eta$ to any output of a 1-sensitive function ensures differential
privacy of that sum. Histogram sums where records differ by one count
are 1-sensitive functions; thus adding a noise drawn from such a
distribution will get you diffential privacy.

### Smooth Distributions {#definition-smooth}

Source: [[1][1]]

A distribution $\D$ is smooth over $\Z$ is $(\epsilon, \delta, k)$
smooth, if $\forall k' \in [-k, k]$ if the event E

$$\P{E \geq e^{|k'|\epsilon}}{Y}{\D} \leq \delta$$ or 

$$\P{E < e^{|k'|\epsilon}}{Y}{\D} > 1 - \delta$$

<div class=intuition>The second equation looks a lot like a concentration inequality
i.e. it is saying that the value of the event being concentrated
within the window is quite high.

This already looks a lot like Differential Privacy, which says, for DP
to hold the ratio of the probabilities of a function outputting the
same value on neigbhouring datasets is bounded by an exponential
function as shown above with probability 1 - $\delta$</div>

The Event $E$ is defined as the following

$$E=\frac{\P{Y'=Y}{Y'}{D}}{\P{Y'=Y+k'}{Y'}{D}}$$

It's saying if I draw a random variable from $Y \sim \D$; the
probability of drawing another variable $Y' \sim \D$ within a window
of [Y, Y+k'] is quite close to the original probability of drawing $Y$
to begin with.

<!-- [Heading IDs](#custom-id)
-->
### Lemma 2: Adding Noise from smooth distributions is a DP mechanism {#lemma-smooth}

Let $f: \Z^n \rightarrow \Z$ be a function such that it is 1 sensitive
i.e. $|f(x) - f(x')| \leq 1$ for all $x \sim x'$. Let $\D$ be a
$(\epsilon, \delta, 1)$ smooth distribution. Then the algorithm that
takes $x \sim \Z^n$, and outputs $f(x) + \eta$ where $\eta \sim D$ is
DP.

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#smmothNoiseIsDp">Proof</button>
<div class=collapse id=smmothNoiseIsDp>

Need to read original paper in detail

</div>


### Lemma 3: The binomial distribution is smooth

For any positive integer n, and $\gamma \in [0,1/2], \alpha \in [0,1]$
and any $k \leq \alpha\gamma/2$, $Binomian(n, \gamma)$ is $(\epsilon,
\delta, k)$ smooth with 

$$\epsilon = \log\big( \frac{1 + \alpha}{1 - \alpha}\big)$$ and 

$$\delta= exp(-\frac{\alpha^2\gamma n}{8}) + exp(-\frac{\alpha^2\gamma n}{8+2\alpha})$$

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#binIsSmooth">Proof</button>
<div class=collapse id=binIsSmooth>

Need to read original paper in detail

</div>

## Introduction 

There has been a lot of work on local privacy. See here **TODO**. A
new paradigm of privacy is shuffle privacy. In this paper, the authors
try and understand the guarantees of shuffle privacy with respect to
local privacy for the histogram sum estimation problem. There are two
major findings:

1. The authors present a protocol in the shuffled model that estimates
   histograms with error independent of the domain size. This implies
   an arbitrarily large gap in sample complexity between the shuffled
   and local models. <div class=question>I have not verified myself
   what the accuracy guarantees of known local models are. Perhaps
   this is something I should do. But Grahams survey paper does this</div>
2. Local and shuffle privacy are equivalent when we impose the
   constraints of pure differential privacy and single-message
   randomizers.
   Not anymore: <div class="question"> [Now there (Sep 2021)](/ShuffleSumMeanEstimateRasmus/) there is a paper that gives near central guarantees for shuffle DP with near constant message complexity. Howo does this affect this papers findings? </div>

## The binary histogram

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

**ANANLYSER: **$\ABinHist$

Input: 

* $n$ outputs of $\RBinHist$: which is a steam of 1's i.e $y \in \{ 1\}^*$
* $(\epsilon, \delta) \in [0,1]$

Method: 

1. $1 - p = \frac{50}{\epsilon^2 n}\log(\frac{2}{\delta})$
2. $c^* = \frac{1}{n}|y|$ where |.| is the length of a stream

Output:

3. if c* > 1 : return (c* - p) else: return 0
   

</div>

### Theorem: The above proptocol is DP for the shuffled model {#theorem-binHistDP}

For any $\epsilon, \delta \in [0,1]$ and any $n \in \N$ such that $n
\geq \frac{100}{\epsilon^2}\log(\frac{2}{\delta})$, the protocol
$(\PBinHist = \RBinHist, \ABinHist)$ has the following properties: 

1. $\PBinHist$ is $\epsDelta$-differentially private in the shuffled
   model. 
   
2. For $\beta > \delta^{25}$, the error $|\PBinHist(X) -
   \frac{1}{n}\sum_{i=1}^n x_i| \leq \alpha$ with probability $1 -
   \beta$

3. If $X=(0,...0)$, then $\PBinHist(X)=0$ i.e. we have 0 error. <div
   class=question></div>
   
<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#binHistProof">Proof</button>

<div class=collapse id=binHistProof>

### Part I : Proving DP 

Part I of this proof comes from background material section. The first
question of concern is under what conditions, is sampling from a
binomial distribution $(\epsilon, \delta, 1)$ smooth. Then all that
remains to be shown is that, the above algorithm is basically adding
noise drawn from a binomial to the exact binary sum, which by Lemma 2
is DP.

#### Under what conditions is the Binomial 1-smooth

By Lemma 3, We know a binomial is k-smooth if $\epsilon = \log\big(
\frac{1 + \alpha}{1 - \alpha}\big)$ and $\delta=
exp(-\frac{\alpha^2\gamma n}{8}) + exp(-\frac{\alpha^2\gamma
n}{8+2\alpha})$ for any $\alpha \in [0,1]$

Note that for $\alpha < 1$, we have $exp(-\frac{\alpha^2\gamma
n}{8}) + exp(-\frac{\alpha^2\gamma n}{8+2\alpha}) <
exp(-\frac{\alpha^2\gamma n}{10}) + exp(-\frac{\alpha^2\gamma n}{10})
= 2exp(-\frac{\alpha^2\gamma n}{10})$

Now if we restrict $\alpha \in [\epsilon/\sqrt{5}, 1)$ and set $\alpha
= \frac{e^\epsilon - 1}{e^\epsilon + 1}$, then we get the following
bound from $\delta$ <div class="question"> It is not immediately clear
why they picked square root of 5: but here is my
understanding</div><div class=intuition>Given $\alpha$ is already
defined in terms of $\epsilon$. The authors want to find a simpler
lower bound for $\alpha^2$ in temrs of $\epsilon$. As there is a
squared, they picked the smallest integer such that $\alpha > 0$ for
all values of $\epsilon \in [0,1]$ Shown below are plots for $\alpha -
\frac{\epsilon}{\sqrt{5}}$ and $\alpha -
\frac{\epsilon}{\sqrt{4}}$. Clearly, $\frac{\epsilon}{\sqrt{5}} \geq
\alpha$ $\forall \epsilon \in [0,1]$. Now that they have lower bounded
$\alpha$ by a simple $\epsilon$ we can just use it in the $\delta$
bound.</div>

<div class=row>
<div class=col-md-6><img src=pngs/5.png></img></div>
<div class=col-md-6><img src=pngs/4.png></img></div>
<div class=col-md-6></div>
</div>

\begin{align}
2exp(-\frac{\alpha^2\gamma n}{10}) &\leq 2\exp(-\frac{\epsilon^2\gamma n}{50})  \label{eq1}\tag{1}0C\ \\
	&= \delta \\
\frac{\gamma\epsilon^2n}{50} &= \log(\frac{2}{\delta}) \label{eq2}\tag{2}\\
\gamma &= \frac{50}{\epsilon^2n}\log(\frac{2}{\delta})
\end{align}

$\ref{eq1}$ Substituiting the smallest value of $\alpha = \epsilon/\sqrt{5}$

$\ref{eq2}$ Re-arranging terms to get a value for $\gamma$

But we really need is 1-smooth, so we need 

$$ n\alpha\gamma \geq 2 $$

We are interested in the smallest value of $n\alpha\gamma$,
which we get trivially by plugging it the smallest value of $\alpha =
\epsilon/\sqrt{5}$, the theorem definition states $n=
\frac{100}{\epsilon^2}\log(\frac{2}{\delta})$ and from the above
derivation we get $\gamma
=\frac{50}{\epsilon^2n}\log(\frac{2}{\delta})$


\begin{align}
n\alpha \gamma &= \frac{50}{\epsilon^2}\log(\frac{2}{\delta})\frac{\epsilon}{\sqrt{5}} \\
&=\frac{10\sqrt{5}}{\epsilon}\log(\frac{2}{\delta}) \\
&\geq \frac{10\sqrt{5}}{1}\log(\frac{2}{1}) \label{eq3}\tag{3} \\
&\geq 2
\end{align}

$\ref{eq3}$ by plugging in the largest values for $\epsilon, \delta =
1, 1$ 

In conclusion -- the conditions of seting any $\epsilon, \delta \in
[0,1]$ and any $n \in \N$ such that $n \geq
\frac{100}{\epsilon^2}\log(\frac{2}{\delta})$ makes sampling from the
$Binmonial(n, \gamma)$ 1-smmoth. Now all that remains is to show is
that the algorithm described above just adds binomial noise to a
1-sensitive function.

#### The above algorithm just adds noise drawn from a binomial distribution to the true sum

If we let $z_i \sim Bernoulli(1 - \gamma)$ be the random bit (heads or
tails) generated by the i-th user, the total number of messages is
$|y| = \sum_{i=1}^n x_i + z_i$. Here $\gamma=1-p$ as defined in the
algorithm above and re-derived in the proof above. Observe that
learning $|y|$ is sufficient to represent the output of shuffler since
all messages have the same value i.e. they are all 1s. We can say the
above algorithm is equivalent to the following

\begin{align*}
|y| &= \sum_{i=1}^n x_i + z_i \\
	&= \sum_{i=1}^n x_i + \sum_{i=1}^n z_i \\
	&= \sum_{i=1}^n x_i + Binomial(n, 1 - \gamma) \\
	&= \sum_{i=1}^n x_i + n - Binomial(n, \gamma) \\
	&= -\Big (-\sum_{i=1}^n x_i  + Binomial(n, \gamma) \Big) + n \\
	&= -\Big (M_{neg}(X) \Big) + n \\	
\end{align*}

If show the output of $M_{neg}(X)$ is DP, then it follows by the
deterministic post processing rule of DP that the full algorithmis DP. 

For neighbouring detasets $X \sim X'$, $\sum_{i=1}^n x_i$ is a
1-sensitive function. Thus we are adding noise drawn from a
$(\epsilon, \delta, 1)$ smooth binomial distrubution to a 1-sensitive
function. Thus the output of the shuffler $(S \circ R)(X)$ is DP
making the algorithm shuffle DP.

### The accuracy of the protocol (part II)

Now onto part ii of the theorem. We have shown it is private but how
much information do we lose? <div class=question>This section in the
paper has many typos. I am going to try and re-derive them
myself.</div>




### No error guarantee (part III)

If $X = (0,...,0)$, then $|y|$ is drawn from $0+ Binomial(n,p)$, which
implies $c^* \leq 1$ with probability 1. Hence, $\PBinHist(⃗X) = 0$

</div>

## Histogram summing the full version

The full version of the histogram just uses $\PBinHist$ for each
coordinate $j \in [d]$ where $d$ is the dimension of the histogram.

### An algorithm for histogram sums on integers that satisfies shuffle privacy

<div class="algorithm">

**RANDOMISER:** $\RHist(x \in [d])$

Input: 

* $x \in [d]$
* $(\epsilon, \delta) \in [0,1]$

Method: 

1. For each $j \in [d]$, $b_j = \mathbb{1}(x=j)$ and compute the
   scalar product $m_j=j.\RBinHist(b_j)$

Output: 

2. Output the concatenation of the $m_j$'s

**ANANLYSER: **$\AHist$

Input: 

* $y \in [d]^*$
* $(\epsilon, \delta) \in [0,1]$

Method: 

1. For each $j \in [d]$, let $y_j$ be all the 1 bits from the
   randomiser with value $j$. $\tilde{c_j}=\ABinHist(y_j)$
2. Output $(\tilde{c_1}, \tilde{c_2}, \dots, \tilde{c_d})$

Output:

3. if c* > 1 : return (c* - p) else: return 0
   

</div>

### Theorem: The above proptocol is DP for the shuffled model {#theorem-HistDP}

For any $\epsilon, \delta \in [0,1]$ and any $n \in \N$ such that $n
\geq \frac{100}{\epsilon^2}\log(\frac{2}{\delta})$, the protocol
$(\PHist = \RHist, \AHist)$ has the following properties: 

1. $\PHist$ is $2\epsDelta$-differentially private in the shuffled
   model.
   
2. For $\beta > \delta^{25}$, $\PHist$ has $(\alpha, \beta)$ accuracy
   for $\alpha = O(\frac{1}{\epsilon^2n}\ln(\frac{1}{\delta}))$

3. For $\beta > \delta^{25}$, $\PHist$ has $(\alpha, \beta)$
   simultaneous accuracy for $\alpha =
   O(\frac{1}{\epsilon^2n}\ln(\frac{1}{\delta}))$
   
4. Each user sends at most d+1 messages.


<button type="button" class="btn btn-info" data-toggle="collapse"
data-target="#histProof">Proof</button>

<div class=collapse id=histProof>

#### Part (i)

Consider two neighbouring datasets $X \sim X'$ i.e. they differ by one
record only. So one person in $X$ has value $j$ and one person in $X'$
has $j'$.

Let $y \sim (S \circ \RHist)(X)$ and $y \sim (S \circ
\RHist)(X')$. For any $j \neq j'$, the count of $j$ in the shuffler is
independent of $j'$ as they run in independent trials of
$\RBinHist$. Let $y_j$ be all the 1 bits from the randomiser with
value $j$ like in part 1 of $\AHist(X)$ and $y_j'$ be the same for
$\AHist(X')$. For any $j \in [d]$, if $c_j(X) = c_j(X')$ then $y_j$
and $y_j'$ are identically distributed so they trivially satisfy
DP. When $c_j(X) \neq c_j(X')$ we can show that are still close in
likelihood. Let $r, r' \in \{ 0, 1\}^n$ such that $r_i =
\mathbb{1}(x_i=j)$

By defintion:

$y_j \sim (S \circ \RBinHist)(r)$ and $y_j' \sim (S \circ
\RBinHist)(r')$. Thus we know, from the binary histogram protocol part
(i) that

$$\P{y_j \in T}{y_j}{(S \circ \RBinHist)(r)} \leq e^{\epsilon}\P{y_j'
\in T}{y_j'}{(S \circ \RBinHist)(r')} + \delta$$

Since the two datasets differ at two indices, by the composition
theorem we get $(2\epsilon, 2\delta)$ for the full protocol.


#### Part (ii)

This comes for free from $\PBinHist$ part (ii) accuracy bound. Note
each $\tilde{c_j} = \PBinHist(\{b_{ij}\}_{i \in [n]})$. We know
$\PBinHist$ gives us $(\alpha, \beta)$ accuracy.


#### Part (iii)

To bound simultaneous error, we leverage the property that when
\tilde{c(x)} = 0, the counting protocol will report a nonzero value
with probability 0. Let Q be the set of non zero indices in the
dataset such that $Q = \{ j \in [d] | c_j(x) > 0\}$

From part (ii) we have with probability $\beta/n$ there exists an
index $j$ st $(\tilde{c_j(x)} - c(x)) \leq \alpha$ with $\alpha$ as
defined in the binary histogram protocol.

\begin{align*}
\mathbb{P}\Big( \exists j \in [d] \tilde{c_j}(x) - c_j(x) \leq \alpha\Big) 
&\leq \mathbb{P}\Big( \exists j \in Q \text{ } \tilde{c_j}(x) - c_j(x) \leq \alpha\Big) + \mathbb{P}\Big( \exists j \notin Q \text{ } \tilde{c_j}(x) - c_j(x) \leq \alpha \Big) \\
&= \mathbb{P}\Big( \exists j \in Q \text{ } \tilde{c_j}(x) - c_j(x) \leq \alpha\Big) \label{eq4}\tag{4} \\
&\leq \sum_{j \in Q} \mathbb{P}\Big( \tilde{c_j}(x) - c_j(x) \leq \alpha\Big) \label{eq5}\tag{5} \\
&\leq \beta/n \label{eq6}\tag{6} \\
&= \beta
\end{align*}


$\ref{eq4}$ : comes from $\PBinHist$ part (iii) for all 0 input.

$\ref{eq5}$ : Union bound

$\ref{eq6}$ : comes from $\PBinHist$ part (ii) accuracy bound.

#### Part (iv)

For the j'th index which is 1 there can be at the most 2 bits. One
from the bernoulli and one from the input. All other indices can have
at the most 1 bit from the bernoulli. So There are $d$ indices, thus
d + 1 messages/bits/1's maximum.

</div>

## Pure Shuffle Privacy

It can be shown that if we restricted to pure differential privacy
i.e. a deterministic concentration inequality Shuffle privacygives us
the same guarantees as local privacy for single message
communicatiom. 

The authors claim that any single-message shuffled protocol that
satisfies $\epsilon$-differential privacy can be simulated by a local
protocol under the same privacy constraint.



### Single Message Shuffle => It's randomiser is central DP.

<div class=lemma> Let $P = (R,A)$ be any single-message shuffled
protocol that satisfies $\epsilon$-differential privacy. Then $R$ is
an $\epsilon$-differentially private algorithm.
</div>


There exists a multi-message shuffled protocol that is
$\epsilon$-differentially private for all ε ≥ 0 but its randomizer is
not $\epsilon$-differentially private for any finite ε.

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#shuffleRisDP">Proof</button>
<div class=collapse id=shuffleRisDP>

Proof the contrapositive. Assume $R$ is not $\epsilon$ DP. If we show
$(S \circ R)(X)$ is also not DP, then we are done.

By our assumption, there exists $x \sim x'$ and a $Y \in \mathbb{Y}$
such that

$$ \mathbb{P}( R(x) \in Y) > e^{\epsilon} \mathbb{P}( R(x') \in Y)$$

Assume datasets X and X' such that, $X = (x, ..., x)$ contains $n$
copies of $x$ and $X' = (x', x, ..., x)$, contains $n-1$ copies of $x$
and $x'$.


\begin{align*}
\mathbb{P}[(S \circ R)(X) \in Y^n] &= \mathbb{P}[(R)(X) \in Y^n] \label{eq7}\tag{7}\\
&= \mathbb{P}[(R)(X) \in Y]^n \label{eq8}\tag{8}\\
&> e^{\epsilon} \mathbb{P}[ R(x') \in Y]\mathbb{P}[ R(x') \in Y]^{n-1} \label{eq9}\tag{9}\\
&= e^{\epsilon} \mathbb{P}[ (S \circ R)(X') \in Y^n]
\end{align*}


$\ref{eq7}$ : The shuffle is uniformly random, so no shuffle has equal
probability as any other permutation. 

$\ref{eq8}$ : Each local randomiser is independent of other inputs

$\ref{eq9}$ : By assumption

</div>

### Single Message Shuffle => There exists equivalent local

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#shuffleHasLocalCounterpart">Proof</button>
<div class=collapse id=shuffleHasLocalCounterpart>

Assume there is an Aggregator $A_L$ that takes the output of the local
randomisers and applies a uniform shuffling and then executes $A$ from
the Shuffle model. <div class=intuition> Note this only works because
they are single bit messages. As to why see roadblocks section</div>In
this case $P_L =( R, A_L)$ has the same distribution as the shuffle
model $P$ for all $x$ i.e $P(X) \approx P_L(X)$ $\forall X \in
X^n$. By the previous lemma $R$ is differentially private -- which is
what I needed for local DP.

</div>

## Multi Message Shuffle Privacy does not play so well

### Shuffle ==> but not local

<div class=lemma> There exists a multi-message shuffled protocol that
is $\epsilon$-differentially private for all $\epsilon \geq 0$ but its
randomiser is not DP for any $\epsilon$.  </div>

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#multishuffleLocalBreaks">Proof</button>
<div class=collapse id=multishuffleLocalBreaks>

Consider $R$ on input $x \in \{0, 1\}$ such that it outputs two
messages x and 1-x. The Shuffle output $(S \circ R)(X)$ consists of n
0's and n 1's in any possible order. So for two $X$ and $X'$ the
ouputs are indistinguishable. However R(x) reveals the input value and
is not local DP at all.  </div>


### Shuffle ==> Randomiser not DP


We note that it is without loss of accuracy or privacy to suppose that
a randomizer shuffles its messages prior to sending them to the
shuffler. We call these pre-shuffle randomizers. Observe that the
pre-shuffle version of R defined above, satisfied $0-DP$. One might
conjecture Claim 4.2 holds for pre-shuffle randomizers and thus
generalize Theorem 4.1. But that too is not the case

<div class=lemma> There exists a multi-message shuffled protocol that
is $\epsilon$-differentially private for some finite $\epsilon$ but
its pre-shuffle randomizer is not $\epsilon$-differentially private
for any finite $\epsilon$.  </div>

<button type="button" class="btn btn-info" data-toggle="collapse"
data-target="#multishuffleLocalBreaks2">Proof</button> <div
class=collapse id=multishuffleLocalBreaks2>

Consider the randomiser $R^{gap}$ which takes in input $x \in \{0 , 1
\}$ and outputs 4 binary messages/bits. If the input is 0 all 16
values are possible. If the input is 1, then the output cannot have 2
1's in the output. Note that if we saw output (0,1,1,0) we would know
the input value. Thus $R^{gap}$ cannot be DP. However for $n \geq 2$,
the shuffle output $(S \circ R)(x)$ can generate all possible values
in $\{0,1 \}^4n$, thereby giving us perfect shuffle privacy for some
$\epsilon > 0$.

<div class=question>I do not fully understand why yet -- but they did
give a reason. On the train I can work it out.

</div>
</div>

## Important Papers


[1]: https://arxiv.org/pdf/1908.11358.pdf  "On the power of multiple anonymous messages"
1. [On the power of multiple anonymous messages](https://arxiv.org/pdf/1908.11358.pdf)

[2]: https://arxiv.org/pdf/0803.0924.pdf  "What can we learn privately"
2. [What can we learn privately](https://arxiv.org/pdf/0803.0924.pdf)

[3]: https://arxiv.org/pdf/1504.04686.pdf "Local, Private, Efficient Protocols
for Succinct Histograms"
3. [Local, Private, Efficient Protocols for Succinct
Histograms](https://arxiv.org/pdf/1504.04686.pdf) 

[4]: https://arxiv.org/pdf/1511.08552.pdf "Simultaneous Private Learning of Multiple Concepts"
4. [Simultaneous Private Learning of Multiple Concepts](https://arxiv.org/pdf/1511.08552.pdf)


[5]: https://arxiv.org/pdf/2109.13158.pdf "Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message"
5. [Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message](https://arxiv.org/pdf/2109.13158.pdf)

</div>