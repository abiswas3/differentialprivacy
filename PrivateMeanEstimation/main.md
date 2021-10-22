
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


<div class="container">
# Private Mean Estimation -- A survey

Papers being sumarised:

* [Laplace]()
* [Graham survey]()
* [Cheu I]()
* [Gazi I]()
* [Gazi II]()

## Problem Statement 

```N users have values in the bounded reals or bounded integers or binary numbers. We want to calculate the mean/sum of these numbers privately. What have people done so far towards this problem. What assumptions have people made to make this problem morre private or more accurate.
```

The table below provides an overview of the understanding of the summing problem we have today. There are three modes of privacy - central, local and a hybrid of the two known as shuffle. Each paradigm has a slighlty different definition of differential privacy. The list of definitions is [provided here](../Definitions/)

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-lt5t{background-color:#ecf4ff;border-color:inherit;color:#333333;text-align:left;vertical-align:top}
.tg .tg-hf8k{background-color:#ecf4ff;color:#333333;text-align:left;vertical-align:top}
.tg .tg-item{background-color:#00d2cb;border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-ltxa{background-color:#ffccc9;text-align:left;vertical-align:top}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-0lax{text-align:left;vertical-align:top}
.tg .tg-fymr{border-color:inherit;font-weight:bold;text-align:left;vertical-align:top}
.tg .tg-90e1{background-color:#ffccc9;border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-0khl{background-color:#00d2cb;text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky"></th>
    <th class="tg-0lax"></th>
    <th class="tg-fymr">Upper Bound</th>
    <th class="tg-fymr">Number of messages per user</th>
    <th class="tg-0pky"></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-lt5t">Central</td>
    <td class="tg-hf8k"></td>
    <td class="tg-lt5t">[$O(\frac{1}{\epsilon})$](../Definitions/)</td>
    <td class="tg-lt5t"><span style="font-weight:400;font-style:normal">1</span></td>
    <td class="tg-lt5t"></td>
  </tr>
  <tr>
    <td class="tg-90e1">Local </td>
    <td class="tg-ltxa"></td>
    <td class="tg-90e1"><a href="https://arxiv.org/pdf/1103.2626.pdf" target="_blank" rel="noopener noreferrer"><span style="color:#905">[$O(\frac{1}{\sqrt{n}})$](https://arxiv.org/pdf/1103.2626.pdf)</span></a><br></td>
    <td class="tg-90e1">1</td>
    <td class="tg-90e1"></td>
  </tr>
  <tr>
    <td class="tg-item">Shuffle</td>
    <td class="tg-0khl">Privacy Blanket - Borja</td>
    <td class="tg-item"><span style="font-weight:400;font-style:normal">$O(\frac{1}{\epsilon})$</span></td>
    <td class="tg-item">$O_{\epsilon}\Big( \log\frac{n}{\delta}\Big)$</td>
    <td class="tg-item"></td>
  </tr>
  <tr>
    <td class="tg-0khl"></td>
    <td class="tg-0khl"><span style="font-weight:400;font-style:normal">Vanishing complexity - Ghazi,</span><br><span style="font-weight:400;font-style:normal">(for binary sums)</span><br></td>
    <td class="tg-0khl"><span style="font-weight:400;font-style:normal">$O(\frac{1}{\epsilon})$</span></td>
    <td class="tg-0khl"><span style="font-weight:400;font-style:normal">$O_{\epsilon}\Big( \frac{\log^2\frac{1}{\delta}}{n}\Big)$</span></td>
    <td class="tg-0khl"></td>
  </tr>
  <tr>
    <td class="tg-0khl"></td>
    <td class="tg-0khl"><span style="font-weight:400;font-style:normal">Vanishing complexity - Ghazi,</span><br><span style="font-weight:400;font-style:normal">(for binary sums)</span></td>
    <td class="tg-0khl">$\Omega\Big( \sqrt{\log \frac{1}{\delta}}\Big)$</td>
    <td class="tg-0khl">1</td>
    <td class="tg-0khl"></td>
  </tr>
  <tr>
    <td class="tg-0khl"></td>
    <td class="tg-0khl">Almost Central </td>
    <td class="tg-0khl"></td>
    <td class="tg-0khl"></td>
    <td class="tg-0khl"></td>
  </tr>
</tbody>
</table>>

## Central Privacy

### For real numbers

We incur a probability 

### For integers

Since the input values are integers or binary numbers, we cannot use noise from the continuous laplace distribution. Instead we use its discrete counter part - the two sided geometric distribution or the discrete laplace distribution. [[1][1]] showed that this mechanism was optimum i.e. the error of this mechanism is a lower bound for central differential privacy. We cannot do better.

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

</div>

Thus $\hat{f}$ is an unbiased estimator of the sum of inputs, and since $\hat{f}$ is a sum of bernoulli random variables, it means we can directly apply the [hoefdinng bound for Bernoulli's in Example 1](http://www.stat.cmu.edu/~arinaldo/Teaching/36709/S19/Scribed_Lectures/Jan29_Tudor.pdf) which states

$$ \mathbb{P}\Big[ |\hat{f} - \mathbb{E}(\hat{f})| \geq t \Big] \leq 2e^{-2nt^2}$$

To pull out an error bound set $\delta = 2e^{-2nt^2}$ and solve for t. Thus we get with probability $1 - \delta$, $|\hat{f} - \mathbb{E}(\hat{f})| \leq t$ and $t=\sqrt{\frac{1}{2n}\log\frac{1}{\delta}}$. Thus we can finally say that with probability $1 - \delta$

$$|\hat{f} - \mathbb{E}(\hat{f})| \leq O(\frac{1}{\sqrt{N}})$$

An alternate way to derive this bound is to look at the variance of the estimator $\hat{f}$ and since the estimator is unbiased, the variance of the estimator is equal to the mean squared error of the estimator. It gives a point estimate of an error not a confidence interval. The derivation can be found [here](http://www.gautamkamath.com/CS860notes/lec3.pdf). It is relatively straightforward.

#### Lower Bound

[[3][3]] Gives us a proof that shows that the simple algorithm above that was invented in 1965 is actually the best you can do. It states that the upper bound is tight -- that indeed $O(\frac{1}{\sqrt{N}})$ is the least error we must tolerate to ensure privacy. <div class="question"> The proof for this lower bound is quite convoluted. The authors prove the lower bound for any distributed t-coalition network, for interactive and non interactive protocols for sums. I try and simplify their proof for non interactive local privacy only. In doing so, I do my best attempt at simplifying their proof, building intuition and re-deriving it.</div> What a lower bound statement is saying is that -- if we wanted to $\epsilon$ local privacy and compute the mean of binary numbers, **all** private algorithms will error at least by $O(\frac{1}{\sqrt{N}})$ with non zero probability and non vanishing probability (the probability does not shrink as number of users go up.)


<button type="button" class="btn btn-info" data-toggle="collapse"
data-target="#lowerBoundLocalMean">Lower bound for binary mean estimation
</button>
<div class=collapse id=lowerBoundLocalMean>

The proof is divided into 2 parts: 

1. They first define a gap version of the threshold function, denoted GAP-TR, and observe that any differentially private protocol for SUM with error $\tau$ implies a differentially-private protocol for GAP-TR with gap $\frac{\tau}{2}$.

2. The contrapositive of the above fact, is used to show that it is impossible to compute GAP-TR with a gap smaller than $O(\sqrt{n})$ in a differentially private manner. Therefore, it is impossible to compute SUM in a differentially private manner without suffering an error of at least $O(\sqrt{n})$.

Most of the work in the paper is done to prove the second bit.

**$GAP-TR_{\kappa, \tau}$** Gap threshold functions are defined as the following: If $SUM(X_1, \dots, X_n) \leq \kappa$, then $GAP-TR_{\kappa, \tau} = 0$ and If $SUM(X_1, \dots, X_n) \geq \kappa + \tau$, then $GAP-TR_{\kappa, \tau} = 1$ . The function is undefined when $\kappa < SUM(X_1, \dots, X_n) < \kappa + \tau$.

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

What about algorithms that mostly say 1. We now show those algorithms will also make an error with constant probability because they output zero vector inputs as 1 with constant probability. To be able to show this, we need to use some lemmas which have to do with the privacy requirements. **NOTE: ** so far we have only used Chernoff-Hoeffding bounds -- nothing about the privacy of algorithms have been utilised.** The proof for the lemmas is provided below the main proof.

Case II: $\mathbb{P}[D] \geq p$
</div>

## Shuffle Privacy

The following screenshot is taken from the [official talk](https://www.youtube.com/watch?v=wkF_uBo-bLo) by one of the authors and provides an overview of shuffle privacy.

<img src="../ShuffleSumBinaryRasmus/pngs/overview.png" height="300px" width="600px"></img>


#### Borja 2020- Private Summation in the Multi-Message Shuffle Model


An interesting feature of the shuffle model is that increasing the amount of
messages sent by each user can lead to protocols with accuracies comparable to the ones
achievable in the central model. In particular, for the problem of privately computing
the sum of n bounded real values held by n different users

## References 

[1]: ../DiscreteLaplace/paper.pdf "UNIVERSALLY UTILITY-MAXIMIZING PRIVACY MECHANISMS"
1. [UNIVERSALLY UTILITY-MAXIMIZING PRIVACY MECHANISMS](../DiscreteLaplace/paper.pdf)

[2]: https://arxiv.org/pdf/1903.02837.pdf "The privacy blanket of the shuffle model"
2. [The privacy blanket of the shuffle model](https://arxiv.org/pdf/1903.02837.pdf)

[3]: https://arxiv.org/pdf/1103.2626.pdf "Distributed Private Data Analysis: On Simultaneously Solving How and What"
3. [Distributed Private Data Analysis: On Simultaneously Solving How and What](https://arxiv.org/pdf/1103.2626.pdf)
</div>