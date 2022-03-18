\newcommand{\ZP}[1]{\mathbb{Z}_p^{#1}}
\newcommand{\Z}{\mathbb{Z}_p}
\newcommand{\NP}{\mathcal{NP}}
\newcommand{\IP}{\mathcal{IP}}
\newcommand{\P}{\mathcal{P}}
\newcommand{\BPP}{\mathcal{BPP}}
\newcommand{\Pr}[1]{\mathbb{P}\Big[ #1\Big]}
\newcommand{\AngleBracket}[1]{\langle #1 \rangle}
\newcommand{\genF}{f : \{0, 1\}^* \rightarrow \{0, 1\}^*}
\newcommand{\PZK}{\mathcal{PZK}}
---
title: Notes on Zero Knowledge
...

<div class="container"> 

**Why:**These notes are based on Chapter 4 of [[1][1]]. At the time of writing, I wanted to understand and re-derive the proofs for Poplar and Prio, so I could write my own paper.

## Basics of Zero Knowledge proofs

*These are quite scrappy and needs consolidation over time* 

## Knowledge Vs Information

*Knowledge is related to computational difficulty, whereas information is not*. Assume that Alice and Bob have access have access to a public Graph $G$. Alice answers questions of the form "Is the graph Eulerian?" or “Is the graph Hamiltonian?”. From an information-theory point of view, answers to both questions give Bob 1 bit of information (yes or a no), so the answers are equivalent. 

*Knowledge relates mainly to publicly known objects,whereas information relates mainly to objects on which only partial information is publicly known.*
Consider the case in which Alice answers each question by flipping an unbiased coin and telling Bob the outcome. From an information-theoretic point of view, Bob gets from Alice information concerning an event. However, we say that Bob gains no knowledge from Alice, because he could toss coins by himself.
 
## Notation

Let $A$ and $B$ be two interactive turing machines (ITM). Let $\AngleBracket{A,B}(x)$ be the random variable representing the local output of $B$ when interacting with $A$ on common input $x$.

<div class="theorem">
<b>The Complexity of an Interactive Machine: </b> We say that an ITM $A$ has time complexity $t: \mathbb{N} \rightarrow \mathbb{N}$, if for **every** ITM $B$ and **every** common input string $x$, machine $A$ regardless of its or $B$'s random tape; halts in $t(|x|)$ steps. $A$ is poly time if there exists a polynomial $p$ such that $t=p$.
</div>

### Interactive Proof System

<div class="theorem">
A pair of ITM's $(P,V)$ is called an interactive proof system for a language $L$ if machine $V$ is polynomial time and the following two hold:

1. Completeness: For every $x \in L$ and given prover $P$, we have $\mathbb{P}[\AngleBracket{P,V}(x) = 1] \geq \frac{2}{3}$

2. Soundness: For every $x \notin L$ and <u>and every interactive machine $B$</u>, we have $\mathbb{P}[\AngleBracket{B,V}(x) = 1] \leq \frac{1}{3}$
</div>

### Every language in $\NP$ has an interactive proof system

By definition of $\NP$ there is a polynomial time verifier that approves provers witness.

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#blah">Exercise 2: Only languages in $\NP$ have interactive proof systems in which both parties are deterministic</button>
<div class=collapse id=blah>
</div>
<br>

 
In other words, $\NP$ can be viewed as a class of interactive proof systems in which the interaction is unidirectional (i.e., from the prover to the verifier) and the verifier is deterministic (and never errs)

In general proof systems, this requirement is waived. The communication is bi-directional and the verifier could be probabilistic. Such a class is referred to as $\IP$

## Example: Graph Isomorphism

Two graphs $G_1=(V_1, E_1), G_2 = (V_2, E_2)$ are isomorphic if there exists a 1-1 and onto mapping $f$ such such that any two vertices $u$ and $v$ of $V_1$ are adjacent in $G_1$ if and only if $f(u)$ and $f(v)$ are adjacent in $G_2$.

<img src="./pngs/isomorphism.png">*Picture from Wikipedia*</img>


### An Interactive Proof System for Graph Non-Isomorphism

Watch first 30 min of this [lecture video](https://www.youtube.com/watch?v=6MshCKY5bTc&list=PLGkwtcB-DfpzST-medFVvrKhinZisfluC&index=2) for better explanation

We want the verifier to accept if two graphs are non-isomorphic and reject otherwise with correctness and soundness as defined above. **NOTE**: we need a **honest** prover with unbounded computation capability to do this. This doesn't matter, as the definitions only require the verifier to be poly time.

The proof goes as follows:

<div class="algorithm">
1. The verifier samples a bit $\sigma \in \{1, 2\}$. It then picks a random permutation $\pi$ from the set of all random permutations, and permutes $V_\sigma$ to get $H = \{ (\pi(u), \pi(v)): (u,v) \in E_\sigma\}$.

2. The **honest prover** is all powerful, and is able to figure out if $H$ isomorphic to $G_1$ or $G_2$. Let $H$ be isomorphic to $G_b$ where $b \in \{1, 2\}$. It then sends $b$ back to the verifier.

3. If $b = \sigma$ then the verifier accepts.
</div>
<br>

**Completeness:** If the graphs are non isomorphic, the $b$ will always be equal to $\sigma$. It accepts with no error.

**Soundness:** If the graphs are isomorphic, then the prover will then both $b$'s are equally likely and we get accept with probability $1/2$. This holds as long as $b$ is secret (private coin) -- but this not essential as there is a way to convert this into a public coin protocol with one more round. 



## Zero Knowledge

Loosely speaking, we say that an interactive proof system $(P, V)$ for a language $L$ is zero-knowledge if whatever can be efficiently computed after interacting with $P$ on input $x \in L$ can also be efficiently computed from $x$ (without any interaction).

We stress that this holds with respect to any efficient way of interacting with $P$, not necessarily the way defined by the verifier program $V$. Actually, zero-knowledge is a property of the prescribed prover $P$. It captures $P$’s robustness against attempts to gain knowledge by interacting with it.

### Definition: Impossible perfect ZK

<div class="theorem">
For a given interactive proof system $\AngleBracket{P,V}$ and common input $x$, $P$ is perfectly zero knowledge if for **every** probabilistic poly time verifier $V^*$, there exists an ppt algorithm $M^*$ such that for ever $x \in L$ the following random variables are identically distributed: 

1. $\AngleBracket{P,V^*}(x)$: Output of interactive verifier.
2. $M^*(x)$: Just the output of $M^*$ on x.
</div>

<br>
<div class="important">
Machine $M^{*}$ is called a simulator for the interaction of $V^*$ with P.
</div>


```Admittedly, failure to provide a simulation of an interaction with the outside does NOT necessarily mean that this interaction results in some “real gain” (in some intuitive sense). Yet what matters is that any “real gain” can NOT occur whenever we are able to present a simulation.```

Trivially, any language in $\BPP$ has a perfect zero knowledge proof.

### Definition: Relaxed (practical) perfect ZK

Unfortunately, the above definition is too strict. No one has yet shown a non trivial case where all the requirements are satisfied. So we define a relaxation by allowing the simulator to fail to come up with an answer with probability at most $\frac{1}{2}$. This relaxation is just allowing the simulator to fail to say anything at times. 

<div class="theorem">
For a given interactive proof system $\AngleBracket{P,V}$ and common input $x$, $P$ is perfectly zero knowledge if for **every** probabilistic poly time verifier $V^*$, there exists an ppt algorithm $M^*$ such that for ever $x \in L$ the following random conditions hold: 

1. With probability at most $\frac{1}{2}$ on input $x$ machine $M^*$ outputs a special symbol denoted by $\bot$. 
2. Let $\Pr{m^*(x) = \alpha} = \Pr{M^*(x) = \alpha | M^*(x) \neq \bot}$ for every $\alpha \in \{ 0, 1\}^*$. Then apply perfect zero knowledge on $m^*(x)$ by requiring the output of $\AngleBracket{P,V^*}(x)$ and $m^*(x)$ be identically distributed.
</div>	
<br>
<div class="important">
Machine $M^{*}$ is called a simulator for the interaction of $V^*$ with P.
</div>


## Practical definition of Zero Knowledge

We observe (based on some bits in chapter 3) that for practical purposes there is no need to be able to “perfectly simulate” the output of $V^*$ after it interacts with $P$. Instead, it suffices to generate a probability distribution that is computationally indistinguishable from the output of $V^*$ after it interacts with $P$.

### Computational indistinguishability

<div class="theorem">
Ensembles $\{ R_x\}_{x \in L}$ and $\{ S_x\}_{x \in L}$	are computationally indistinguishable if for **every** ppt algorithm D and for **every** polynomial, for sufficiently long $x \in L$, it holds that 

\begin{align*}
\Bigg| \Pr{D(x, R_x)=1} - \Pr{D(x, S_x)=1}\Bigg| &< \frac{1}{p(|x|)} 
\end{align*}
</div>	
<br>

### Computational Zero Knowledge

Note that computational zero knowledge is weaker than statistical
distance. Two ensembles might be statistically very far but if no
probabilistic polynomial time distinguisher/algorithm can
differentiate between the two then we are fine.

<div class="theorem"> Let $(P, V)$ be an interactive proof system for
some language $L$. We say that $(P, V)$ is computationally zero
knowledge or just simply zero knowledge if for **every** probabilistic
poly time verifier $V^*$, there exists a probabilistic ppt algorithm
$M^*$ such that the following two ensembles are computationally
indistinguishable:

1. $\{\AngleBracket{P,V^*}(x)\}_{x \in L}$: Output of interactive verifier.
2. $\{M^*(x)\}_{x \in L}$: Just the output of $M^*$ on x.

</div>
<br>

<div class="important">
Machine $M^{*}$ is called a simulator for the interaction of $V^*$ with P.
</div>

## Alternate: ZK

An alternative formulation of zero-knowledge considers the verifier’s
view of the inter- action with the prover, rather than only the output
of the verifier after such an interaction. By the “verifier’s view of
the interaction” we mean the entire sequence of the local
configurations of the verifier during an interaction execution) with
the prover.

It suffices to consider only the content of the random tape of the
verifier and the sequence of messages that the verifier has received
from the prover during the execution (since the entire sequence of
local configurations and the final output are determined by those
objects).


<div class="theorem"> Let $(P, V), L$ and $V^*$ be as defined
above. Denote $\text{view}^P_{V^*}$ as the random variable describing
the contents of random tape $V^*$ and the messages $V^*$ receives from
$P$ during a joint computation on common input $x$. We say that
$(P,V)$ is ZK if for **every** ppt interactive verifier $V^*$ there
exists a probabilistic ppt algorithm $M^*$ such that
$\{\text{view}^P_{V^*}\}_{x \in L}$ and $\{M^*\}_{x \in L}$ are
computationally indistinguishable.  </div> <br>

Computational ZK and View based ZK differ in that one requires the
output of the verifier to be indistinguishable from the simulator
output and the other requires the view. Clearly the output can be
computed using the view using a deterministic poly-time algorithm but
the view cannot always be computed using just the output. Thus the
second definition guarantees the first definition and is usually
easier to work with (**and also seen in most papers**). It can be also
shown that the two definitions are equivalent (because of the
**every** condition in the verifier definition)

## Graph Isomorphism in Perfect Zero Knowledge $\PZK$

To do using Alessandro Chiesa's notes.

## Bit Commitment Scheme



# References 

[1]: https://www.amazon.co.uk/Foundations-Cryptography-v1-Basic-Tools/dp/0521035368 "Foundations of Cryptography V1"
1. [Foundations of Cryptography V1](https://www.amazon.co.uk/Foundations-Cryptography-v1-Basic-Tools/dp/0521035368)


</div>
