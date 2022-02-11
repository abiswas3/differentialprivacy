\newcommand{\ZP}[1]{\mathbb{Z}_p^{#1}}
\newcommand{\Z}{\mathbb{Z}_p}
\newcommand{\NP}{\mathcal{NP}}
\newcommand{\P}{\mathcal{P}}
\newcommand{\BPP}{\mathcal{BPP}}
\newcommand{\genF}{f : \{0, 1\}^* \rightarrow \{0, 1\}^*}

<div class="container"> 

**Why:**These notes are based on Chapter 2 of [[1][1]]. At the time of writing, I was interested in studying function secret sharing. All the work in function secret sharing needs some understanding of what one way functions are. Thus I was forced to make these notes.

# One Way functions

Loosely speaking, a one-way function is a function that is easy to evaluate but hard to invert (in an average-case sense). Since modern cryptography is based on a gap between efficient algorithms provided for the legitimate users and the computational infeasibility of abusing or breaking these algorithms (via illegitimate adversarial actions), one way functions are one of the fundamental building blocks of modern cryptography.

**Important:** The existence of secure encryption schemes implies that there are tasks (e.g., “breaking” encryption schemes) that can be performed by non-deterministic polynomial-time machines, yet cannot be performed by deterministic (or even randomized) polynomial- time machines. In other words, a necessary condition for the existence of secure encryption schemes is that $\NP$ not be contained in $\BPP$ (and thus $\P \neq \NP$).

Although $\P \neq \NP$ is a necessary condition for modern cryptography, it is not a sufficient one. Suppose that the breaking of some encryption scheme is $\NP$-complete. Then, $\P \neq \NP$ implies that this encryption scheme is hard to break in the **worst case**, but it does not rule out the possibility that the encryption scheme is easy to break almost always. Security requires hardness with high probability or the very least in the average case. Thus for security we need languages in $\NP$ that are hard on average.

However, even that condition is not sufficient. If we just had hard languages they would be hard for everyone, even legitimate users. We need hard languages that along with axillary information can be computed efficiently.

## Strong One Way functions

<div class="lemma">
A function $\genF$ is called **(strongly) one-way** if the following two conditions hold:

1. **Easy to compute:** There exists a (deterministic) polynomial-time algorithm $A$ such that on input $x$ algorithm $A$ outputs $f(x)$ (i.e., $A(x) = f (x)$).
2. **Hard to invert:** For every probabilistic polynomial-time algorithm $A^′$,every positive polynomial $p(·)$, and all sufficiently large $n$’s,

$$P_{u\sim U^n, r \sim U^m}\Big[A^'(f(u), r, 1^n) \in f^{-}(f(u))\Big] \leq \frac{1}{p(n)}$$

where $r$ represents the internal coin flips and $m=poly(n)$.
</div>

The second condition says that on average $f$ is hard to invert. Also any pre-image of $f(u)$ is bad not just the one that was used to create $f(u)$. The axillary input $1^n$ is given to tell the $A^'$ the size of the output, in the case $f$ shrunk the input.


**THERE are two more examples that I would like to understand more before moving on**

## Weak One way Function

<div class="lemma">
A function $\genF$ is called **weakly one-way** if the following two conditions hold:

1. **Easy to compute:** There exists a (deterministic) polynomial-time algorithm $A$ such that on input $x$ algorithm $A$ outputs $f(x)$ (i.e., $A(x) = f (x)$).
2. **Kinda Hard to invert:** <u>There exists positive polynomial</u> $p(·)$ such that for every probabilistic polynomial-time algorithm $A′$, and all sufficiently large $n$’s,

$$P_{u\sim U^n, r \sim U^m}\Big[A'(f(u), r, 1^n) \in f^{-}(f(u))\Big] \leq \frac{1}{p(n)}$$

where $r$ represents the internal coin flips and $m=poly(n)$.
</div>


**NOTE**: There exists a single polynomial $p(·)$ such that $\frac{1}{p(n)}$ lower-bounds the failure probability of all probabilistic polynomial-time algorithms trying to invert $f$ on $f(U^n)$.

### Functions defined only some lengths

### Length preserving functions

## Candidates for One way functions

### 

## THEOREM

<div class="theorem">
Existence of weak one way functions implies existence of strong one way functions
</div>

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#blah">Proof</button>
<div class=collapse id=blah>
</div>
<br>

# References 

[1]: https://www.amazon.co.uk/Foundations-Cryptography-v1-Basic-Tools/dp/0521035368 "Foundations of Cryptography V1"
1. [Foundations of Cryptography V1](https://www.amazon.co.uk/Foundations-Cryptography-v1-Basic-Tools/dp/0521035368)


</div>
