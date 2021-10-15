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


## Hoeffdings Bound

## Useful tricks

### Bounding Bernoullis

### Bounding exponentials


# Resources
* [How are moment Generating functions used](https://towardsdatascience.com/moment-generating-function-explained-27821a739035)
* [Markov and Chebyshev](https://math.dartmouth.edu/~m20x18/markov)
* [Chernoff Bounds]()

</div>