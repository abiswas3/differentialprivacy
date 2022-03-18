\newcommand{\ZP}[1]{\mathbb{Z}_p^{#1}}
\newcommand{\Z}{\mathbb{Z}_p}
---
title: Notes on SNIPs
...


<div class="container"> 
# Shared Non Interactive Proofs (SNIPs)

**NOTE:** In this document we use the terms voter, client and prover interchangeably. We also use the words verifier and servers interchangeably. All computation is done in $\Z$ where $p$ is large prime. Much larger than $M$, the number of candidates in an election.

## Recap of voting protocol

See slides I sent Graham.

## What is a proof system

According to Wikipedia a proof system is an abstract machine that models computation as the exchange of messages between two parties: a prover and a verifier. The parties interact by exchanging messages in order to ascertain whether a given string belongs to a language or not i.e. the prover has some string $x$ and the language can be described by all $x$ such that $f(x) = 1$

In a non interactive system, there is just one round of interaction between the prover and the verifier. Traditionally proof systems have a single prover and a single verifier.

## Zero Knowledge

A zero-knowledge proof is special proof system, by which one party (the prover) can prove to another party (the verifier) that a given statement is true while the prover avoids conveying any additional information apart from the fact that the statement is indeed true.

Formally a zero knowledge proof must satisfy three properties:

* Completeness: If $x$ is in the language (i.e. $f(x)=1$ or simply, the statement being proved is true), an honest verifier will be convinced of this fact by a honest prover.

* Soundness:  If the statement is false, no cheating prover (***even if they have super polynomial compute power***) can convince the honest verifier that it is true, except with some very small probability.

* Zero Knowledge:  If the statement is true, no verifier (honest or otherwise) learns anything other than the fact that the statement is true. This is formalized by showing that every verifier has some simulator that, given only the statement to be proved (and no access to the prover), can produce a transcript that "looks like" an interaction between the honest prover and the verifier in question. There is an even more formal definition using Turing machines and probabilistic polynomial time, but it is not needed for this write-up. <div class="intuition"> One can think of zero knowledge simply as follows: In doing the proof protocol, the verifier learns as much about the provers input $x$ as they would if the prover had sent the verifier nothing at all.</div> 

## What is different about SNIPs

Instead of 1 verifier that are $k$ verifiers. Furthermore, for our proofs to be useful, we need every verifier to be trusted and honest. Otherwise the users input is compromised. However, if the verifiers are honest, then we will get all the properties of a zero knowledge proof.

## Preliminaries

### Arithmetic circuit

In computational complexity theory, arithmetic circuits are the standard model for computing polynomials. Informally, an arithmetic circuit takes as inputs either variables or numbers, and is allowed to either add or multiply two expressions it has already computed. Additionally any arithmetic circuit for a polynomial of degree $n$ can be expressed by $n$ add operations on the input and $n$ multiplication operations. Let $p(x)$ be an polynomial of degree $n$ in $\Z$ and $x_1, \dots, x_n$ be the roots. We can always write $p(x)$ as $(x-x_1)(x-x_2)\dots(x-x_n)$ 

### Polynomials

<div class="lemma">
**Lemma a:** If we have M distinct points in $\Z$, we can always find a polynomial of degree $M-1$ that passes through all those points. Furthermore, this polynomial is unique i.e. there is only one polynomial that passes through all M points.
</div>
<br>
Another way of saying the above lemma is 

<div class="lemma">
**Lemma b:** If two polynomials $p$ and $q$ with degree $t$, agree of $t+1$ points i.e $p(x)=q(x)$ for $x_0, \dots, x_{t+1}$, then $p(x) = q(x) \forall x \in \Z$
</div>
<br>

A polynomial $p(x)$ of degree M can be described by a vector $M+1$ numbers $\in \Z$, $p=[p_0, \dots, p_{M}]$ such that: $p(x) = p_{M}x^{M-1} + \dots + p_1x + p_0$ 

For any polynomial $p = [p_0, \dots, p_{t}]$ of degree $t$, when we say we create $k$ shares of $p$, we generate $k$ polynomials $[p]_1, \dots, [p]_k$ such that $p(x) = \sum_{j=1}^k [p]_{j}(x)$ where $[p]_j \in \ZP{t+1}$


### Additive secret sharing

For any $x \in \ZP{M}$, the function $share(x, k)$, generates $k$ shares of $x$ such that $x = \sum_{j=1}^k [x]_{j}$, where $[x]_j$ is the $j$'th share of $x$.

<br>
<div class="lemma">
<h5>Linearity of Secret sharing:</h5>   
Let q be any linear map. If we have $x  = \sum_{i=1}^k[x]_i$, then $q(x) = q(\sum_{i=1}^k [x]_i)) = \sum_{i=1}^k q([x]_i)$ 
</div>

## Validation Circuit

Using SNIPs a prover would like to convince $k$ verifiers that their vote $x \in \ZP{M}$ is well formed. To determine if an input is well formed, there is some public circuit $Valid$, validates if a clients input is well formed. The public circuit which allows a voter to prove the validity of their input is as follows:

Let $x \in \ZP{M} = [x_1, \dots, x_M]$ be the voters input.

\begin{equation}
valid_0(x) = \Big(\sum_{i=1}^M x_i)\Big) == 1
\end{equation}


\begin{equation}
valid_i(x_i) = \Big((x_i - 1)x_i\Big) == 0
\end{equation}

\begin{equation}
valid_{M+1}(x) = \Big[\prod_{i=1}^{M} valid_i(x_i)\Big] == 1
\end{equation}


\begin{equation}
Valid(x) = \Bigg(valid_0(x) \times valid_{M+1} == 1\Bigg)
\end{equation}

The left hand product ensures that the a voters input sums to 1 and the right hand side ensures that inputs are either 1 or 0. For a users input $x$ to be valid they must convince the $k$ verifiers that they pass all $M+3$ valid circuits. <div class="intuition">As we have multiple arithmetic circuits, $valid_i$ returns 0 on success instead of 1. It will become clear why this is useful.</div>

## Voters proof construction

<h5>Intuition:</h5>    
If the verifiers had access to $x$, they could just run $Valid(x)$ and they would be good. But that violates the point of the secure protocol to begin with. Instead each verifier only has a share of the input. They must be able to verify if the shares combine to generate the right output. Observe that if the validation circuit was an arithmetic circuit made up of just addition gates, the only information the verifiers need is the input shares. See below:


<div class="lemma">
<h5>If a circuit has just add operations, then the proof construction is trivial. We first describe this so we can use this information to build to any arbitrary circuit.</h5>

The proof vector that the voter sends to each server is just additive shares of the input $x$. Let the $q$ be linear map on $x$ that describes all the additive operations. The output of the circuit is $q(x)$. Each server has access to a share $[x]_j$ and compute $q([x]_j)$ and broadcast this value to the other servers. After one round broadcasting, each server computes $\sum_{i=1}^k q([x]_j) = q(x)$ by linearity of additive secret sharing.
</div>
<br>
A general arithmetic circuit will have multiplication gates. Multiplication is not linear, so the prover will have to provide some additional help to the verifiers to be able to generate the final output. *The proof is just the help the prover gives the verifiers to compute the circuit.*

### Any general circuit

A single prover wants to convince $k$ verifiers that $valid_i(x) == c$ for some public constant $c \in \Z$. In order to do this, they send each verifier $j$ a proof $\pi_j$. Any arithmetic circuit $C$ describes a polynomial, and a polynomial of degree $n$ can be described by $n$ input addition operations followed by $n$ sequential multiplications, as described earlier. 

Let $G$ be the number of multiplication gates in our arithmetic circuit C. Let $q$ represent the linear operations on the input before feeding into the left wire of the first multiplication gate. Similarly let $p$ represent the linear operation for the right wire of the first multiplication gate. What this means is that if the prover sends each server $[x]_j$, each server is able to compute $p([x]_j)$ and $q([x]_j)$ which now feed into the multiplication gate.

Let the input wire values to the $t$'th multiplication gate, in topological order from inputs to outputs, be $u_t$ and $v_t$, $\forall 1 \leq t \leq G$. Similarly let the output be $w_t$.  Define $f$ and $g$ to be the lowest degree polynomials of degree at most $G-1$, such that $u_t = f(t)$ and $v_t=g(t)$. $u_1 = q(x)$ and $v_1 = p(x)$. 

**NOTE:** We have G points for $u_t$ and G points for $v_t$. Using the polynomial lemma stated above, the prover can compute polynomials $f$ and $g$ via lagrange interpolation -- where $f$ and $g$ are unique. Define $h(x) := f(x)g(x)$. As the prover knows $f$ and $g$ they can compute $h$ exactly. Furthermore $h(t)=w_t \forall 1 \leq t \leq G$

The prover now splits the polynomial coefficients of $h \in \ZP{2G - 2}$ into $k$ shares using additive secret shares $[h]_1, \dots, [h]_k$. Additionally, The prover picks 3 values $a, b, c \in Z$ such that $ab = c$. It splits each of these values using additive secret sharing, and sends to verifier $j$, $[a]_j, [b]_j$ and $[c]_j$


## Proof verification at the servers

Since we have $k$ honest verifiers, some of the verification steps are computed locally and then these computations are broadcasted and aggregated. If we did not need communication, we would be back in the 1 verifier setting, so SNIPs require that the verifiers communicate with each other. We need servers to be honest. If they are all dishonest, then server $j$ could broadcast $[x]_j$. They could all compute $x=\sum_{j=1}^k [x]_j$, revealing x, thus breaking the zero knowledge assumption.

Before the start of the verification of a single circuit, one server picks a random $r \in \ZP$ and shared it with everyone. The prover does not know $r$. **It is very important that the prover does not know $r$**.

### Local computations at Verifier

We consider the actions of verifier $j$ for $1 \leq j \leq k$. All other verifiers mimic the same process with their inputs.


<div class="lemma">
<h5>What does server $j$ have access to:</h5>    
They receive a polynomial $[h]_j$ and input share $[x]_j$. They have access to the all circuits $Valid$. They also have access to $r$ and $[a]_j, [b]_j$ and $[c]_j$.
</div>
<br>
Each server just computes $p([x]_j)$ and $q([x]_j)$ to input it into the first multiplication gate. Let $u_1$ and $v_1$ be the inputs to this gate in topological order and $w_1$ be the output. The verifier sets $w_1 = [h]_j(1)$ using the polynomial share they received from the prover. **They needed the prover to help them with this value as they cannot just compute it from the input shares**. This process is repeated for the next $G-1$ multiplication gates. Let $u_t$ and $v_t$ be the inputs to multiplication gate $t$, and $w_t$ be the output. Verifier $j$ sets $w_t = [h]_j(t)$ for all $1 \leq t \leq G$. The final output for server $j$ is $[h]_j(G)$.

At this point for each server, all input and output wire have a value assigned. Thus there are $G$ distinct values for $u_t$ and $v_t$, the server uses polynomial interpolation to compute two polynomials $[\hat{f}]_j$ and $[\hat{g}]_j$, such that $[\hat{f}]_j(t) = u_t$, $[\hat{g}]_j(t) = v_t$ for all $1 \leq t \leq G$.

At this point verifier $j$ has access to three polynomials :

* $[h]_j$: This was sent to them by prover.
* $[\hat{f}]_j$: They computed this using interpolation after filling the circuit with input values and polynomial evaluations.
* $[\hat{g}]_j$: They computed this using interpolation after filling the circuit with input values and polynomial evaluations.


Define $\hat{fg}(x) = \sum_{j=1}^k [\hat{fg}]_j(x)$. The $j$'th server is only in possession of polynomials $[\hat{f}]_j$ and $[\hat{g}]_j$. It does not possess the polynomial $\hat{fg}(x)$. Despite not having the polynomial, assume there is a magical way by which they can generate a share $[\hat{fg}]_j(r)$ of the value $\hat{fg}(r)$, from $[\hat{f}]_j(r)$ and $[\hat{g}]_j(r)$. <div class="intuition">This magic trick is called Beaver's method for secure multiplication, it is described in the appendix.</div> The server runs the magic protocol to get shares $[\hat{fg}]_j(r)$ of $\hat{fg}(r)$. 

<div class="lemma">
<h5>What does each server publish:</h5>    

Each server publishes :

* $[h]_j(G)$

* $\sigma_j = [\hat{fg}]_j(r) - [h]_j(r)$

</div>

### Global Computations

All servers have broadcasted $\sigma_j$ for $1 \leq j \leq k$. Each server now computes $\sigma = \sum_{j=1}^k \sigma_j$. If $\sigma = 0$ and the output  $(\sum_{j=1}^k [h]_j(G)) = c$, the server accepts provers input $x$ otherwise it rejects it.

## Security properties of SNIPS

Having described the protocols, we are ready to analyse if SNIPs does indeed provide properties of a zero knowledge proof protocol.

### Completeness

Completeness requires an honest prover. An honest prover will follow the client proof protocol by the letter. 

The output of a circuit is the output of the last multiplication gate, $h(G)$. We have $\sum_{j=1}^k [h]_j(G) = h(G)$. So by combining the outputs of their values, the verifiers were able to validate the input.

For the verifiers to accept $x$ they still need $\sigma=0$. Now we show that if the prover is honest i.e.they have not mucked about and sent the verifiers some garbage $h$, then we will always have $\sigma=0$ 

To see why, observer that the input to the $t$'th multiplication gate can be:

* A linear operation of the input wire and these inputs were created using additive secret sharing. Let the left input be $u_t$ and right input be $v_t$. We have $\hat{f}(t) = \sum_{j=1}^k [\hat{f}]_j(t) = \sum_{j=1}^k [u_t]_j = u_t = f(t)$. Likewise we have $\hat{g}(t) = g(t)$. Since $h(t) = g(t)f(t)$, we have $h(t) = \hat{f}(t)\hat{g}(t)$. Note: This analysis still holds if the input is the output of a linear map on the input shares by linearity of secret sharing.

* An input that is not a linear map of the input wires is the output a previous multiplication gate $t_0 < t$. So we get, $\hat{f}(t) = \sum_{j=1}^k [\hat{f}]_j(t) = \sum_{j=1}^k [h]_j(t_0) = h(t_0) = f(t)$. Likewise $g(t) = \hat{g}(t)$. 

There were a total of $G$ multiplication gates in the circuit. $f, \hat{f}$ agree on $G$ points and are of degree at most $G - 1$. By polynomial lemma, $\hat{f} = f$. Likewise $\hat{g} = g$. Using this property, we get $h(r) =  f(r)g(r) =  \hat{f}(r)\hat{g}(r) =  \sum_{j=1}^k [\hat{fg}]_j(r)$  

### Soundness

We have a malicious prover. The goal of a malicious prover is try and trick the verifiers i.e. the verifiers output $Valid(x)=1$, when in reality $Valid(x) \neq 1$. To make this happen, a prover must do at least one of the following:

* Send a $\hat{h} \neq h$ to the the servers.
* Pick a bad beaver triple, $a, b, c \in Z$ such that $ab = c + \alpha$


The verifiers can gossip between each other and calculate $a$, $b$ and $c$. Doing so reveals nothing about $x$ so it does not harm the zero knowledge protocol. This way the verifiers find out that $ab = c + \alpha$ for $\alpha \in \Z$. Now they just output, $\sigma_j = [(\hat{fg}(r) + \alpha) - \hat{r}]$ instead or just change $c$ to $c + \alpha$ and the same as before. Both are equivalent. So, this attack by the prover is harmless.

Now we look at what happens when $\hat{h} \neq h$. 

<div class="lemma">
<h5>Claim: If a client wishes to pass a test for an illegal $x$, they must pick $\hat{h}$ such that there exists **at least one** $t \in \{1, \dots, G \}$ such that $h(t) \neq \hat{t}$</h5>    

**Proof:**
Assume they align for all $G$ values. Remember that, $h$ represents the true outputs of multiplication gates in the circuit for a given $x$. If $Valid(x) \neq 1$, then $h(G) \neq 1$, then the client will not pass the test anyway. Their malicious behaviour would be pointless. Thus its safe to assume the above claim for all $\hat{h}$
</div>
<br>

Let $t_0$ be the smallest such $t \in \{1, \dots, G \}$ such that $h(t_0) \neq \hat{t_0}$. 

Since $t_0$ was the smallest, for all gates before this, we have $\hat{fg}(t) = fg(t)$ for $1 \leq t \leq t_0$, by the same argument we used to prove completeness. Therefore for a bad proof vector $\hat{h}$, we will have $\hat{fg}(t_0) = fg(t_0) = h(t_0) \neq \hat{h}(t_0)$. What this is saying, is that if a client sent in a bad proof, the server reconstructed polynomial $\hat{fg} \neq \hat{h}$. The prover would fail the polynomial identity test for $\hat{fg} - \hat{h} == 0$ with very high probability.

<div class="lemma">
<h5>When can a a malicious client still pass the identity test.</h5>    

Our test is to check if $\hat{fg}(r) - \hat{r} = 0$. If $r$ was a root for polynomials $\hat{fg}(r) - \hat{r}$ we would get 0 even though the polynomials may not be equal. There are $p$ elements in our finite field. The $\hat{fg}(r) - \hat{r}$ is a polynomial with at most $2M - 2$ roots. The worst case probability of the servers picking a $r$ such that $r$ is a root for both polynomials is $1 - \frac{2M - 2}{p}$. For secret voting $M < 100$ and we have $p$ to be a $128$ or $256$ bit number. Note if we did the test $s$ times with a different $r_1, \dots, r_s$, the probability of a false positive would be $1 - \Big(\frac{2M - 2}{p}\Big)^s$
</div>

### Many valid circuits

To ensure a vote is valid, the input must pass $M+3$ circuit evaluations. For efficiency we require that on success, each valid gate outputs 0 instead of 1. Then the final check requires all the circuits to be 0, thus to accept we need $\Big(\sum_{i=1}^{M+3} \sigma(r_i)W_i\Big) == 0$, where $W_i$ is the output of $valid_i$ and $r_i$ is the random value picked for the polynomial identity test for circuit $i$.

### Zero Knowledge

TODO

## Beavers Multiplication

Each server $j$ has computes $[d]_j = [\hat{f}]_j(r) - [a]_j$ and $[e]_j = [\hat{g}]_j(r) - [b]_j$ and broadcasts $[d]_j$ and $[e]_j$ to other servers, thereby keeping $[\hat{f}]_j(r)$ and $[\hat{g}]_j(r)$ secret.

Each server j computes $[\hat{fg}]_j(r) = de/s + d[b]_j + e[a]_j + [c]_j$ where $d = \sum_{j=1}^s [d]_j$ and $e = \sum_{j=1}^s [e]_j$. To see that $[\hat{fg}]_j(r)$ is a share of $\hat{fg}(r)$, note that 

\begin{align*}
\sum_{j=1}^s [\hat{fg}]_j(r) &= \sum_{j=1}^s de/s + d_[b]j + e[a]_j + [c]_j \\
&= de + db + ea + c \\
&= (\hat{f}(r) - a)(\hat{g}(r) - a) + (\hat{f}(r) - a)b + (\hat{g}(r) - b)a + ab \\
&= \hat{f}(r)\hat{g}(r) \\
&= \hat{fg}(r)
\end{align*}


## Worked out Example in Python3 

This is not production quality code. Just a worked out example with all the circuits to show that the experiment backs up the claims stated above.

 <embed type="text/html" src="./SNIPS_Voting.html" width="100%" height="600"> 


# References 

[1]: https://dl.acm.org/doi/pdf/10.1145/3133956.3133982 ""
1. [Practical Methods for Secure Aggregation](https://dl.acm.org/doi/pdf/10.1145/3133956.3133982)

[2]: https://crypto.stanford.edu/~dabo/pubs/abstracts/prio.html "Prio: Private, Robust, and Scalable Computation of Aggregate Statistics"
2. [Prio: Private, Robust, and Scalable Computation of Aggregate Statistics](https://crypto.stanford.edu/~dabo/pubs/abstracts/prio.html)


</div>
