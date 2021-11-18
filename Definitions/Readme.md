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

<div class=container>
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
$\textit{R}$ and $\textit{A}$. Let $x \in X^n$. The evaluation of the
protocol \textit{P} on input $x$

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


## L1 Sensitivity {#definition-shuffleDP}

The $l_1$-sensitivity of a function $f: \N^{|X|} \rightarrow \R^k$ is defined as 

$$\Delta f = \text{max}_{|| x - x' ||_1 \leq 1} || f(x) - f(x')||_1$$

for any $x, x' \in \N^{|X|}$. 


Simply put, for neighbouring datasets$x, x'$, what is the maximum this function can differ by. High
sensitive functions are not good differential privacy, as by changing
just one input we see big differences in outputs -- thereby providing
information about the unique input to the function.


## Laplace Mechanism {#theorem-lapIsPrivate}

** FIX TYPOS in notation of proof. Using same variables over and over** 
Given $f: \N^{|X|} \rightarrow \R^k$, then the laplace mechanism is
defined as 

$$M_L\Big(x, f(.), \epsilon \Big) = f(x) + (Y_1, \dots, Y_k)$$ where
$Y_i \sim Lap(\frac{\Delta(f)}{\epsilon})$. **The laplace mechanism
preserves pure differential privacy**

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#laplaceMech">Proof</button>
<div class=collapse id=laplaceMech>

Let $f_x(z)$ be the density function for $M_L\Big(x, f(.), \epsilon
\Big)$. We want to show that $\frac{f_x(z)}{f_x'(z)} \leq
e^{\epsilon}$ where $x, x'$ differ by one element only.

We have $z_i= f_i(x) + Y_i$, the only randomness is from $Y_i$, thus
we have just scaled the noise $Y_i$ by a constant. Thus $f_x(z)$ is
just a laplace random variable with mean $f_i(x)$.


\begin{align*}
\frac{f_x(z)}{f_x'(z)} &= \prod_{i=1}^k \frac{\frac{exp\{-|f_i(x) - z_i|\epsilon}{\Delta f}\}}{\frac{exp\{-|f_i(x') - z_i|\epsilon}{\Delta f}\}} \\
&= \prod_{i=1}^k exp \{ \frac{\epsilon}{\Delta f}\Big(|f_i(x') - z_i| - |z_i - f_i(x)| \Big)\} \\
&\leq \prod_{i=1}^k exp \{ \frac{\epsilon}{\Delta f}|f_i(x') - f_i(x)| \} \label{eq1}\tag{1}\\
&= exp \{ \frac{\epsilon}{\Delta f}\sum_{i=1}^k|f_i(x') - f_i(x)| \}\\
&= exp \{ \frac{\epsilon}{\Delta f}||f(x') - f(x)||_1 \} \\
&\leq exp \{ \frac{\epsilon}{\Delta f} \Delta f \} \label{eq2}\tag{2} \\
&= exp(\epsilon)
\end{align*}

$\ref{eq1}$: Triangle inequality: $|A - C| \leq |A - B| + |B - C|$

$\ref{eq2}$: Definitition of $l_1$-sensitivity
</div>

#### Binary sums or real valued sums (counting and histogram queries)

Consider the example where each member of the popuplation $x \in X$
holds a value in $\{ 0, 1\}$ or in some bounded set of integers. We
want to estimate the sum of values for the population. Then the
sensitivity for this sum query function is either 1 for binary values
or the suprenum value of the population of integers. To report sums
differentially privately, the noise needed is $O(\frac{\Delta
f}{\epsilon})$. In the case of two neighbouring histograms, the
sensitivity is given by the maximum difference between two cell
values.

### Accuracy of the Laplace Mechanism {#theorem-lapAcc}

$\alpha, \beta$ accuracy

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#lapAcc">Proof</button>
<div class=collapse id=lapAcc>

</div>


### Exponential noise 

Similar bounds to Laplace

\begin{align*}
\mathbb{P}\Big[ \frac{M(D) \in T}{M(D') \in T}\Big] &= e^{-\lambda(|f(X) - f(X'))} \\
&\geq e^{-\lambda(\Delta f)} \\
&\geq e^{-\epsilon}
\end{align*}

where $\epsilon = \lambda \times \Delta f$ and $\lambda$ is the rate parameter of the noise distribution. The variance of the distribution is $\frac{1}{\lambda^2} = O(\frac{1}{\epsilon^2})$

### An experiment validating the theoretical bound

Writing a computer program to validate the above theory. The
concentration inequality says that if I performed the laplace
mechanism once then - the likelihood one of my dimensions is off by
$\log \frac{k}{\beta}\frac{\Delta f}{\epsilon}$ is $\beta$. Put in
otherwords, say I did the laplace mechanism a gazillion times on my
output. Only $\beta$ fraction of times will I get a bad event. A bad
event is when the laplace mechanism leads to an output very far from
the truth. So as an experiment, I generated many noisy but private
outputs and observed how often the infinity norm went outside the
boundary of the theorem. Was it more than theory claimed or less. It
turns out when the number trials is large i.e. empirical means are
close to actual means, the bound is quite tight.

 <embed type="text/html" src="code/sample.html" width="800" height="600"> 
 
### Why do smooth distributions with fatty tails work



## Exponential Mechanism

**This is a theoretical introduction of exponential mechanism. A
practical application of such an idea can be found in making password
lists private.** <div class=intuition>While final result of [the
password list problem](../passwordLists/) is relatively uninteresting
to me, the mathematics in the papers is quite interesting to me.</div>


Consider case where output of a function is very sensitive. Outputs
like voting counts or auction prices. Adding noise to these values
could damaging results. Take for example predicting the winner of the
Balon D'or football prize. Say 30 voters voted for Cristiano Ronaldo,
and 29 voters voted for Lionel Messi. The fair action of concern is to
award Ronaldo the prize. No one really cares how close we were in
approximating the number votes in terms of infinity norm to the actual
value, as long as the right player wins. In cases like this, adding
noise is not a viable solution as there is a significant chance that
we get a terrible outcome.


What happens when an algorithm outputs values in an arbitrary range
$R$ that is not $\R^k$ for $k \geq 1$. This is what the exponential
mechanism was designed for. Given some arbitrary range $R$, the
exponential mechanism is defined with respect to some utility function
$u: \N^{|X|} \times R \rightarrow \R$.

**Do not really understand** we care only about the sensitivity of u
with respect to its database argument; it can be arbitrarily sensitive
in its range argument. <div class=intuition>What they mean is that the
$r$ is somewhat of a free parameter. Given two neighbouring datasets
$x, x'$ the sensitivity is the maximum difference in their utility:
considering all values of the range those database arguments map
to.</div>


$$\S{u} := \max_{r \in R}\max_{|| x - x'||_1 \leq 1} | u(x,r) - u(x',
r)|$$


### The mechanism {#definition--expMech}

The basic idea is given some utility function, for a given $x \in
\N^{|X|}$, we want to the mechanism to output $r \in R \propto exp
\Big( \frac{\epsilon}{2\S{u}}u(x, r)\Big)$

### Exponential Mechanism is purely private

The exponential mechanism satisfies $(\epsilon, 0)$ privacy. Thus
there is never a chance of a bad event in the privacy sphere.

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#expMechIsPrivate">Proof</button>
<div class=collapse id=expMechIsPrivate>


</div>


## Important Papers

[1]: https://arxiv.org/pdf/1908.11358.pdf "On the power of multiple anonymous messages"
1. [On the power of multiple anonymous messages](https://arxiv.org/pdf/1908.11358.pdf)

[2]: https://arxiv.org/pdf/0803.0924.pdf  "What can we learn privately"
2. [What can we learn privately](https://arxiv.org/pdf/0803.0924.pdf)
</div>
