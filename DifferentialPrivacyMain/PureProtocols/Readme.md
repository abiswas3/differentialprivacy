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
\newcommand{\gaptr}{GAP-TR_{\kappa, \tau}}
\newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}

<div class="container">

## Local Privacy

### Binary sums with Randomised Response

We describe the randomised response protocol next.

<div class="algorithm">
**Local Randomiser**

Input: 

* $x_i \in \{ 0, 1 \}$
* $\gamma \in (0,1/2)$

Method: 

* Flip a coin with probability of heads = $0.5 + \gamma$.
* If heads return $z_i = x_i$ else return $z_i=1 - x_i$

**Analyser**

* Compute $k = (\sum_{i}^N z_i)$

* Output $\hat{f} = \frac{ k- (0.5 - \gamma)N}{2\gamma}$

</div>

### Privacy

Privacy for the above algorithm is trivially achieved **(will insert it later)**

#### Upper Bound

We now try to upper bound the accuracy of the algorithm discussed above.

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#randomResponseError">Proof</button>
<div class=collapse id=randomResponseError>
	
The expected value of $z_i = 0.5 + \gamma$ when $x_i=1$ and $0.5-\gamma$ when $x_i=0$. Thus

\begin{align*}
\mathbb{E}[\hat{f}] &= \mathbb{E}[\frac{ k- (0.5 - \gamma)N}{2\gamma}] \\
&= \frac{1}{2\gamma}\Big(\mathbb{E}[k] -  0.5N - N\gamma \Big) \\
&= \frac{1}{2\gamma}\Big(\mathbb{E}\Big[(0.5 + \gamma)k + (0.5 - \gamma)(N -k) \Big] -  0.5N - N\gamma \Big) \\
&= k
\end{align*} 



Thus $\hat{f}$ is an unbiased estimator of the sum of inputs, and since $\hat{f}$ is a sum of bernoulli random variables, it means we can directly apply the [hoefdinng bound for Bernoulli's in Example 1](http://www.stat.cmu.edu/~arinaldo/Teaching/36709/S19/Scribed_Lectures/Jan29_Tudor.pdf) which states

$$ \mathbb{P}\Big[ |\hat{f} - \mathbb{E}(\hat{f})| \geq t \Big] \leq 2e^{-2nt^2}$$

To pull out an error bound set $\delta = 2e^{-2nt^2}$ and solve for t. Thus we get with probability $1 - \delta$, $|\hat{f} - \mathbb{E}(\hat{f})| \leq t$ and $t=\sqrt{\frac{1}{2n}\log\frac{1}{\delta}}$. Thus we can finally say that with probability $1 - \delta$

$$|\hat{f} - \mathbb{E}(\hat{f})| \leq O(\frac{1}{\sqrt{N}})$$

</div>

An alternate way to derive this bound is to look at the variance of the estimator $\hat{f}$ and since the estimator is unbiased, the variance of the estimator is equal to the mean squared error of the estimator. It gives a point estimate of an error not a confidence interval. The derivation can be found [here](http://www.gautamkamath.com/CS860notes/lec3.pdf). It is relatively straightforward.

#### Lower Bound for means and sum

[[3][3]] Gives us a proof that shows that the simple algorithm above that was invented in 1965 is actually the best you can do. It states that the upper bound is tight -- that indeed $O(\frac{1}{\sqrt{N}})$ is the least error we must tolerate to ensure privacy. <div class="question"> The proof for this lower bound is quite convoluted. The authors prove the lower bound for any distributed t-coalition network, for interactive and non interactive protocols for sums. I try and simplify their proof for non interactive local privacy only. In doing so, I do my best attempt at simplifying their proof, building intuition and re-deriving it.</div> What a lower bound statement is saying is that -- if we wanted to $\epsilon$ local privacy and compute the mean of binary numbers, **all** private algorithms will error at least by $O(\frac{1}{\sqrt{N}})$ with non zero probability and non vanishing probability (the probability does not shrink as number of users go up.)


<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#mainProof">Main Proof</button>
<div class=collapse id=mainProof>
The proof is divided into 2 parts: 

1. They first define a gap version of the threshold function, denoted GAP-TR, and observe that any differentially private protocol for SUM with error $\tau$ implies a differentially-private protocol for GAP-TR with gap $\frac{\tau}{2}$.

2. The contrapositive of the above fact, is used to show that it is impossible to compute GAP-TR with a gap smaller than $O(\sqrt{n})$ in a differentially private manner. Therefore, it is impossible to compute SUM in a differentially private manner without suffering an error of at least $O(\sqrt{n})$. Most of the work in the paper is done to prove the second bit.
  
</div>


<button type="button" class="btn btn-info" data-toggle="collapse"
data-target="#step2">Step 2 of main proof
</button>
<div class=collapse id=step2>

The whole proof is concerned with approximating **$\gaptr$**. Nothing in this section has to do with sums or means. We have already built the connection with sums and means in step 1.

**DEFINITION**
 Gap threshold functions are defined as the following: If $SUM(X_1, \dots, X_n) \leq \kappa$, then $GAP-TR_{\kappa, \tau} = 0$ and If $SUM(X_1, \dots, X_n) \geq \kappa + \tau$, then $GAP-TR_{\kappa, \tau} = 1$ . The function is undefined when $\kappa < SUM(X_1, \dots, X_n) < \kappa + \tau$.

To show that it is impossible to compute differentially private $\gaptr$ without making at least $O(\sqrt{n})$ error, the authors show that any private protocol for computing $\gaptr$ is unable to distinguish between an input of at least $\sqrt{n}$ 1's and an input of all 0's. This is saying if the protocols spit similar answers for both inputs thereby erring by nearly $O(\sqrt{n})$. By argument 1, they then go onto claim that a private protocol for $SUM$ on the same input would make twice the error with high probability. Thus the entire game is to show that upto $\sqrt{n}$ number of 1's the protocol has no idea how to distinguish between inputs -- so it spits out garbage.


They define a distribution $A$ on inputs from $\{0, 1\}^n$ such that $X \sim A$ where $X$ is a $n$ dimensional binary vector $(x_1, \dots, x_n)$ such that $\mathbb{P}[X_i = 1] = \alpha$, where $\alpha = \frac{1}{\epsilon\sqrt{n}}$. **All the magic is encoded in the way we pick this $\alpha$**.

By the chernoff bound $\mathbb{P}[\sum_{i=1}^n X_i \leq (1 - \gamma)n\alpha] \leq e^{-\frac{\alpha n\gamma^2}{2}}$ as $n\alpha$ is the expected value of the sum of $Bernoulli(\alpha)$. Plugging in the value of $\gamma=1/2$ and $\alpha$, we get 

$$\mathbb{P}_{X \sim A}[\sum_{i=1}^n X_i \leq \frac{\sqrt{n}}{2\epsilon}] \leq e^{-\frac{\sqrt{n}}{8\epsilon}}$$

The above statement is saying that the likelihood of seeing less than $O(\sqrt{n})$ 1's in a vector sampled from $A$ is extremely low, thereby the sum of this vector will be greater than $O(\sqrt{n})$ with large probability. **[See notes on concentration inequality to see why they had to pick $O(\sqrt{n})$. For anything that decays quicker, concentration inequalities will go out of the window.]**


Define $\tau = 0.5n\alpha$. Fix any $\epsilon$-differentially private, local protocol $\prod$ for computing $\gaptr$ with $\kappa=0$. Remember, that in the local model the curator/analyser is assumed to be deterministic. The curator, sees sanitised inputs $c = (S(X_1), \dots, S(X_n))$ which is the overall view of the execution of the protocol. It then applies a deterministic algorithm $G$ to $c$, where $G(c) \in \{ 0, 1\}$ is the output of the protocol.


Let $D$ denote the set of input vectors for which the curator answers 1, i.e., $D := \{c=\Big(S(X_1), \dots, S(X_n)\Big) : G(c) = 1\}$. There are $2^n$ possible input values to the protocol, let $\mathbb{P}[D]$ be the fraction of times $\prod$ answers 1. Fix $p \in [0,1]$. We look at all possible algorithms by considering the probability of answering 1. The reason the authors can do this is because the curator is deterministic. It can only see a fixed number of views, after that it just says 1 or 0. So all algorithms can be divided into 2 groups: Ones that predict 1 less than $p$ fraction of the time and ones that do not. For each of these cases we show, that all protocols fail to distinguish between $A$ and $0$.

**Case I:** $\mathbb{P}[D] < p$. Let E denote the event of the $\prod$ making the following mistake : $\sum_{i=1}^nX_i \geq O(\sqrt{n})$ and the protocol returns 0. The complement $E^c$ of this event is $\sum_{i=1}^nX_i \leq O(\sqrt{n})$ or the protocol returns 1. Formally

\begin{align*}
\mathbb{P}_{X \sim A}[E^c] &\leq \mathbb{P}[D] + \mathbb{P}[\sum_{i=1}^nX_i \leq O(\sqrt{n})] \\
&\leq p + 0
\end{align*}

 By the chernoff bound we have already shown that $\mathbb{P}[\sum_{i=1}^nX_i \leq O(\sqrt{n})]$ is so unlikely, it can be ignored as it is almost 0. The $\mathbb{P}_{X \sim A}[E] \geq 1 - p$


**What we have shown is that, all algorithm returns 0 most of the times [(1 - p) fraction of the time], if we sent the algorithm inputs from $A$ it would make mistakes with constant probability.** NOTE: The reason we really needed $O(\sqrt{n})$ was to kill the Chernoff bound to 0. A sharper error rate would not have killed it off, and therefore we would not get the constant probability bound we get.

What about algorithms that mostly say 1. We now show those algorithms will also make an error with constant probability because they output zero vector inputs as 1 with constant probability. To be able to show this, we need to use some lemmas which have to do with the privacy requirements. **NOTE:so far we have only used Chernoff-Hoeffding bounds -- nothing about the privacy of algorithms have been utilised.** The proof for the lemmas is provided below the main proof.

### Definitions

Define the curators view as $View_{C}(X) = \Big( S(X_1), \dots, S(X_n)\Big) = c$ where $S$ is the local sanitiser for each user which guarantees privacy.

Define $r(c)$ as 

$$r(c) := \frac{\P{View_C(X) = c}{X}{A}}{\mathbb{P}[View_C(0) = c]}$$

In the local model, each user is independent of one another, so 

\begin{align*}
r(c) &= \prod_{i=1}^n \frac{\P{S(X_i) = c_i}{X}{A}}{\mathbb{P}[S(0) = c_i]} \\
&= \prod_{i=1}^n r_i(c_i) \\
\log r(c)&= \sum_{i=1}^n V_i
\end{align*}

### Lemma 1

**Lemma 1 follows from the defintion of DP and Taylors theorem**

For every $0 < \epsilon \leq 1$, and $\forall i$, we have with probaility 1,

$$ 1 - 2\alpha\epsilon \leq r(c_i) \leq 1 + 4\alpha\epsilon $$

$$ 4\alpha\epsilon \leq V_i \leq 4\alpha\epsilon $$

where $r(c_i)$ and $V_i$ are as defined previously

### Lemma 2

**Lemma 2 follows from Lemma 1**

For every $0 < \epsilon \leq 1$, and $\forall i$

$$\mathbb{E}[V_i] \leq 32\alpha^2\epsilon^2$$

### Lemma 3

**Lemma 3 follows from Lemma 1, Lemma 2 and Hoeffding inequality. And Lemma 1 follows from the privacy.** We show this below the main proof.

Let $p_{A}(c) = \mathbb{P}_{X \sim A}[(S(X_1) \dots, S(X_n) = c)]$ and
Let $p_{0}(c) = \mathbb{P}[(S(0) \dots, S(0) = c)]$

For $v > 32$, With probability $1 - e^{-\frac{(v - 32)^2}{32}}$, the curator/analayser's output satisfies

$$\frac{p_{A}(c)}{p_{0}(c)} \leq e^{v}$$ 


**NOTE:** in the original paper, this bound and $\alpha$ above have variable $d$ inside it. It only really matters for interactive protocols where there are multiple rounds of communication. Since I am interested only in a single round local protocol, this $d$ does not matter and I set it to 1. Playing with this value fo $d$, one can reduce or increase the constant probability of error in case II.

We now have all the tools to prove that all protocols belonging to case II, still err with constant probability that does not shrink as $n$ grows.

Case II: $\mathbb{P}[D] \geq p$

We are looking the probaility of outputting 1, for the $\gaptr$ problem with $\kappa=0$ when the input is all 0s. By definition this is an error. We want to show the probability of this error bounded away from 0.

From lemma 2, we have a high probability bound. If you refer to our [Definitions](../Definitions/) writeup for differential privacy we show the equivalence of writing concentration inequalities as inequalities. So one can re-write lemma 2 as 

\begin{align*}
e^{v}p_{0}(G(c) \in D) + e^{-\frac{(v - 32)^2}{32}} &\geq p_{A}(G(c) \in D) \\ 
&= \frac{p_{A}(G(c) \in D)}{e^{v}} - e^{-\frac{(v - 32)^2}{32}}
\end{align*}

We are done! The probability is bounded away from 0. So far we have only shown that it is impossible to compute GAP-TR with a gap smaller than $O(\sqrt{n})$ which was step 2 of the main proof. We still have to show step 1 and prove the two lemmas above.
</div>


<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#step1">Proof for Step 1 of main proof</button>
<div class=collapse id=step1>
  
### Theorem

If there exists an $\epsilon$-differentially private local model that approximates the sum of $n$ binary values upto error $\tau/2$ with probability $1 - \gamma$ by sending $\rho$ messages then $\forall \kappa$, there exists a $\epsilon$-differentially private local model that approximates $\gaptr$ with probability at $1 - \gamma$ by sending at most $\rho$ messages.

**Proof**: 

The proof is relatively simple. Since it's an existence proof we have to only come up one approximation of $\gaptr$ for any $\hat{f(X)}$ approximation of the sum. 


Let $\hat{f(X)}$ be the approximation of a sum of $n$ binary values. Define $\hat{g(X)}$ to be 0 if $\hat{f(X)} \leq \kappa + \tau/2$ and 1 otherwise. Let $g(X)$ and $f(X)$ be the true values of $\gaptr$ and $sum$ respectively.

We are given that $| f(X) - \hat{f(X)}| \geq tau/2 $ with probability less than $\gamma$

It is easy to show $\hat{g(X)}$ approximates $\gaptr$ with $\tau/2$ error with probability $1-\gamma$. **Assume it does not**

Consider the error event $\hat{g(X)} = 0$ and $g(X)=1$, by our assumption this event happens with probability greater than $\gamma$. 

If $\hat{g(X)} = 0$, then $\hat{f(X)} \leq \kappa + \tau/2$ and if $g(X) =1$, then $f(x) \geq \kappa + \tau$

We take the smallest value for $f(X)$ and the largest value for $\hat{f(X)}$ and get

\begin{align*}
| f(X) - \hat{f(X)}| &\geq | \kappa + \tau - kappa -\tau/2 |
&= \tau/2
\end{align*}

By our assumptions the above event happens with probability greater than $\gamma$. However by problem statement we had $| f(X) - \hat{f(X)}| \geq tau/2 $ with probability less than $\gamma$ so we have reached a contradiction. Our assumption was false.


**The main proof uses the contrapositive of the above theorem -- where we show that all local private protocol for approximating gap threshold upto $\sqrt{n}$ error fails with contant probaility, thus the same can be said about sum**.

</div>


<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#lemma1">Lemma 1</button>
<div class=collapse id=lemma1>
  

\begin{align*}
r_i(c_i) &= \frac{\P{S_i(X_i) = c_i}{X}{A}}{\mathbb{P}[S_i(0) = c]} \\
&= \frac{\alpha\mathbb{P}[S_i(1) = c_i] + (1-\alpha)\mathbb{P}[S_i(0) = c_i]}{\mathbb{P}[S_i(0) = c]} \tag{1}\label{1}\\
&= 1 + \alpha\Big(\frac{\mathbb{P}[S_i(1) = c_i]}{\mathbb{P}[S_i(0) = c_i]} - 1\Big)
\end{align*}

$\ref{1}:$ By defintion of distribution $X \sim A$

**From the defintion of local privacy**, we have 

$$e^{-2\epsilon} \leq \frac{\mathbb{P}[S_i(1) = c_i]}{\mathbb{P}[S_i(0) = c_i]} \leq e^{2\epsilon}$$

Subtracting 1 from both sides, Multiplying both sides by $\alpha$ and adding +1 

$$1 + \alpha(e^{-2\epsilon} - 1) \leq 1 + \alpha \Big(\frac{\mathbb{P}[S_i(1) = c_i]}{\mathbb{P}[S_i(0) = c_i]} - 1\Big)   \leq 1 + \alpha(e^{2\epsilon} - 1)$$

Taylors expansion for $e^x$ gives us:

$e^2x < 1 + 4x$ and $1 - e^{-2x} < 2x$ for $0 < x \leq 1$, thus we get the first inequality.

Using $\log(1+x) \leq x$ and $\log(1-x) \geq -2x$ for $0 < x \leq 0.5$ we get the second inequality

</div>

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#lemma2">Lemma 2</button>
<div class=collapse id=lemma2>
  
This proof assumes that each sanitizer $S_i$'s' output is in a countable set. **NOTE: This assumption is not broken in local privacy as the number of messages per user is bounded. As the inputs are only 1 or 0, the set of possible outputs has to be countable. If you were to unbound this by sending infinite messages per input-- you are no longer in the local protocol of restricted communication.**


Let $B_{b} := \{ c_i : r_i(c_i) = 1 + b\}$ for $-2\alpha\epsilon \leq b \leq 4\alpha\epsilon$. Lemma 1 implies there are no other possible values for b.

\begin{align*}
\frac{\mathbb{P}[S(X_i) = c_i]}{\mathbb{P}[S(0) = c_i]}  &= r_i(c_i) \\
&= 1 + b \\
\mathbb{P}[S(0) \in B_b]  &= \frac{\mathbb{P}[S(X_i) \in B_b]}{1+b} \\
&\leq (1 - b +2b^2)\mathbb{P}[S(X_i) \in B_b] \label{5}\tag{1}\\
\end{align*}

$\ref{5}:$ By Taylors theorem of $(1 + x)^-1$ or the geometric series $\frac{1}{1-x}$, where you plug in x as -x.

Let $\beta=2\alpha\epsilon$

\begin{align*}
\mathbb{E}[V_i] &= \mathbb{E}_{A}[\log r_i(c_i)] \\
&= \sum+_{-\beta \leq b \leq 2\beta} \mathbb{P}[S(X_i) \in B_b] \log( 1 + b) \\
&\leq \sum+_{-\beta \leq b \leq 2\beta} \mathbb{P}[S(X_i) \in B_b] b \label{6}\tag{2}\\
&=  \sum+_{-\beta \leq b \leq 2\beta} \mathbb{P}[S(X_i) \in B_b] (1 + 2b^2) -  \sum+_{-\beta \leq b \leq 2\beta} \mathbb{P}[S(X_i) \in B_b] (1 -b +2b^2) \\
&\leq (1 + 2(2\beta)^2)\sum+_{-\beta \leq b \leq 2\beta} \mathbb{P}[S(X_i) \in B_b]  -  \sum+_{-\beta \leq b \leq 2\beta} \mathbb{P}[S(X_i) \in B_b] (1 -b +2b^2) \\
&\leq (1 + 2(2\beta)^2)\sum+_{-\beta \leq b \leq 2\beta} \mathbb{P}[S(X_i) \in B_b]  -  \sum+_{-\beta \leq b \leq 2\beta} \mathbb{P}[S(0) \in B_b] \label{7}\tag{3}\\
&=  (1 + 8\beta^2)\mathbb{P}[S(X_i) \in \cup_{b}B_b] - \mathbb{P}[S(0) \in \cup_{b}B_b] \\
&\leq (1 + 8\beta^2).1 - 1 \\
&= 32(\alpha\epsilon)^2
\end{align*}

$\ref{6}: \log(1+x) \leq x$

$\ref{7}:$ By $\ref{5}$
</div>


<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#lemma3">Lemma 3</button>
<div class=collapse id=lemma3>
  

\begin{align*}
\mathbb{P}_{A}[r(C) > e^v] &= \mathbb{P}_{A}[\sum_{i=1}^n V_i > v] \label{2}\tag{1}\\
&= \mathbb{P}_{A}\Big[\sum_{i=1}^n V_i - \sum_{i=1}^n \mathbb{E}[V_i]> v - \sum_{i=1}^n \mathbb{E}[V_i]\Big] \\
&\leq \mathbb{P}_{A}\Big[\sum_{i=1}^n V_i - \sum_{i=1}^n \mathbb{E}[V_i]> v - 32\alpha^2\epsilon^2\Big] \tag{2} \label{3}\\
&\leq exp\Big\{ -\frac{2(v - n32\alpha^2\epsilon^2)^2}{64n\alpha^2\epsilon^2} \Big\} \tag{3} \label{4} \\
&= exp\Big\{ -\frac{(v - 32)^2}{32} \Big\}
\end{align*}


$\ref{2}:$ Taking log on both sides and using defintions

$\ref{3}:$ Lemma 2

$\ref{4}:$ Hoeffding on bounded variables, from Lemma 2, we get $V_i$ is upper and lower bounded. Plug and play

</div>

## References 

[1]: ../DiscreteLaplace/paper.pdf "UNIVERSALLY UTILITY-MAXIMIZING PRIVACY MECHANISMS"
1. [UNIVERSALLY UTILITY-MAXIMIZING PRIVACY MECHANISMS](../DiscreteLaplace/paper.pdf)

[2]: https://arxiv.org/pdf/1903.02837.pdf "The privacy blanket of the shuffle model"
2. [The privacy blanket of the shuffle model](https://arxiv.org/pdf/1903.02837.pdf)

[3]: https://arxiv.org/pdf/1103.2626.pdf "Distributed Private Data Analysis: On Simultaneously Solving How and What"
3. [Distributed Private Data Analysis: On Simultaneously Solving How and What](https://arxiv.org/pdf/1103.2626.pdf)

[4]: https://mathoverflow.net/questions/213221/what-is-a-two-sided-geometric-distribution "Distinction between one sided and 2 sided Geometric distributions"
4. [Distinction between one sided and 2 sided Geometric distributions](https://mathoverflow.net/questions/213221/what-is-a-two-sided-geometric-distribution)
	
</div>
