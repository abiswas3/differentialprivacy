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

$\ref{MLE}:$ Where the MLE of $\mathbb{P}[y_i=1]$ is $\frac{\sum_{i=1}^n y_i}{n}$

Thus in expectation the output of the algorithm gives us the Expected value of sum of binary values.

</div>


# References 

<!-- [1]: https://arxiv.org/pdf/2109.13158.pdf "Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message"
1. [Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message](https://arxiv.org/pdf/2109.13158.pdf)

[2]: https://arxiv.org/pdf/1908.11358.pdf  "On the power of multiple anonymous messages"
2. [On the power of multiple anonymous messages](https://arxiv.org/pdf/1908.11358.pdf)
 -->
</div>