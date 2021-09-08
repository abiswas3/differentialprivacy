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
   this is something I should do.</div>
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
   
2. For $\beta > \delta^{25}$, the error $|\PBinHist(X) -
   \frac{1}{n}\sum_{i=1}^n x_i| \leq \alpha$ with probability $1 -
   \beta$

3. If $X=(0,...0)$, then $\PBinHist(X)=0$ i.e. we have 0 error. <div
   class=question></div>
   
<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#binHistProof">Proof</button>

<div class=collapse1 id=binHistProof>

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
2exp(-\frac{\alpha^2\gamma n}{10}) &\leq 2\exp(-\frac{\epsilon^2\gamma n}{50})  \label{eq1}\tag{1}\ \\
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

### The accuracy of the protocol

Now onto part ii of the theorem. We have shown it is private but how
much information do we lose? <div class=question>This section in the
paper has many typos. I am going to try and re-derive them
myself.</div>

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

## Important Papers

[1]: https://arxiv.org/pdf/1908.11358.pdf  "On the power of multiple anonymous messages"
1. [On the power of multiple anonymous messages](https://arxiv.org/pdf/1908.11358.pdf)

[2]: https://arxiv.org/pdf/0803.0924.pdf  "What can we learn privately"
2. [What can we learn privately](https://arxiv.org/pdf/0803.0924.pdf)
</div>
