\newcommand{\ZP}[1]{\mathbb{Z}_p^{#1}}
\newcommand{\Z}{\mathbb{Z}_p}
\newcommand{\NP}{\mathcal{NP}}
\newcommand{\IP}{\mathcal{IP}}
\newcommand{\P}{\mathcal{P}}
\newcommand{\T}{\mathcal{T}}
\newcommand{\F}{\mathcal{F}}
\newcommand{\BPP}{\mathcal{BPP}}
\newcommand{\Pr}[1]{\mathbb{P}\Big[ #1\Big]}
\newcommand{\AngleBracket}[1]{\langle #1 \rangle}
\newcommand{\genF}{f : \{0, 1\}^* \rightarrow \{0, 1\}^*}
\newcommand{\PZK}{\mathcal{PZK}}
---
title: Security Defintions
...

<div class="container"> 

**EDIT: Want to change this document to examples of proving protocols are secure**

# Semi honest adversaries 

Given input and and output, can generate the adversaries view of the protocol execution. **IMPORTANT: ** Since all parties follow the protocol, the inputs are well defined. Go back to the ideal world, where $f_{Ideal}$ receives inputs and outputs the answer. The adversary can see only the input/output of the corrupted parties and the final output and *nothing else*. He has to attack this world. This adversary is the simulator. We have to show that the simulators view is indistinguishable from that of the real world adversary.

<img src="pngs/semi_honest.png" width="90%"></img>

The joint distribution of left and the joint distribution of the right has to look the same.
**WHY JOINT : Because of randomness - Lindell has a slide**

However, if f is deterministic then we can compare just the bad guys output and the simulators output; can ignore all other party outputs. -- we can look at them independently.

In semi-honest : correctness, independence of inputs and fairness are non issues because everyone has to follow the protocols.


## Examples of Semi Honest Security Simulators

### 1 out 2 oblivious transfer

### GMW protocol



# Malicious Adversaries

Now this simulator doesn't have access to the A's inputs. It needs to be able to invent/extract/simulate them.

Furthermore now,  correctness, independence of inputs and fairness are issues.


**OLD** 

# Security Models for Multi Party Computation (MPC)

## Secret Sharing

Informally, $(t,n)$ secret sharing is method by which we split a
secret $s$ into $n$ shares such that only $t$ shares are needed to
re-construct the secret. Additionally, any combination of $t-1$ shares
reveals no information about $s$. More formally, it is a pair of
algorithms $(Shr, Rec)$ that satisfies the following two properties:


<div class="theorem">
* Correctness: Let $Shr(s) = (s_1, \dots, s_n)$, for $s \in D$ where
  $D$ is the domain of secrets, then $\forall k \geq t$, we have
  $\Pr{Rec(s_{i1}, \dots, s_{ik} = s} = 1$

* Perfect Privacy: Let $a, b \in D$ and $Shr(a)|_{k}$ be the
  projection of the shares $(a_1, \dots, a_n)$ onto a subspace $D^k$
  for $k < t$. Let $v=(v_1, \dots, v_k) \in D^k$, then we have 
  \begin{align*}
  \Pr{Shr(a)|_{k} = v} &= \Pr{Shr(b)|_{k} = v} 
  \end{align*}
</div>


In other words,$Shr(a)|_{k}$ and $Shr(b)|_{k}$ are perfectly
indistinguishable. Colloquially we can say that by looking at any
$v$ as defined above, it is impossible to gain any information about
the secret : as all values in the domain $D$ are equally likely to
be the secret. The best anyone can do is guess uniformly at random.

### Examples 

Additive secret sharing and Shamirs secret sharing. 

## What is MPC ?

Intuitive explanation

## What does it mean for a MPC to be secure?

One way to do it would be to enumerate all the properties that we
would classify as a violation of security.  ```For example, the
adversary should not be able to learn a certain predicate of another
party’s input, the adversary should not be able to induce impossible
outputs for the honest parties, and the adversary should not be able
to make its inputs depend on honest parties’ inputs. Not only is this
a tedious approach, but it is cumbersome and error-prone. It is not
obvious when the laundry list could be considered complete.```--
[[1][1]]

Alternatively, we could define a perfect/ideal world which has all the
nice properties we desire and compare a protocol against this world.

### Ideal World 

In an ideal world, the parties want to compute a function $\F$ by
sending their private inputs to some trusted incorruptible party
$\T$. Party $P_i$ has input $x_i$, which is sent to $\T$ who outputs
$\F(x_1, \dots, x_n)$. Consider an adversary attacking the ideal
world. We call such an adversary the simulator. This simulator is able
to take over any parties $P_i$ but not $\T$. Therefore, all the simulator is
able to view, is their input $x_i$ and the final output $\F(x_1,\dots,
x_n)$. Thus it must choose their evil inputs, independent of the input
of the honest parties.

### Real World

In the real world there are no trusted third parties. Instead all
parties communicate with each other using a protocol $\pi$. The
protocol $\pi$ specifies for each party $P_i$, the next message
function $\pi_i$ -- which takes as input the input $x_i$, the bits of
Party $i$'s random tape $r_i$ and all the messages it has received so
far. Then $\pi_i$ outputs either a next message to send along with its
destination, or else instructs the party to terminate with some
specific output. In the real world, an adversary can corrupt
parties—corruption at the beginning of the protocol is equivalent to
the original party being an adversary. How they can corrupt parties
depends on the trust models described below. 

<div class="important"> **Intuition** A protocol $\pi$ is secure if
any effect that an adversary can achieve in the real world can also be
achieved by a corresponding adversary in the ideal world </div>

```Note: This simulator paradigm is almost identical to the Zero
Knowledge proofs for interactive proofs```

## Trust Models

### Passive Security / Honest but curious adversaries / Semi Honest adversary

All 3 names refer to the same model.

A semi-honest adversary is one who corrupts parties but follows the
protocol as specified. The corrupt parties run the protocol honestly
but they may try to learn as much as possible from the messages they
receive from other parties. An adversary may collude with multiple
parties, and in that case, the view of the adversary is the combined
view of each of the corrupted parties.

The view of a party in the semi honest model is the following:

* The honest input $x_i$
* Their random tape $r_i$
* All messages received $z_1, \dots, z_m$

The view of an adversary is the combined view of all the parties they
have corrupted.  An attack is anything any efficient (PPT) algorithm
can compute using this view. Thus an attack is equivalent to just
releasing the view to the public world.

<div class="important"> **Intuition** The protocol is secure if the
view generated by the simulator is computationally indistinguishable
from the actual adversaries view. Note: The simulator only access has
access to the honest inputs of the corrupt parties and the final
output of the protocol. Showing that such a simulator exists proves
that there is nothing an adversary can accomplish in the real world
that could not also be done in the ideal world. **So whenever we want
to show something is secure, the game will always be to write down a
simulator that has the above properties**</div>


Formal defintion: 

<div class="theorem"> More formally, let $\pi$ be a protocol and $\F$
be a functionality. Let $C$ be the set of parties that are corrupted,
and let $Sim$ denote a simulator algorithm. We define the following
distributions of random variables: 

1. Let $Real_{\pi}(\kappa, C, x_1, \dots, x_n)$ output the ensemble of
   random variables :
	* $\{V_i: i \in C\}$: The view of the corrupt parties
	* $y_1, \dots, y_n$ : The ouput of the each party

	by running protocol $\pi$ with security parameter $\kappa$, where
	each party $P_i$ acts honestly using following $\pi_i$. Let $V_i$ be
	the view of party $P_i$ and $y_i$ be the output of the same party.

2. Let $Ideal_{\F, Sim}(\kappa, C, x_1, \dots, x_n)$ output of
   ensemble of random variables:
   * $y_1, \dots, y_n$ : The ouput of the each party
   * $Sim(C, \{ (x_i, y_i): i \in C\})$: The view of the corrupt adversary in the ideal model

We say, A protocol $\pi$ securely realizes $\F$ in the presence of
semi-honest adversaries if there exists a simulator $Sim$ such that,
for every subset of corrupt parties $C$, $Ideal_{\F, Sim}(\kappa, C,
x_1, \dots, x_n)$ and $Real_{\pi}(\kappa, C, x_1, \dots, x_n)$ are
computationally indistinguishable in terms of $\kappa$.
</div>

**NOTE:** The defintion includes all the outputs, even those of the
honest parties. This is done to enforce correctness, in the case
$$C=\emptyset$. Then we require that the output in the ideal model be
indistinguishable from the real model. If $\F$ is deterministic, this
implies correctness. Also note that in the case of passive security,
we could just focus on the Views. As no party can deviate from the
protocol, we are always guaranteed correctness if $\pi$ is propertly
designed.

### Malicious Security

A malicious (also known as active) adversary may instead cause
corrupted parties to deviate arbitrarily from the prescribed protocol
in an attempt to violate security. A malicious adversary has all the
powers of a semi-honest one in analyzing the protocol execution, but
may also take any actions it wants during protocol execution. Now
there are two things to consider:

* Effect on honest outputs: Because this active adversary can send in
  bad inputs the output of the honest parties might be affected. So
  when we analyse active security, we must make claims about honest
  outputs. Systems like Poplar and Prio ignore robustness of output in
  presence of active adversaries.
  
* Extraction: Earlier we could not change input to $\T$ even for
  corrupted parties. In contrast, the input of a malicious party is
  not well-defined in the real world, which leads to the question of
  what input should be given to $\T$ in the ideal world. The answer is
  we let the ideal world adversary i.e. the simulator also pick the
  inputs as it wants. **This aspect of simulation is called
  extraction, since the simulator extracts an effective ideal-world
  input from the real-world adversary that “explains” the input’s
  real-world effect.**


<div class="theorem">

When $A$ denotes the adversary program, we write $corrupt(A)$ to
denote the set of parties that are corrupted, and use $corrupt(Sim)$
for the set of parties that are corrupted by the ideal adversary,
$Sim$.

1. Let $Real_{\pi, A}(\kappa,  x_i \notin corrupt(A))$ output the ensemble:
   * $\{y_i: i \notin corrupt(A)\}$
   *$\{V_i: i \in corrupt(A)\}$
   
   by running $\pi$ on the honest inputs and messages of clients and
   malicious inputs and messages selected by $A$. $V_i$ is the view of party $P_i$.   

2. Let $Ideal_{\F, Sim}(\kappa, x_i \notin corrupt(A))$ first generate
$x_i \in corrupt(A)$, then run $(y_1, \dots, y_n) = \F(x_1, \dots,
x_n).$ Then give $\{y_i: i \in corrupt(A)\}$ to Sim to get the final
view set of simulated views. We then output the ensemble
	* $V^*$: This is the view of the corrupt parties plus the corrupt outputs.
   * $\{y_i: i \notin corrupt(Sim)\}$	

We say, A protocol $\pi$ securely realizes $\F$ in the presence of
active adversaries if there exists a simulator $Sim$ such that,
$corrupt(Sim) = corrupt(A)$, and for all honest party inputs,
$Ideal_{\F, Sim}(\kappa, x_i \notin corrupt(A))$ and $Real_{\pi,
A}(\kappa, x_i \notin corrupt(A))$ are computationally
indistinguishable in terms of $\kappa$.

</div>

### Security with Abort

In any real world protocol, one party receives its output before the
other. If the first party is evil they can abort and not give the
honest client any output at all. Thus our defintions won't hold as we
require the outputs of honest parties be indistinguishable in the
ideal world and real world. The ideal world has no such issue of
deadlocks. To work around this, there is a weaker notion of security
which modifies the ideal $\F$ as follows: In this model, the outputs
are first given to evil parties who can then either deliver or
abort. If they deliver things work as before, if they abort, the
honest clients are sent a special symbol $\bot$.

## Examples of Simulators 

### Poplar with at least 1 honest server

<img src="pngs/bad_server_sketch.png" width="95%"></img>

### Prio with at least 1 honest server

TODO

# References 

[1]: http://securecomputation.org/docs/pragmaticmpc.pdf "A Pragmatic Introduction to Secure Multi-Party Computation"
1. [A Pragmatic Introduction to Secure Multi-Party Computation](http://securecomputation.org/docs/pragmaticmpc.pdf)

[2]: https://eprint.iacr.org/2004/175.pdf "A Proof of Security of Yao’s Protocol for Two-Party Computation"
2. [A Proof of Security of Yao’s Protocol for Two-Party Computation](https://eprint.iacr.org/2004/175.pdf)

</div>
