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
\newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}

<div class="container">
Draft (first update): Novmber 2nd, 2021, 10:04 BST 

Draft (last update): Novmber 2nd, 2021. 19:17 BST

# Introduction

Consider the problem of releasing the histogram sum <div class="question">(I think they are called counting queries or something else or succint histograms)</div> of a population of integers privately under the three models:

1. Laplace Mechanism for Central Privacy
2. Binomial noise in Shuffle Privacy by [Cheu](ShufflePrivacy/index.html) 
3. Sample and Threshold Method that was re-derived by Graham.
4. **TODO: [Ghazi, Rasmus Pagh -- binary sums and histograms](ShuffleSumBinaryRasmus/)** is also very closely connected. Working on this as next step if these proofs are correct.

We can show they 2 and 3 are equivalent. In terms of how 2 and 3 relate to 1:<div class="intuition">I have not proven this fact explicitly yet but I think I can show (1) just happens to be the "sharpest" sub-gaussian noise distribution we can sample from with tails fat enough for the right signal to noise. Conceptually I think it will end up looking like hinge loss and logistic loss where both work in practice. Logistic loss is smoother and nicer but the hinge loss is the tighest convex relaxation to the 0-1 loss.</div> We first look at the binary summation problem and then for summation of integers.


## Binary Sums 

Each member of the dataset $x \in D$ holds a value in $\{0, 1\}$. We simply want to estimate $f(X) = \sum_{i=1}^n x_i$. Let $\hat{f}(X)$ be the estimated sum by the algorithms. Understanding binary sum gives us all the key insights we need to anslyse integer sums. In this writeup we consider the view of the anlyser for the three regimes in consideration. **NOTE:** this is purely for the sake of analysis. In practice they are usually implemented in a federated setting or local/shuffle privacy setting. The noise addition, thresholding and sampling might be done at the user level. We perform all the computations at the analyser level as it simplifies the analysis.

Under the [central privacy](Definitions/), the anlayser sees all the inputs, sums them and adds one instance noise drawn from a Laplace distribution. See picture below:

<div class="algorithm">

<img src=pngs/central.png></img>

$\hat{f(X)} = \sum_{i=1}^n x_i + Y$

where $Y \sim Lap(\frac{1}{\epsilon})$
</div>



In shuffle privacy, under the ["The binary histogram"](ShufflePrivacy/index.html) section of this writeup we show that the authors just draw $n$ random variables $z_i \sim Bernoulli(p_1)$ and add them $f(X)$. Let $Y= \sum_{i=1}^n z_i$, the final answer is just the expected value of $Y$ subtracted from $f(X)$. In all these shuffle privacy papers which claim near central accuracy, this is repeated theme. $n$ units of little noise that when added up -- pretend to be one unit from a smooth sub gaussian distribution. In [Ghazi, Rasmus Pagh -- binary sums and histograms](ShuffleSumBinaryRasmus/) they dive deep into this with Poisson, Negative Binomial and Discrete Laplace distributions (all infinitely divisible distributions) See picture below:

<div class="algorithm">

<img src=pngs/shuffle.png></img>

$\hat{f}(X) = \sum_{i=1}^n (x_i + z_i) - E[\sum_{i=1}^n z_i]$

$\hat{f}(X) = \sum_{i=1}^n (x_i + z_i) - np_1$

where $z_i \sim Bernoulli(p_1))$
</div>


Both methods add one single instance of noise to the truth: (1) Adds one Laplacian random variable (2) Adds one random variable drawn from a $Binomial(n, p_1)$. All the work in [Cheu](ShufflePrivacy/index.html) is to figure out what values of $p$ is acceptable given $\epsilon$ and $\delta$ to ensure privacy. If one were to plot the formulae they use, it shows that only a restricted range of $\epsilon$ and $\delta$ is possible. 


Now consider a simplified version of the sample and threshold algorithm. For simplicity assume $\tau = 0$ i.e. there is no thresholding. We'll analyse the impact of thresholding in later section **Should not be too hard to show it only helps**.

The analyser receives values from $n$ users. For each user, it generates a random variable $z_i \sim Bernoulli(p_2)$. If the $z_i$ is heads it includes sample $x_i$ in the calculation for the sum, otherwise it does not. This describes Poisson sampling as described in the paper. Thus algorithm is outputting $\hat{f}(X) = \sum_{i=1}^n z_i x_i$. We now show that with a bit of simple algebra, this algorithm is equivalent to the shuffle privacy algorithm for the case of Binary sums. 

Define the bit flipping operator as $\bar{x} = 1 - x$. For each $z_i  x_i$ the analyser sees, assume it just flips the output to $\bar{x_i z_i}$ and uses this sum instead. We are interested in an estimator that in expectation gives us $\sum_{i=1}^n x_i$. Note: there are exactly the same number of random variables in this method as there is in the shuffle method. 


<div class="algorithm">

<img src=pngs/sample.png></img>

\begin{align*}
c &= \sum_{i=1}^n\bar{x_i z_i} \\
&= \sum_{i=1}^n(\bar{x_i} + \bar{z_i} )\tag{1}\label{1} \\
&= (n - \sum_{i=1}^n x_i) + (n - \sum_{i=1}^n z_i) \\
&= 2n - \sum_{i=1}^n x_i - \sum_{i=1}^n z_i
\end{align*}

$\ref{1}:$ simple boolean algebra, De-Morgan's Law 

We can just normalise this by outputting, $\hat{f(X)} = -c + 2n - np_2$ which in expectation gives us what we want. Also note that that variance of both estimators are the exact same. In fact they are practically equivalent.
</div>

## Connection between Sampling and Shuffle privacy for histogram sums

We have shown that for binary sums, shuffle privacy and sample privacy are equivalent. We now look at the shuffle privacy algorithm [described in detail here](ShufflePrivacy/index.html).

Now each user has a value $x \in \{1, 2, ..., d \}$. As shorthand we right $x_i \in \floor{d}$. Cheu et al, just decompose this into $d$ binary sum problems for each $d$. For a particular $j \in \floor{d}$, all $x_i=j$ are set to 1 and the rest are set to 0. Then the analyser outputs $j \times \hat{f}(X)$ by running the previous algorithm. 

Now consider the sampling algorithm. We do the exact same pre-processing for each $j \in \floor{d}$. Now instead of additive bernoulli noise we just sample/multiply with the random variables as shown above. We have shown equivalence.


# References 

[1]: https://arxiv.org/pdf/2109.13158.pdf "Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message"
1. [Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message](https://arxiv.org/pdf/2109.13158.pdf)

</div>