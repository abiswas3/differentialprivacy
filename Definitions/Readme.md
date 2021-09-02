\newcommand{\P}[3]{\mathbb{P}_{#2 \sim #3}\Big[#1\Big]}
\newcommand{\D}{\mathbb{D}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
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
