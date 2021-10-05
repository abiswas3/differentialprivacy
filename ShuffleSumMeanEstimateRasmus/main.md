
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
# Differentially Private Aggregation in the Shuffle Model: Almost Central Accuracy in Almost a Single Message

[Paper being discussed](./paper.pdf) published @ (ICML) 2021

## Problem Statement 

```In this work, we study the problem of summing (aggregating) real numbers or integers
```

We have a population of $N$ people. Each person holds a value $x_i$ in the bounded integers or bounded reals. We want to estimate the sum or the mean privately. Under central privacy, the [laplace mechanism](../Definitions/index.html) if we add laplace noise with scale parameter $\frac{\Delta f}{\epsilon}$ or $O(\frac{1}{\epsilon})$ we get pure differential privacy and pretty good accuracy with respect to the L1 norm. $\Delta f=1$ if the $x_i \in [0,1]$, $\Delta f$ is the maximum value in the finite population set for bounded integers and is the sup of the set of finite bounded reals. 

If we wanted to guarantee privacy under local privacy then we have to incur an error of $\Theta_{\epsilon}(\sqrt{n})$ which means the that the bound is tight. The proof can be found [here]().

So the question the authors of this paper care about is that under the shuffle model (which is thought of a mid way between central and local); how close to the central guarantees can we get?

## Contribution

This problem has been attacked by a few different researchers. They can be divided into single messages and multiple messages. Multi message means each user sends more than their perturbed input. They add more bits to fuzz the output.

* Under the single message communication setting (users cannot set extra material to the shuffler), the smallest absolute error was achieved by [Borja and crew]() in $\tilde{\Theta}(n^{1/6})$. <div class="question">Why is there a $\tilde{\Theta}$</div>

*  The multi-message shuffle protocols exis[t with a near-central accuracy of $O(\frac{1}{\epsilon})$ but the problem is that number of messages grows quite large. Specifically, it must be at least 3 and grows $\frac{\log(1/\delta)}{\log n}$ per user.


**Contribution: Our work shows that near-central accuracy and near-zero communication overhead are possible for real aggregation over sufficiently many users**

## What else is needed to fully understand their work

The main proof depends on 3 other papers. 

* [Discrete Laplace Mechanism or Geometric Mechanism](https://timroughgarden.org/papers/priv.pdf)
	* [A very helpful post](https://mathoverflow.net/questions/213221/what-is-a-two-sided-geometric-distribution)
	* The LPA (Definition 5.2) perturbs query results with noise drawn from the continuous Laplace distribution. When re- turned results are expected to be integers, such mechanism cannot be directly applied. To address this, the authors linked above introduced two privacy mechanisms that ensure pure-differential privacy by perturbing their results with integer noise and truncating noisy values if needed. Their mechanisms work only for queries with sensitivity equal to one
* [Infinite divisibility of Discrete Laplace distributions](http://www.mathcs.emory.edu/aims/pub/goryczka15tdsc.pdf) The idea is simple: You want to get noise to add up to a certain value but you want that noise to be a result of many sums of smaller noise. With Gaussian random variables this is very simple. Since the sum of Gaussian RV is also Gaussian, we can play around mean the mean and variance by just scaling it. It's also possible to do the same with Laplace random variables by describing it as a sum of 
	* Gamma variables
	* Gaussian Variables
	* Laplace variables and 1 beta
It is also possible to do the same for the discrete laplacian distribution described [in](https://timroughgarden.org/papers/priv.pdf) by sampling from:
	* Polya Distribution.

In the next section I re-derive the relevant material for proving the contents of this paper.


* [Near-optimal accuracy with vanishing communication overhead](https://arxiv.org/pdf/2106.04247.pdf)

## Requisite Background Material

### Connection between the laplace mechanism and 2 sided geometric mechanism {#lemma-discreteLaplace}

Consider two random variables: $\Delta$, distributed according to the two-sided geometric distribution; and $\Delta^{'}$, which is drawn from the Laplace distribution and then rounded to the nearest integer. It can be shown that $\P{\Delta=i}{i}{\Z}*\frac{1+\alpha}{2\sqrt{\alpha}}=\P{\Delta^{'}=i}{i}{\Z}$


<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#discreteLaplace">Proof</button>
<div class=collapse id=discreteLaplace>
		TODO
</div>

### Adding noise from the two sided geometric distribution to 1-sensitive query outputs is DP {#lemma-discreteLaplaceDP}


<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#discreteLaplaceDP">Proof</button>
<div class=collapse id=discreteLaplaceDP>
		TODO
</div>


### Infinite divisibility of the Geometric distribution {#lemma-discreteLaplaceDiv}


<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#discreteLaplaceDivProof">Proof</button>
<div class=collapse id=discreteLaplaceDivProof>
	TODO
</div>


</div>