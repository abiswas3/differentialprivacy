\newcommand{\ZP}[1]{\mathbb{Z}_p^{#1}}
\newcommand{\Z}{\mathbb{Z}_p}
\newcommand{\NP}{\mathcal{NP}}
\newcommand{\IP}{\mathcal{IP}}
\newcommand{\P}{\mathcal{P}}
\newcommand{\BPP}{\mathcal{BPP}}
\newcommand{\AngleBracket}[1]{\langle #1 \rangle}
\newcommand{\genF}{f : \{0, 1\}^* \rightarrow \{0, 1\}^*}

<div class="container"> 

**Why:**These notes are based on Chapter 4 of [[1][1]]. At the time of writing, I wanted to understand and re-derive the proofs for Poplar and Prio, so I could write my own paper.

## Understanding Zero Knowledge Proofs

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

## Every language in $\NP$ has an interactive proof system

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



## THEOREM

<div class="theorem">
Existence of weak one way functions implies existence of strong one way functions
</div>


# References 

[1]: https://www.amazon.co.uk/Foundations-Cryptography-v1-Basic-Tools/dp/0521035368 "Foundations of Cryptography V1"
1. [Foundations of Cryptography V1](https://www.amazon.co.uk/Foundations-Cryptography-v1-Basic-Tools/dp/0521035368)


</div>
