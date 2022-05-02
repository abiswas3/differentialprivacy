\newcommand{\P}[2]{\mathbb{P}_{#2}\Big[ #1 \Big]}
\newcommand{\ensemble}[1]{\{ X_n\}_{n \in \mathbb{N}}}
\newcommand{\keyGen}{k \leftarrow G(1^n)}
\newcommand{\binString}[1]{\{ 0, 1\}^{#1} \rightarrow \{ 0, 1\}^{#1}}
\newcommand{\M}{\mathcal{M}}
\newcommand{\C}{\mathcal{C}}
\newcommand{\K}{\mathcal{K}}
\newcommand{\E}{\mathcal{E}}
<div class="container"> 
---
title: Semantic Security
...

```Primo lecture series in mathematics: Lecture II- Semantic Security```

# What does it mean for a crypto system to be semantically secure


## Setup and Notation

Tom and Steve want to send each other private messages $m \in \M$ over some digital channel. 

**Picture**

They want to keep secret what they are talking about. We assume they possess a shared secret key $k \in \K$m which they generated using some key generation algorithm $G$ that uniformly samples the key from the key space. They encrypt their message using a probabilistic cryptosystem $\E = (G, E, D)$ (for limits of deterministic ones [see](../PerfectSecurity/)) and send the encryption along the insecure channel.

$E: \K \times \M \rightarrow \C$ such that $c \xleftarrow{R} E(k, m)$, $R$ denotes uniform random coins that the encryption algorithm uses

$D: \K \times \C \rightarrow \M$ such that $m^{\prime} = D(k, c)$, where  $\P{m^{\prime} = m}{} = 1$

Now instead of sending $m$ in the clear to each other, they send $c=Enc(k,m)$. What properties must $\E$ guarantee for Steve and Tom to feel safe that Ben cannot decipher anything they are talking about. One way to describe Ben learns nothing about $m$ is by the definition of the semantic security. If the cryptosystem was semantically secure, then it implies that Ben learns as much about $m$ by looking at $c$ as he would have done if he had not. This statement is mathematically formalized by the following definition from [[2]]. 

## Semantic Security Definition

<div class="theorem">
A private-key encryption scheme $(G,E,D)$ is semantically secure (in the private-key model) if **for every** non-uniform probabilistic-polynomial time algorithm $A$ there **exists** a non-uniform probabilistic-polynomial time algorithm $A^{\prime}$ such that for every probability ensemble $\ensemble{X}$ with $|X_n| \leq poly(n)$, every pair of polynomially-bounded functions $f,h : \binString{*}$

\begin{align*}
\Bigg| \P{A(1^{|X_n|}, E(k, m), 1^n, h(1^n, m)) = f(1^n, m)}{\keyGen} - \P{A(1^{|X_n|}, 1^n, h(1^n, m)) = f(1^n, m)}{} \Bigg| \leq \frac{1}{p(n)}
\end{align*}

for all polynomials $p$

</div>

In simple words

* In the above definition $n$ is the security parameter. The bigger $n$ is the more unlikely it is that Ben will win. However, $E$ and $D$ will take longer, so there is a trade-off.

* Ben the is non-uniform probabilistic-polynomial time algorithm $A$. The non uniform in the definition just gives Ben more power. It says it can change it's strategy for a given specific security parameter size. It does not have to plan one strategy in advance for all $n$.

* Charlie is non-uniform probabilistic-polynomial time algorithm $A^{\prime}$. The definition says for every conniving deceitful Ben there will always be a clueless Charlie, who does not see anything but just tries to guess things.

* $X_n$ is the message space $\M$ for a given security parameter $n$. The message space is bounded in some polynomial of $n$ so it is reasonable that Ben could try every $m \in X_n$.

We give Ben the length of the message $1^{|X_n|}$, the length of the security parameter $1^{n}$, the encryption of the message $E(k, m)$ and all the auxiliary information about $m$ can be computed by $h(1^n, m)$. Note if $h$ revealed something about $m$ then it's not the crypto-systems fault. $h$ is public knowledge. We can't hide something that is already out there for everyone to see. Ben uses all this information to guess an arbitrary poly function $f$ about the message $f(1^n, m)$. 

We give Charlie everything but the encryption. So essentially Charlie is sitting in his own garden talking to no one, seeing no one. He also tries to guess what Ben guessed. **If my system is semantically secure, they both have the practically shot at getting it right.** The only difference between Ben and Charlie is that one has access to attacking the crypto-system. Charlie sits in what we call an ideal world, and simulates the behavior of Ben. 


<div class="intuition">
That definition above seems like it will be a handful to prove. The advantage of such a definition, is that it very clearly defines what it means to be secure. The rest of the document is concerned with the following question: What if we could prove simpler things and hope that will imply this. Then we'd get the best of both worlds. Easy proofs and strong guarantees.
</div>	

## Game based security

What if instead of providing semantic security as defined above, my cryptosystem just prevented the Adversary from being able to distinguish between encryptions? Would my system provide more security or less security? 


## How are they connected 

For the remainder of the document, we show how the above two definitions are equivalent. Furthermore, if a system is semantically secure, 


## Consequences of Semantic Security

# References 

[1] : Shafi
[2] : Yehuda

</div>
