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

# Distributed Differential Privacy via Shuffling*


## Binary Sums 

Each member of the dataset $x \in D$ holds a value in $\{0, 1\}$. We simply want to estimate $f(X) = \sum_{i=1}^n x_i$. Let $\hat{f}(X)$ be the estimated sum by the algorithm. Understanding the guarantees of this algorithm will provide a lot of insight into the Sample and threshold algorithm that Graham has. **I am fairly certain I can show the equivalence**. In this writeup I re-derive the work done by [[1][1]]. In a later post I show the connection with Grahams paper.

The algorithm used to estimate the binary sums is a modified version of randomised response (RR). My survey on RR can be found [here](../RRSurvey/). We describe the algorithm again:

<div class="algorithm">

**Local Randomiser:** 
Inputs: $x_i \in \{ 0, 1\}$, $\lambda \in \{ 1, \dots, n-1\}$

Let $p=\frac{\lambda}{n}$
Each user tosses a coin with probability of heads being $p$ 

If heads:  $y_i = Bernoulli(1/2)$
<div class="intuition"> In the variant of Randomised Response known as Forced Randomised Response: we always output 1. Say we always output 0 instead. The maths doesnt really change. But it will help us connect two different algorithms.
</div>
If tails: $y_i = x_i$

return y_i

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