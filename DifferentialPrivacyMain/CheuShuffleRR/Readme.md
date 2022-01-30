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
\newcommand{\H}{\mathcal{H}}


<div class="container">

# Distributed Differential Privacy via Shuffling

Year published: 2018 Conference: 

<u>*Why:*</u> Each member of the dataset $x \in D$ holds a value in $\{0, 1\}$. We simply want to estimate $f(X) = \sum_{i=1}^n x_i$. Let $\hat{f}(X)$ be the estimated sum by the algorithm. This is the simplest version of multiplicative noise. If we assume that the population is not too sparse, then it is almost identical to sample and threshold with Poisson sampling. The difference being in randomised response when we see tails we send a 1 or 0 with probability 1/2. Sample and threshold privacy sends 0 deterministically on seeing tails.

## Main Results

1. For every $\epsilon \in (0, 1)$, and every $\delta > 2^{−\epsilon n}$ and every function $f : X \rightarrow \{0, 1\}$, there is a protocol $P$ in the shuffled model that is $\epsDelta$-differentially private, and for every $n$ and every $X = (x_1,...,x_n) \in \mathcal{X}^n$,

\begin{align}
\E\Bigg[ \Big|P(X) - \sum_{i=1}^n f(x_i)\Big|\Bigg] &= O\Bigg( \frac{1}{\epsilon}\sqrt{\ln \frac{1}{\delta}}\Bigg)
\end{align}

**Each user sends a single one-bit message.**

<div class="important">
This is saying that for binary sums, if I did randomised response then I find a protocol such that my shuffle privacy estimate will be within a constant of the actual sum.

The protocol I find is simply randomised response. Remember upper bound don't need for all algorithms, just one you devise.
</div>
<br>

2. For every $\epsilon \in (0, 1)$, and every $\delta > \epsilon n 2^{−\epsilon n}$ and every function $f : X \rightarrow [0, 1]$, there is a protocol $P$ in the shuffled model that is $\epsDelta$-differentially private, and for every $n$ and every $X = (x_1,...,x_n) \in \mathcal{X}^n$,

\begin{align}
\E\Bigg[ \Big|P(X) - \sum_{i=1}^n f(x_i)\Big|\Bigg] &= O\Bigg( \frac{1}{\epsilon}\ln \frac{n}{\delta}\Bigg)
\end{align}

**Each user sends  $\Theta(\epsilon\sqrt{n})$ messages.**

Later work by the same authors handles the case when the upper bound on the numbers is much higher.

<div class="theorem">

</div>

## Binary Sums 

Below we describe the classic randomised response algorithm 

<div class="algorithm">
**Local Randomiser:** 
Inputs: $x_i \in \{ 0, 1\}$, $\lambda \in \{ 1, \dots, n-1\}$

Let $p=\frac{\lambda}{n}$, each user tosses a coin with probability of heads being $p$ 

* If heads: $y_i = Bernoulli(1/2)$
* If tails: $y_i = x_i$

return $y_i$

**Analyser:**
Inputs: $Y=\{ y_1, \dots, y_n \}$, $\lambda$ from local randomiser

Output: $\frac{n}{n - \lambda}\Big(\sum_{i=1}^n y_i - \frac{\lambda}{2}\Big)$

</div>

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#rrUnbiased">The above estimator is an unbiased estimator of $\sum_{i=1}^n x_i$</button>
<div class=collapse id=rrUnbiased>

\begin{align*}
\mathbb{P}[y_i=1] &= (1-p)\mathbb{P}[x_i=1] + \frac{p}{2} \\
\mathbb{P}[x_i=1] &= \frac{\mathbb{P}[y_i=1] - \frac{p}{2}}{1-p} \\
\frac{\sum_{i=1}^n x_i}{n} &= \frac{\frac{\sum_{i=1}^n y_i}{n} - p\frac{1}{2}}{1-p} \tag{1}\label{MLE}\\
\sum_{i=1}^n x_i &= \frac{n}{n - \lambda}\Big(\sum_{i=1}^n y_i - \frac{\lambda}{2}\Big)
\end{align*}

$\ref{MLE}:$ Whre the MLE of $\mathbb{P}[y_i=1]$ is $\frac{\sum_{i=1}^n y_i}{n}$

Thus in expectation the output of the algorithm gives us the Expected value of sum of binary values.

</div>

### An alternate way to describe the above algorithm 

An equivalent version of the local algorithm can be described by the following algorithm. **Assume each person has been made anonymous, so we can use shuffle privacy and central privacy synonymously** In this section we compare the Cheu algorithm to Sample and threshold by Graham. Throughout this paper, we derive the missing pieces for Sample and threshold analysis.

<div class="algorithm">

**Analyser**
Inputs: $Y=\{ x_1, \dots, x_n \}$, Same $\lambda$ from local randomiser

Let $p=\frac{\lambda}{n}$

$s \leftarrow Binomial(n, p)$

Define $\H_s = \{ H \subseteq \floor{n} | |H| = s\}$

In words $\H_s$ is a set of sets. Each set inside $\H_s$ is a way to select $s$ elements from $\floor{n}$. There are ${n \choose s}$ ways of doing this.

Select $H \sim Uniform(\H_S)$

<div class="intuition"> $H$ represents a set obtained by Poisson sampling with parameter $p$, where Poisson sampling is described how Graham describes it in his Sample and Threshold paper.
</div>

Final output:  $\sum_{i \notin H}y_i + Bin(s, \frac{1}{2})$

<div class="intuition"> In the sample and threshold regime the final output is. 

Final output:  $\sum_{i \notin H}y_i + \sum_{i \notin H} 0$

We get exactly forced randomised response [see first example of wikipedia page](https://en.wikipedia.org/wiki/Randomized_response)

$\sum_{i \notin H}y_i + \sum_{i \notin H} 1$

</div>


</div>


# References 

<!-- [1]: https://arxiv.org/pdf/2109.13158.pdf "Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message"
1. [Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message](https://arxiv.org/pdf/2109.13158.pdf)

[2]: https://arxiv.org/pdf/1908.11358.pdf  "On the power of multiple anonymous messages"
2. [On the power of multiple anonymous messages](https://arxiv.org/pdf/1908.11358.pdf)
 -->
</div>