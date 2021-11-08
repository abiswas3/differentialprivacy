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

Draft (last update): Novmber 8th, 2021. 14:02 BST

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


Now consider a simplified version of the sample and threshold algorithm.

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

The above set of equations ignores thresholding. If the number of 1's sampled is less than $\tau$, the algorithm returns 0. The number of 1's sampled is $n - c$, thus if $(n - c) \leq \tau$ the $\hat{f(X)} = 0$. Otherwise

$\hat{f(X)} = -c + 2n - np_2$ which in expectation gives us what we want. Also note that that variance of both estimators are the exact same. In fact they are practically equivalent.
</div>

## Connection between Sampling and Shuffle privacy for histogram sums

We have shown that for binary sums, shuffle privacy and sample privacy are equivalent. We now look at the shuffle privacy algorithm [described in detail here](ShufflePrivacy/index.html).

Now each user has a value $x \in \{1, 2, ..., d \}$. As shorthand we right $x_i \in \floor{d}$. Cheu et al, just decompose this into $d$ binary sum problems for each $d$. For a particular $j \in \floor{d}$, all $x_i=j$ are set to 1 and the rest are set to 0. Then the analyser outputs $j \times \hat{f}(X)$ by running the previous algorithm. 

Now consider the sampling algorithm. We do the exact same pre-processing for each $j \in \floor{d}$. Now instead of additive bernoulli noise we just sample/multiply with the random variables as shown above. We have shown equivalence.

## Analysing the parameters

From the above anlaysis it seems the two methods are doing the same thing - Adding bernoulli random variables to binary inputs. However, the analysis of the two alogrithms produces different dependencies on $\epsilon, \delta$ in the proofs to guarantee privacy. In this section we try and understand this discrepancy. The difference in the two bounds must be in the assumptions and constraints on the parameters given by the problem setup. Note there is a noticebale difference in the problem setups for shuffle privacy and sample-threshold privacy. We describe it the next few sections.

### Identical behaviour for all 0 input

For an input of all 0's i.e $\sum_{i=1}^n x_i =0$ both shuffle and sample give 0 error. Part 3 of theorem one proves this in the [shuffle privacy](ShufflePrivacy/index.html) case. For the sample and threshold regime, if all inputs $x_i=0$ then $c=n$ and $\tau > 1$ so $(n - c) < \tau$ always. Thus the algorithm outputs 0.

### Dependence on $\epsilon$ and $\delta$

#### Shuffle

Both regimes guarantee privacy under a good event. Both regimes claim that privacy is preserved with probaility $1 - \delta$ -- where $\delta$ shrinks very quickly as $n$ grows -- at least at the rate of $\frac{1}{n}$.

To guarantee privacy, shuffle privacy needs event $E_1$ and sample-threshold needs event $E_2$. Let these events occur with probability at least $1 - \delta_1$ and $1 - \delta_2$.

The proof for Shuffle privacy works out because the binomial distribution $(\epsilon, \delta, k)$-smooth. Source: [[2][2]] define := distribution $\D$ is smooth over $\Z$ is $(\epsilon, \delta, k)$
smooth, if $\forall k' \in [-k, k]$ if the event E

$$\P{E \geq e^{|k'|\epsilon}}{Y}{\D} \leq \delta$$ or 

$$\P{E < e^{|k'|\epsilon}}{Y}{\D} > 1 - \delta$$

where $$E=\frac{\P{Y'=Y}{Y'}{D}}{\P{Y'=Y+k'}{Y'}{D}}$$

Appendix C, Lemma 4.12 of [[2][2]]: proves that a binomial distribution is smooth. They show this by showing that if event $E_1$ happens, then event $E > e^{|k'|\epsilon}$ happening is impossible i.e. $E_1 => E \leq e^{|k'|\epsilon}$ and event $E_1$ happens with probality at least 1 - $\delta$. The event $E_1$ is the event that sum of $n$ $Bernoulli(p_1)$ random variables be within a multiplicative factor of the mean. Simply put it is concentrated around its mean or mathematically

$$E_1 := \sum_{i=1}^n x_i \in [(1 - \alpha)np_1 + k, (1 + \alpha)np_1 - k]$$ where $\alpha \in (0,1)$ and $k=1$ and $x_i \sim Bernoulli(p_1)$

Event $E_1$ can be bounded by the multiplicative chernoff bound. So the $\delta$ in shuffle privacy is pulled from the mulipilicative chernoff bound which needs the sum of bernoulli variables to be concentrated around its mean. The connection between the multiplicative factor $\alpha$ and the privacy parameter $\epsilon$ is $\epsilon = \log(\frac{1 + \alpha}{1- \alpha})$ or $\alpha = \frac{e^{\epsilon} - 1}{e^{\epsilon} + 1}$. So privacy to hold we need,

$$E_1 := \sum_{i=1}^n x_i \in [(1 - \frac{e^{\epsilon} - 1}{e^{\epsilon} + 1})np_1 + k, (1 + \frac{e^{\epsilon} - 1}{e^{\epsilon} + 1})np_1 - k]$$ 


#### Sample-Threshold

Now we look at the event $E_2$ that is needed for privacy to hold. From Grahams AI stats submission, lemma 1 defines $E_2$. Lemma 1 states: the probability that the number of samples of an item is more than $\tau$ times its expectation is at most $\delta$, for $\tau = 3 + \log(1/\delta)$. In the world of just binary numbers, these requirements can be restated as the following: 

Given the number of 1's in the population is k. i.e. $\sum_{i=1}^n x_i = k$. Each person $x_i$ has a p_2 chance of being sampled. Thus the expected number of 1's in the sampled dataset is simply $kp_2=\frac{km}{n}$

Our good event, **which requires $\frac{m}{n} > \frac{1}{k^2}$** Thus we need at least $m > \frac{n}{k^2}$ so we can't pick any $m$.

$$E_2: = \sum_{i=1}^n x_i \leq \tau\frac{km}{n}$$. Finally if we want this event to hold with probability at most $\delta$, $\tau$ must be at least $3 + \log(1/\delta)$. We get 

$$ E_2: = \sum_{i=1}^n x_i \leq \Big(3 + \log(1/\delta)\Big)\frac{km}{n}$$ 


## IGNORE

We fix . For a given $\epsilon, \delta \in [0,1]$, [shuffle privacy](ShufflePrivacy/index.html) requires the number of users $n$ to be atleast $\frac{100}{\epsilon^2}\log(2/\delta)$ to ensure the release of binary sums is private. There is no user specified parameter like $m$ here. $n$ users show up with a desire for $\epsDelta$ privacy. If n is above a certain value, then they will get privacy with probability 1 - $\delta$. 

Shown below is a heatmap of the size of $n$ is powers of 10 given different parameter values.

<img src=pngs/shuffleN.png></img>

In sample and threshold there is a user specified parameter $m$ which dictates how many people we sample. This $m$ dictates the probability $p_2$ in the above algorithm. We want to sample $m$ users on average, thus $np_2 =m$ or $p_2=\frac{m}{n}$. **This the first difference in between the two setups**. In shuffle privacy given $n, \epsDelta$ we are allowed to select an optimal value for $p$ (if it is possible). In sample and threshold privacy, someone else gives us $p$ and it can be value in $[0,1]$ and we have to guarantee privacy from here. Shuffle privacy states that as long as we have $n \geq \frac{100}{\epsilon^2}\log(2/\delta)$ users we are good with high probabilty. The high probability statement is simply saying there is an event $E_1$ which happens with probability $1 - \delta$. If this event $E_1$ happens we get privacy.

Sample privacy on the other hand asks for a requirement on the distribution of values in the $n$ users -- this is where $\tau$ comes in. We need the number of 1's in the set of users to be above a certain level.

Now $n$ users show up with a desire for $\epsDelta$ privacy -- to guarantee privacy we need 

### Dependence on 

## 

# References 

[1]: https://arxiv.org/pdf/2109.13158.pdf "Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message"
1. [Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message](https://arxiv.org/pdf/2109.13158.pdf)

[2]: https://arxiv.org/pdf/1908.11358.pdf  "On the power of multiple anonymous messages"
2. [On the power of multiple anonymous messages](https://arxiv.org/pdf/1908.11358.pdf)

</div>