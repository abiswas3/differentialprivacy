\newcommand{\P}[3]{\mathbb{P}_{#2 \sim #3}\Big[#1\Big]}
\newcommand{\D}{\mathbb{D}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\E}{\mathbb{E}}
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
2. Binomial noise in Shuffle Privacy by [Cheu](../ShufflePrivacy/index.html) 
3. Sample and Threshold Method that was re-derived by Graham.
4. **TODO: [Ghazi, Rasmus Pagh -- binary sums and histograms](../ShuffleSumBinaryRasmus/)** is also very closely connected. Working on this as next step if these proofs are correct.

We can show they 2 and 3 are equivalent. In terms of how 2 and 3 relate to 1:<div class="intuition">I have not proven this fact explicitly yet but I think I can show (1) just happens to be the "sharpest" sub-gaussian noise distribution we can sample from with tails fat enough for the right signal to noise. Conceptually I think it will end up looking like hinge loss and logistic loss where both work in practice. Logistic loss is smoother and nicer but the hinge loss is the tighest convex relaxation to the 0-1 loss.</div> We first look at the binary summation problem and then for summation of integers.


## Binary Sums 

Each member of the dataset $x \in D$ holds a value in $\{0, 1\}$. We simply want to estimate $f(X) = \sum_{i=1}^n x_i$. Let $\hat{f}(X)$ be the estimated sum by the algorithms. Understanding binary sum gives us all the key insights we need to anslyse integer sums. In this writeup we consider the view of the anlyser for the three regimes in consideration. **NOTE:** this is purely for the sake of analysis. In practice they are usually implemented in a federated setting or local/shuffle privacy setting. The noise addition, thresholding and sampling might be done at the user level. We perform all the computations at the analyser level as it simplifies the analysis.

Under the [central privacy](Definitions/), the anlayser sees all the inputs, sums them and adds one instance noise drawn from a Laplace distribution. See picture below:

<div class="algorithm">

<img src=pngs/central.png></img>

$\hat{f}(X) = \sum_{i=1}^n x_i + Y$

where $Y \sim Lap(\frac{1}{\epsilon})$
</div>



In shuffle privacy, under the ["The binary histogram"](../ShufflePrivacy/index.html) section of this writeup we show that the authors just draw $n$ random variables $z_i \sim Bernoulli(p_1)$ and add them $f(X)$. Let $Y= \sum_{i=1}^n z_i$, the final answer is just the expected value of $Y$ subtracted from $f(X)$. In all these shuffle privacy papers which claim near central accuracy, this is repeated theme. $n$ units of little noise that when added up -- pretend to be one unit from a smooth sub gaussian distribution. In [Ghazi, Rasmus Pagh -- binary sums and histograms](../ShuffleSumBinaryRasmus/) they dive deep into this with Poisson, Negative Binomial and Discrete Laplace distributions (all infinitely divisible distributions) See picture below. <div class="new">Something I did not notice in the first pass is that the algorithm is not simply add bernoulli random variables to binary variables. The last line of this algorithm has a strong connection with thresholding. We will estbalish this connection: in the connecting parameters section.</div>

<div class="algorithm">

<img src=pngs/shuffle.png></img>

Let $c_A = \sum_{i=1}^n (x_i + z_i)$

$\hat{f}(X) =  c_A - E[\sum_{i=1}^n z_i]$ **only if $\sum_{i=1}^n (x_i + z_i) > n$ else 0**

<div class="intuition">That if condition is VERY important</div>

or, if we have $c_A > n$, then 

$\hat{f}(X) = \sum_{i=1}^n (x_i + z_i) - np_1$ 

else
$\hat{f}(X) = 0$

where $z_i \sim Bernoulli(p_1))$
</div>


Both methods add one single instance of noise to the truth: (1) Adds one Laplacian random variable (2) Adds one random variable drawn from a $Binomial(n, p_1)$. All the work in [Cheu](../ShufflePrivacy/index.html) is to figure out what values of $p$ is acceptable given $\epsilon$ and $\delta$ to ensure privacy. If one were to plot the formulae they use, it shows that only a restricted range of $\epsilon$ and $\delta$ is possible. 


Now consider a simplified version of the sample and threshold algorithm.

The analyser receives values from $n$ users. For each user, it generates a random variable $z_i \sim Bernoulli(p_2)$. If the $z_i$ is heads it includes sample $x_i$ in the calculation for the sum, otherwise it does not. This describes Poisson sampling as described in the paper. Thus algorithm is outputting $\hat{f}(X) = \sum_{i=1}^n z_i x_i$. We now show that with a bit of simple algebra, this algorithm is equivalent to the shuffle privacy algorithm for the case of Binary sums. 

Define the bit flipping operator as $\bar{x} = 1 - x$. For each $z_i  x_i$ the analyser sees, assume it just flips the output to $\bar{x_i z_i}$ and uses this sum instead. We are interested in an estimator that in expectation gives us $\sum_{i=1}^n x_i$. Note: there are exactly the same number of random variables in this method as there is in the shuffle method. 


<div class="algorithm">

<img src=pngs/sample.png></img>

\begin{align*}
c_B &= \sum_{i=1}^n\bar{x_i z_i} \\
&= \sum_{i=1}^n(\bar{x_i} + \bar{z_i} )\tag{1}\label{1} \\
&= (n - \sum_{i=1}^n x_i) + (n - \sum_{i=1}^n z_i) \\
&= 2n - \sum_{i=1}^n x_i - \sum_{i=1}^n z_i
\end{align*}

$\ref{1}:$ simple boolean algebra, De-Morgan's Law 

The above set of equations ignores thresholding. If the number of 1's sampled is less than $\tau$, the algorithm returns 0. The number of 1's sampled is $n - c_B$, thus if $(n - c_B) \leq \tau$ the $\hat{f(X)} = 0$. Otherwise

$\hat{f(X)} = -c_B + 2n - np_2$ which in expectation gives us what we want. Note: $c_B = 2n - c_A$


</div>

## Connection between Sampling and Shuffle privacy for histogram sums

We have shown that for binary sums, shuffle privacy and sample privacy are equivalent. We now look at the shuffle privacy algorithm [described in detail here](../ShufflePrivacy/index.html).

Now each user has a value $x \in \{1, 2, ..., d \}$. As shorthand we right $x_i \in \floor{d}$. Cheu et al, just decompose this into $d$ binary sum problems for each $d$. For a particular $j \in \floor{d}$, all $x_i=j$ are set to 1 and the rest are set to 0. Then the analyser outputs $j \times \hat{f}(X)$ by running the previous algorithm. 

Now consider the sampling algorithm. We do the exact same pre-processing for each $j \in \floor{d}$. Now instead of additive bernoulli noise we just sample/multiply with the random variables as shown above. We have shown equivalence.

## Analysing the parameters

From the above anlaysis it seems that the two regimes have exactly the same in randomness. Yet the privacy analysis in the proofs produces different dependencies on $\epsilon, \delta$. In this section we try and understand this discrepancy. The difference in the two bounds must be in the assumptions and constraints on the parameters given by the problem setup. In this section, we re-use the same notation from the previous setup:

* In shuffle privacy, there is no explicit assumption or consideration for the distribution of 1's in the population. The shuffle privacy world works like this:
	* The environment gives us $\epsilon, \delta \in [0, 1]$. The algorithm then checks if for the given values of $\epsDelta$ - privacy is possible. If the number of users $n \geq \frac{100}{\epsilon^2}\log(2/\delta)$ then we get pure $\epsilon$-privacy with probablity 1 - $\delta$. The algorithm picks the bernoulli parameter $p_1$ based on $\epsDelta$. The users or the environment do not control the parameter. There is never a discussion on the number of 1's in the dataset. It could be anything. Thus the guarantees appear to be distribution-free but they are not.
* The sample privacy world is a little different. The bounds depend on the number of 1's in the data, which are expresed as $k = \sum_{i=1}^n x_i$. The regime works as follows: 	
	* The environment gives us $\epsilon, \delta \in [0, 1]$. Now we go ahead and select $m \in \{1, 2, \dots, n/2 \}$ which is supposed to represent $m := \E[\sum_{i=1}^n z_i]$, where $z_i \sim Bernoulli(p_2)$. $m$ represents the number of users the Analyser samples on average if we used this sampling algorithm a lot. The paper expresses the privacy parameter $\epsilon = O(\frac{m}{n}\log(1/\delta))=\tilde{O}(\frac{m}{n})$. Smaller $m$ values give more privacy but worse accuracy. Larger $m$ gives accurate results but less privacy. For this procedure to work privately, there is $\tau \in \floor{\N}$, which requires we sample at least $\tau + 1$ users with 1's to get a non zero output. The value of $\tau$ and thereby its efficacy, depends on implicitly on the number of 1's in the population. 


In Shuffle privacy, $p_1 = \frac{50}{\epsilon^2n}\log(2/\delta)$ and in sample privacy $p_2 = \frac{m}{n}$. The variance of both methods and therefore mean square error is $n(1-p)p$, which is maximum when $p=1/2$ for $p= p_1, p_2$. Shuffle privacy requires that $n \geq \frac{100}{\epsilon^2}\log(2/\delta)$$

If we wanted to express $m$ in terms of the shuffle algorithm, we would get $m=\frac{50}{\epsilon^2}\log(2/\delta)$ by setting $p_1=p_2$. **NOTE we also the need to condition on n to hold.** To consider how the threshold $\tau$ shows up in previous algorithm, consider the the following: $\tau-$Sample privacy returns 0 when 

\begin{align*}
(n - c_B) &\leq \tau \\
(n - 2n + c_A) &\leq \tau \\
c_A &\leq \tau + n
\end{align*}

If we set $n$ to be a free parameter independent of $\epsilon, \delta$ like sample privacy does, then we need $\tau$ to be at least $\frac{100}{\epsilon^2}\log(2/\delta)$ to get privacy!

<div class="question">In the trying to relate the parameters of the two methods we notice some issues</div>
The analysis of sample privacy relates when $\epsilon$ and $m$ linearly wheras the analysis from shuffle privacy states $m = \tilde{O}(\frac{1}{\epsilon^2})$. <div class="intuition">How does that work out? There has to be  something going on between the relation of $m$ and $\tau$ in the sample privacy proofs</div> To understand this discrepancy we analyse the proofs next.

Before looking at the proof techniques for both methods,bounds we consider the case when everyone in the population has a zero value. Then we dive deeper into where the above bounds come from.

### Identical behaviour for all 0 input

For an input of all 0's i.e $\sum_{i=1}^n x_i =0$ both shuffle and sample give 0 error. Part 3 of theorem one proves this in the [shuffle privacy](../ShufflePrivacy/index.html) case. For the sample and threshold regime, if all inputs $x_i=0$ then $c=n$ and $\tau > 1$ so $(n - c) < \tau$ always. 

### Dependence on $\epsilon$ and $\delta$

In this section we re-derive the main parts of both proofs and establish the connection between the two regimes. Both regimes guarantee pure privacy under **a good event**. Both regimes claim that privacy is preserved with probaility $1 - \delta$ -- where $\delta$ (the likelihood of bad events) shrinks very quickly as $n$ grows. When we write "shuffle privacy needs" or "sample privacy needs", what we mean is the presented analysis in the paper needs -- not the algorithm itself. As shown above both algorithms are equivalent. To guarantee privacy, shuffle privacy needs event $E_1$ and sample-threshold needs event $E_2$. Let these events occur with probability at least $1 - \delta_1$ and $1 - \delta_2$. In this analysis we will derive shuffle privacy and then morph the sample privacy proof to show equivalence.

The version of chernoff bound for bernoulli's both papers utilise is the following: 

Let $\delta \geq 0$ and $\mu=pn$, 

$$\mathbb{P}[\sum_{i=1}^n X_i \geq (1 + \delta)\mu] \leq \Big( \frac{e^{\delta}}{(1 + \delta)^{(1 + \delta)}}\Big)^{\mu} \leq e^{-\frac{\delta^2\mu}{2 + \delta}}$$ 


<div class="row">

<div class="col-md-6">
#### Shuffle

First we try and understand what the good event $E_1$ actually is. The lemma's used in this section can be found in Appendix C, 4.11 and 4.12 of [[2][2]] or alternatively my re-derivations of the [same](../ShufflePrivacy/index.html).

The proofs for Shuffle privacy works out because the binomial distribution $(\epsilon, \delta, k)$-smooth and adding noise from a smooth distribution to the output of binary sums (which is a 1-incremental function) gives pure $\epsilon$ privacy with probality $1 - \delta$. In general if the function being evaluated has sensitivity $\Delta$, then we get $(\epsilon\Delta, \delta\Delta)$ privacy but in our case $\Delta=1$.

[[2][2]] define := distribution $\D$ is smooth over $\Z$ is $(\epsilon, \delta, k)$
smooth, if $\forall k' \in [-k, k]$ if the event E

$$\P{E \geq e^{|k'|\epsilon}}{Y}{\D} \leq \delta$$ or 

$$\P{E < e^{|k'|\epsilon}}{Y}{\D} > 1 - \delta$$

where $$E=\frac{\P{Y'=Y}{Y'}{D}}{\P{Y'=Y+k'}{Y'}{D}}$$

To show that binomial is smooth we need event $I(E \leq e^{|k'|\epsilon})$ happens with probability at least $1 - \delta$. In the proofs Ghazi et al show that if event $E_1$ happens, then event $I(E > e^{|k'|\epsilon})$ happening is impossible i.e. $E_1 => I(E \leq e^{|k'|\epsilon})$. 

Thus if event $E_1$ happens with probality at least 1 - $\delta$, then so will event $I(E \leq e^{|k'|\epsilon})$. The event $E_1$ is defined as the sum of $n$ $Bernoulli(p_1)$ random variables be within a multiplicative factor of the mean of their expected sum. They can as the set of bernoulli random variables such that $Z = (z_1,  \dots, z_n)$

$$E_1 := \{ Z | \sum_{i=1}^n z_i \in [(1 - \alpha)np_1 + k, (1 + \alpha)np_1 - k] \}$$ where $\alpha \in (0,1)$  and $k=1$ and $z_i \sim Bernoulli(p_1)$

The likelihood of this event $E_1$ can be bounded by the multiplicative chernoff bound. So the $\delta$ in shuffle privacy paper is pulled from the mulipilicative chernoff bound by setting the error region to 

$$\tilde{E_1} := \{ Z | \sum_{i=1}^n z_i \in [(1 - \alpha/2)np_1 , (1 + \alpha/2)np_1 ]\}$$ 

By the two sides of the multiplicative chernoff bound we get 

For $\alpha < 1$, we have $\mathbb{P}[Z \notin \tilde{E_1}] \leq exp(-\frac{\alpha^2p_1
n}{8}) + exp(-\frac{\alpha^2p_1 n}{8+2\alpha}) <
exp(-\frac{\alpha^2p_1 n}{10}) + exp(-\frac{\alpha^2p_1 n}{10})$

Setting $\delta =2exp(-\frac{\alpha^2p_1 n}{10})$, and solving for $p$ we get what we need.

Since $\tilde{E_1} \subseteq E_1$, if an event in $\tilde{E_1}$ happens with probability $1 - \delta$ then so will an event in $E_1$.

 The connection between the multiplicative factor $\alpha$ and the privacy parameter $\epsilon$ is $\alpha = \frac{e^{\epsilon} - 1}{e^{\epsilon} + 1}$. Note: a constant greater than equal to $\alpha$ will only make the good event region bigger, so bounds that hold for $\alpha = \frac{e^{\epsilon} - 1}{e^{\epsilon} + 1}$ will also hold. This is how Balcer and Cheu get their bounds, in their shuffle privacy paper, Balcer and cheu show that setting $\alpha = [\frac{\epsilon}{\sqrt{5}}, 1)$, is sufficient for the binomial distribution to be $(\epsilon, \delta, 1)$ smooth. This is only true because $\frac{\epsilon}{\sqrt{5}} \geq \frac{e^{\epsilon} - 1}{e^{\epsilon} + 1})$ for all $\epsilon \in [0,1]$

  and since binary sums are 1-incremental and have sensitivity $\Delta=1$, we get $\epsDelta$ privacy for $\alpha = [\frac{\epsilon}{\sqrt{5}}, 1)$. 

	
</div>	

<div class="col-md-6">
#### Sample-Threshold

Now we look at the event $E_2$ that is needed for privacy to hold. From Grahams AI stats submission, lemma 1 defines $E_2$. Lemma 1 states: the probability that the number of samples of an item is more than $\tau$ times its expectation is at most $\delta$, for $\tau = 3 + \log(1/\delta)$. In the world of just binary numbers, these requirements can be restated as the following: 

Given the number of 1's in the population is k. i.e. $\sum_{i=1}^n x_i = k$. Each person $x_i$ has a $p_2$ chance of being sampled. Thus the expected number of 1's in the sampled dataset is $E[\sum_{i=1}^n z_ix_i] = kp_2=\frac{km}{n}$



An element in the set of good events $E_2$ is defined as the sum of sampled population being less than $\tau$ times the expected value of the sum of the sampled population. Let $\alpha = \frac{k}{n}$ the fraction of users that have 1 in the dataset. Clearly, $\alpha \in [0,1]$

$$E_2: = \sum_{i=1}^n z_ix_i \leq \tau kp_2$$ Now we connect this event to the event $E_1$ in shuffle privacy.

\begin{align*}
\sum_{i=1}^n z_ix_i &\leq \tau kp_2 \\
n - \sum_{i=1}^n \bar{z_ix_i} &\leq \tau kp_2 \\
n - (2n - \sum_{i=1}^n x_i - \sum_{i=1}^n z_i) &\leq \tau kp_2 \\
\sum_{i=1}^n z_i &\leq \tau kp_2 + (n - \sum_{i=1}^n x_i) \\
\sum_{i=1}^n z_i &\leq \tau kp_2 + (n - k) \\
\sum_{i=1}^n z_i &\leq \tau \frac{k}{n} np_2 + (n - k) \\
\sum_{i=1}^n z_i &\leq \tau \alpha np_2 + (n - k) \\
\end{align*}


$$E_2 := \{ (z_1,  \dots, z_n) | \sum_{i=1}^n z_i \in [0, \tau\alpha np_1 +(n -k)] \}$$

Already $E_2$ looks the one sided version of $E_1$, with the constants slightly different. Let's see if we can maniuplate them further.

<div class="intuition">The one sided vs two sided is not a big deal. It's just the constant in the log factor. What can I do to relate the variables in the two events better?</div>


<div class="question">If I use two sided instead of 1 sided bounds -- does Grahams proof still hold.</div>

</div>	

</div>

## Studying different noise distributions for central privacy.

## IGNORE

We fix . For a given $\epsilon, \delta \in [0,1]$, [shuffle privacy](../ShufflePrivacy/index.html) requires the number of users $n$ to be atleast $\frac{100}{\epsilon^2}\log(2/\delta)$ to ensure the release of binary sums is private. There is no user specified parameter like $m$ here. $n$ users show up with a desire for $\epsDelta$ privacy. If n is above a certain value, then they will get privacy with probability 1 - $\delta$. 

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