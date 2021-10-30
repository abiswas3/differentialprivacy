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

<div class="container">
# Concentration Inequalities

Interested in tail bounds i.e. how random variables deviate from their means.

**Plot the different rates and show why one is better than the other** 

## Markovs inequlity

The simplest tail bound that applies to any **non negative random variable** is the markov inequality. 

$$\P{X \geq a}{X}{D} \leq \frac{\mathbb{E}[X]}{a}$$ $\forall a > 0$ where $D$ is the distribution of the random variable.

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#markovInEq">Proof</button>
<div class=collapse id=markovInEq>


Let $X : S \rightarrow R^+$ be a non-negative random variable

We can divide the set $S = S_1 + S_2$ where $S_1 = \{ s | X(s) \geq a\}$  and $S_2 = \{ s | X(s) < a\}$


\begin{align*}
\mathbb{E}[X] &= \int_{s \in S} X(s)f(s)ds \\
&=\int_{s \in S_1} X(s)f(s)ds + \int_{s \in S_2} X(s)f(s)ds \\
\end{align*}

Since $\int_{s \in S_2} X(s)f(s)ds \geq 0$ as $X(s)  > 0$ $\forall s \in S$, we have


\begin{align*}
\int_{s \in S_1} af(s)ds &\leq \int_{s \in S_1} X(s)f(s)ds \\
&\leq \mathbb{E}[X] \\
\int_{s \in S_1} f(s)ds &\leq  \frac{\mathbb{E}[X]}{a}\\
\mathbb{P}[X \geq a]&\leq \frac{\mathbb{E}[X]}{a} \\
\end{align*}

</div>


## Chebyshevs inequality

The next tail bound is for random variables from a slighlty more restrictive class. Variables who have their variances bounded. The only assumption the Markov inequality makes is that the random variable is non negative.


$$\P{|X - \mu| \geq a}{X}{D} \leq \frac{Var(X)}{a^2}$$

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#Chebyshev">Proof</button>
<div class=collapse id=Chebyshev>

Let $X$ be a random variable where $Var(X) = \sigma^2$. By Markov, for every $a > 0$

\begin{align*}
\mathbb{P}[ (X - \mu)^2 \geq a^2] &\leq \frac{\mathbb{E}[(X - \mu)^2]}{a^2} \\
&= \frac{\sigma^2}{a^2}
\end{align*}

Note the event $\mathbb{P}[|X - \mu| \geq a] = \mathbb{P}[(X - \mu)^2 \geq a^2]$ thus we can conclude that 

$$\P{|X - \mu| \geq a}{X}{D} \leq \frac{Var(X)}{a^2}$$
</div>



## Weak Law Large of Numbers

The Chebyshev inequality also gives us the weak law of large numbers under the same assumptions (the probability distribution must have finite variance). The weak law of large numbers states

$$\frac{1}{N}\sum_{i=1}^N X_i \xrightarrow[]{\text{P}} \mu$$ as $N \rightarrow \infty$ or in other words the same statement is equivalent to

For any $\epsilon > 0$ $$ \mathbb{P}[|\sum_{i=1}^N X_i - \mu| \geq \epsilon] = 0 $$ as $N \rightarrow \infty$

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#WeakLawOfLarge">Proof</button>
<div class=collapse id=WeakLawOfLarge>

Pick $a > 0$, then 

\begin{align*}
\P{|1/N\sum_{i=1}^N X_i - \mu| \geq a}{X_i}{D} &\leq \frac{Var(1/N\sum_{i=1}^N X_i)}{a^2} \label{1}\tag{1} \\
&= \frac{1}{N^2}Var(X_i)
\end{align*}

Clearly as $N \rightarrow \infty$, the RHS goes to 0.

$\ref{1}$ Using chebychev
</div>


## The Chernoff Bound

**There are a million variants to the Chernoff bound:**The Chernoff bound is like a genericized trademark: it refers not to a particular inequality, but rather a technique for obtaining exponentially decreasing bounds on tail probabilities.

Authors in [[1][1]] wrote a very good article on the different versions of the Chernoff Bound and where they come from. I've reproduced them here only to strengthen my understanding. 

### The theorem in its most general form

Let $X_1, \dots, X_n$ be i.i.d random variables such that $X_i \in \{ 0, 1\}$ and $\mathbb{P}[X_i=1] = p$, then the probability that sum of the variables deviates from its mean drops exponentially with the number of samples. Formally, 

$$\mathbb{P}[\sum_{i=1}^nX_i \geq (p + t)n] \leq e^{-D_{KL}(p + t || p)n}$$

It can also be shown that when $p \geq 1/2$, $D_{KL}[p + t || p] > \frac{t^2}{2p(1-p)}$, multiplying both sides by -n, we get $D_{KL}[p + t || p] \leq \frac{nt^2}{2p(1-p)}$, thus the above bound is also popularly written as 

$$\mathbb{P}\Big[\sum_{i=1}^nX_i \geq (p + t)n\Big] \leq e^{-\frac{nt^2}{2p(1-p)}} \leq e^{-2nt^2}$$ where the last bound comes from plugging in $p=1/2$


<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#chernoff1">Classical textbook proof using Bernstein</button>
<div class=collapse id=chernoff1>

The usual textbook proof of the above theorem uses the exponential function and Markov’s inequality.
It is called the moment method, because exp simultaneously encodes all moments $X,X^2,X^3,...$
of X. This trick is often attributed to Bernstein and is called the Bernstein's Trick. 

\begin{align*}
\mathbb{P}\Big[\sum_{i=1}^nX_i \geq (p + t)n\Big] &= \mathbb{P}\Big[\lambda\sum_{i=1}^nX_i \geq \lambda(p + t)n\Big] \\
&= \mathbb{P}\Big[e^{\lambda\sum_{i=1}^nX_i} \geq e^{\lambda(p + t)n}\Big] \\
&= \mathbb{P}\Big[e^{\lambda X} \geq e^{\lambda(p + t)n}\Big] \label{3}\tag{1}\\
&\leq \frac{\mathbb{E}[e^{\lambda X}]}{ e^{\lambda(p + t)n}} \label{4}\tag{2}\\
&= \frac{\mathbb{E}[\prod_{i=1}^ne^{\lambda X_i}]}{ e^{\lambda(p + t)n}}\\
&= \frac{\prod_{i=1}^n \mathbb{E}[e^{\lambda X_i}]}{ e^{\lambda(p + t)n}} \label{5}\tag{3}\\
&= \Big[ \frac{\mathbb{E}[e^{\lambda X_i}]}{ e^{\lambda(p + t)}} \Big]^n\\
&= \Big[ \frac{1 - p + pe^\lambda}{ e^{\lambda(p + t)}} \Big]^n \label{6}\tag{4}\\
\end{align*}

$\ref{3} X = \sum_{i=1}^nX_i$

$\ref{4}$: By Markov inequality

$\ref{5}$: By Independence

$\ref{6}$ : [Moment Generating function of a bernoulli](https://proofwiki.org/wiki/Moment_Generating_Function_of_Bernoulli_Distribution)

or every $\lambda > 0$. Optimizing for $\lambda$ using calculus (taking derivative and setting it to 0, we get that the right hand side is minimized 

$$ e^\lambda = \frac{(1-p)(p+t)}{p(1 - p - t)}$$ and then plugging it back into the RHS, we get

\begin{align*}
\mathbb{P}\Big[\sum_{i=1}^nX_i \geq (p + t)n\Big] &\leq \Big[ \frac{1 - p + pe^\lambda}{ e^{\lambda(p + t)}} \Big]^n \\
&= \Big( [\frac{p}{p+t}]^{p+t}[\frac{1-p}{1-p-t}]^{1 - p - t}\Big)^n \\
&= e^{-D_{KL}(p + t || p)n}
\end{align*}
</div>



<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#chernoff2">Proof using binomial theorem</button>
<div class=collapse id=chernoff2>
Let $B(n,p)$ be the random variable that gives the number of heads in $n$ independent Bernoulli trials with success probability $p$. For any $\tau \geq 1$

\begin{align*}
\mathbb{P}[B(n,p) \geq k] &= \sum_{i=k}^n {n \choose i} p^{i}(1-p)^{n-i} \\
&\leq \sum_{i=k}^n {n \choose i} p^{i}(1-p)^{n-i}\tau^{i-k} + \sum_{i=0}^{k-1} {n \choose i} p^{i}(1-p)^{n-i}\tau^{i-k} \\
&\leq \frac{1}{\tau^k}\sum_{i=k}^n {n \choose i} (p\tau)^{i}(1-p)^{n-i} \\
&= \frac{1}{\tau^k}[p\tau + 1 - p]^n  \label{7}\tag{1}\\
\end{align*}

$\ref{7}: $ Binomial Theorem

if we plug $k= (t+p)n$, we go back to $\ref{6}$ of the classical proof and get to the same bound.
</div>


<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#chernoff3">Proof using differential privacy</button>
<div class=collapse id=chernoff3>
TODO
</div>

### Chernoff Lower tail 

This is just the other side of the concentration.

$$\mathbb{P}[\sum_{i=1}^nX_i \leq (p - t)n] \leq e^{-D_{KL}(p - t || p)n}$$

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#chernoffLowerTail">Proof</button>
<div class=collapse id=chernoffLowerTail>

\begin{align*}
\mathbb{P}[ X \leq n(p - t)] &= \mathbb{P}[ -X \geq -n(p - t)]\\
&= \mathbb{P}[ n - X \leq n - n(p - t)] \\
&= \mathbb{P}[ X^{'} \leq n(1 - p + t)] \\
&= \mathbb{P}[ X^{'} \leq n(p^{'} + t)] \\
&\leq e^{-D_{KL}(1 - p + t || 1 - p)n} \\
&\leq e^{-D_{KL}(p - t || p)n}
\end{align*}

where $X^{'}$ is just the original Bernoulli random variable flipped and $p^{'}= 1 - p$ is the probability of seeing a tails.

</div>

### Muliplicative version

This well-known version of the bound can be found in the classic text by Motwani and Raghavan.

Let $\delta \geq 0$ and $\mu=pn$, 

$$\mathbb{P}[\sum_{i=1}^n X_i \geq (1 + \delta)\mu] \leq \Big( \frac{e^{\delta}}{(1 + \delta)^{(1 + \delta)}}\Big)^{\mu}$$ 

Let $\delta \geq 0$ and $\mu=pn$, 


$$\mathbb{P}[\sum_{i=1}^n X_i \geq (1 - \delta)\mu] \leq \Big( \frac{e^{-\delta}}{(1 - \delta)^{(1 - \delta)}}\Big)^{\mu}$$ 


<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#chernoffMult">Proof</button>
<div class=collapse id=chernoffMult>

Setting $t=\frac{\delta\mu}{n}$ in the original theorem: 

\begin{align*}
\mathbb{P}[X \geq (p + t)n]  &= \mathbb{P}[X \geq (1 + \delta)\mu]  \\
\text{todo}\\
\end{align*}
</div>


### Weaker but more compact form

TODO 

## Hoeffdings Bound

TODO

## Monte Carlo Simulations

Python code to consolidate understanding -- re-creating definitions in code and observing how often the theoretical guarantees are violated.

<embed type="text/html" src="code/sample.html" width="800" height="600"> 


## Hypergeometric distribution

TODO

## Negative Correlation

TODO

## Useful tricks 


### Bounding Bernoullis

TODO

### Bounding exponentials

TODO

# Resources

[1]: https://page.mi.fu-berlin.de/mulzer/pubs/chernoff.wpdf  "Chernoff Bounds and its applications"
1. [Chernoff Bounds and its applications](https://page.mi.fu-berlin.de/mulzer/pubs/chernoff.wpdf)

[2]: https://math.dartmouth.edu/~m20x18/markov  "Markov and Chebyshev bounds"
2. [Markov and Chebyshev bounds](https://math.dartmouth.edu/~m20x18/markov)


</div>