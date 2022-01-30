
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
\newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}

<div class="container">

# Distributed Population mean estimation

Not to be confused with mean estimation of a statistical distribution. Those papers are similar but the end goal is different and so are the guarantees.

## Summary of the state of affairs

$N$ users have values $x_i \in \{0,1\}$, where $i=\{1, 2, \dots, N\}$ For now we focus on binary values, later we will extend to integers. The goal is to approximate the the mean/sum of the population privately, without each user sending their values to some central aggregator. The problem was first considered by [[5][5]]. They stated it as -- ```What can we say about central DP guarantees of a protocol that satisfies```$\epsilon$-local DP? Since then, there have been two approaches to this problem -- additive noise mechanism (think laplace) and sampling based mechanisms (randomised response). 

This makes sense as we are looking at local privacy from a central perspective. So we considered the most basic central model and moved it to the a local setting or considered the most basic local model and moved it to understand a central setting.

<img src="./pngs/mechanisms.jpeg" width="80%"></img>

The noise distributions for additive mechanisms tend to be infinitely divisible distributions. This allows us to locally perturb the private values while still doing the analysis from a central perspective. The table below summarises the important contributions to the problem of population mean estimation.

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-1wig{font-weight:bold;text-align:left;vertical-align:top}
.tg .tg-0lax{text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0lax"></th>
    <th class="tg-1wig">Contribution</th>
    <th class="tg-1wig">Venue</th>
    <th class="tg-1wig">Authors</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Any permutation invariant algorithm satisfying $\epsilon$-local differential privacy will satisfy $(O(\frac{\epsilon}{\sqrt{n}}\sqrt{log1/δ}), δ)$-central differential privacy. Or more simply by using lazy notation, $\epsilon = O_{\epsilon, \delta}(\frac{1}{\sqrt{n}})$</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Thirtieth Annual ACM-SIAM Symposium on Discrete Algorithms (2019)</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Erlingsson, Ulfar and Feldman, Vitaly and Mironov, Ilya and Raghunathan, Ananth and Talwar, Kunal and Thakurta, Abhradeep</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"> 
* Amplification bound generalizes the results by Erlingsson et al. to a wider range of parameters, and provides a whole family of methods to analyze privacy amplification in the shuffle model. 

* A new lower bound for the accuracy of private protocols for summation of real numbers in the shuffle model. There are lot of fancy constants but the asymptotic complexity for the lower bound is still $O_{\epsilon, \delta}(\frac{1}{\sqrt{n}})$, which 

*  Provide an optimal single message protocol for summation of real numbers in the shuffle model. This is based on randomised response as well
    </td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Annual International Cryptology Conference (2019)</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Balle, Borja and Bell, James and Gasc{\'o}n, Adria and Nissim, Kobbi</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Distributed mean estimation using randomised response- more of the same of the above two really. This analysis was for integers and binary values. The above paper is an improvement on this</td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Annual International Conference on the Theory and Applications of Cryptographic Techniques (2019)</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Cheu, Albert and Smith, Adam and Ullman, Jonathan and Zeber, David and Zhilyaev, Maxim</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Distributed mean estimation using binomial noise </td>
    <td class="tg-0lax"><span style="font-style:normal">Information-Theoretic Cryptography, </span><br><span style="font-style:normal">ITC 2020</span></td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Balcer, Victor and Cheu, Alber</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Distributed mean estimation using correlated noise - binary population<br></td>
    <td class="tg-0lax">ICML 2020</td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">B Ghazi, R Kumar, P Manurangsi, R Pagh</span></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax">Distributed mean estimation using correlated noise - integer valued population. </td>
    <td class="tg-0lax">ICML 2021</td>
    <td class="tg-0lax"><span style="font-weight:400;font-style:normal">Badih Ghazi, Noah Zeger Golowich, Shanmugasundaram Ravikumar, Pasin Manurangsi, Ameya Avinash Velingker, Rasmus Pagh</span></td>
  </tr>
</tbody>
</table>

Not mentioned in above table but of relevance in Sample and Threshold mechanism proposed by Graham.

## Questions

#### These questions were posed on 21-08-2021

```
I had in mind the algorithm that outputs the mean of the sampled items, without censoring.  However, I think some bounds need to be placed on the size of the items being reported.  Otherwise, we have the 'billionaire's problem': looking at the mean reveals whether or not there was a billioniaire in the sample, which in turn reveals whether or not they were in the input.
```

This was posed initially when we were discussing the sample and threshold problem. The question was, whether there was a way to use this mechanism to report sums and means of populations instead of reporting succint histograms of the population. I was able to show that reporting the sum of the histogram/mean is DP but this is not very satisfying, as by creating a histogram we have created buckets and brought in rounding error. <div class="intuition">**TODO: ** How did Ghazi et al 2021 ICML paper get around this problem for non binary valued integers? I cannot remember at the top of my head </div>

#### These questions were posed on 23-11-2021.

```
Among all these options, are there any strict dominances, i.e., is there any method that has an asymptotically better guarantee than another across all epsilon and n choices?  I think probably not, but not sure yet.
``` 

```
Otherwise, how best can we compare these?  Maybe plotting the shape of the distributions for a few different settings will help to compare them better. 
```

```
Can we characterize which parameter regimes work best for each method (dense/sparse data, high/low populations size, epsilon value etc.)?
```

<button type="button" 
class="btn btn-info" 
data-toggle="collapse" 
data-target="#comparingAlgs">How to compare additive mechanisms with multiplicative mechanisms - new conjectures</button>
<div class=collapse id=comparingAlgs>

**Last update: 30-01-2022**

All these methods work by flipping a coin with probability of heads $p$, $n$ times. The exact value of $p$ is given by $\epsDelta$. Let's ignore $\epsDelta$ and fix $p$ and see how they compare. We expect additive noise mechanisms to have best accuracy, followed by sampling and randomised response to have the worst accuracy. Intuition provided below:

#### Inutuition as to why

Consider a single person $x_i \in \{0, 1\}$. They have a local randomiser $L \in \{\text{Add}, \text{Sample}, \text{RR}\}$. They perturb their input with each local randomiser and send their output to 3 different analysers $A_{\text{Add}}, A_{\text{Sample}}$ and $A_{\text{RR}}$. Let $y_i = L(x_i)$, the value after perturbation.

<u> Consider $A_{\text{Add}}$ </u>.

If the analyser sees a $2$ or a $0$. They know for sure that $x_i$ was $1$ or $0$ respectively. Only when $y_i = 1$ is when the anlyser has to reconstruct the true input value. 

<u> Consider $A_{\text{Sample}}$ </u>.

If the analyser sees a $1$. They know for sure that $x_i$ was $1$. If they see a $y_i=0$, they must re-construct the input.

<u> Consider $A_{\text{RR}}$</u>

The analyser never knows $x_i$ with certainty for any value of $y_i$. This is the most private thereby the Analyser has to reconstruct $x_i$ all the time. Note this agrees with all the results cited above. In the separating local and shuffle privacy paper [[6][6]], the authors show that additive noise outperforms their previous randomised response model.

#### A little experiment to verify this conjecture

Before trying to formally develop theory for this intuition, we ran some experiments to verify if our conjecture was true. 

Let $n$ be the number of users. Let $k=\sum_{i=1}^n x_i$, the number of users that voted yes.
Define error as $|k - f(X)|$ where $f(X)$ is the estimated number of yes votes by the algorithm. Ignore $\epsDelta$ for now and just focus on a fixed $p$.

<embed type="text/html" src="./comparison.html" width="800" height="600"> 


We find that Randomised Response is always worse than the other methods, but as expected Additive noise works better when the data is sparse i.e. fraction of people that say yes is low. Sampling on the other hand does better when this fraction is higher. Too see why, refer to the document below where we derive the variance of the sampling estimator. 


</div>






```
Are there any approaches that are analytically or empirically the same (we tried to argue that binomial noise addition was equivalent to sampling, but this dod not go through). 
```
This is still unresolved but I have a new idea using arithmetic circuits, that I would like to discuss
<br>

```
Can we make single proof of a general result that holds for distributions with some property, and then specialize it for each of these different approaches?  Or is that already done in the prior work?
``` 
The paper power of multiple anonymous messages does this for all additive methods. They define smooth distributions or distributions with a certain hockey stick divergence. Then they show that the central additive mehcanism is good for all such distributions. For the distributed case, if your distribution is infinitely divisible, you win. If we can connect multiplicative noise distributions to these distributions it would give us a general proof under their framework. We can also try to come up with something new.
<br>

#### These questions were posed on 07-12-2021

I had sent a pdf writing out explicitly the variance and mean of the sampling estimator based on binomial coefficients.

```
Ari: Assuming communication complexity is not an issue and we can talk to all n people, then when n is large, additive noise mechanisms 
usually always win. This makes sense to me, I’ve added my reasoning in the writeup.

Graham: For the paper, we were able to show DP by considering the explicit calculation for cases differing by 1, but I wonder if there is a
more general way to show this.
```

```
Ari: When n is medium sized, additive mechanism do not give privacy but sampling and thresholding does. It is because only a very small p 
is required to keep the variance of the estimator small.

Graham: There's a bigger communication aspect that I only focused on recently: for the histogram problem, it should be possible for the 
sampling approach to send only a constant amount of information per client. Other noise-addition approches require much more communication, 
proportional to the size of the histogram per client.  This can be a big difference.
```

```
Ari: If communication complexity matters (and you discuss this in the paper); you can still sample using m + O(sqrt(m)) people which is 
much lesser than n. So this method is once again useful. Though the error does not shrink as fast.
I can see why the connection between additive noise and sampling is so tempting; particularly if there was a connection then we
 could reduce communication complexity by  m + O(sqrt(m)).

Graham: This is an intersting niche.
```

```
Additional remarks:
Thanks for the notes.  The calculations look correct, based on binonial distribution.  I expect there is some nice statistical tricks to manipulate the pmf further.  Do you think there is any chance for a closed form for the variance, or is it best to leave it to numerical evaluation?

Reducing the communication in this way is essentially being able to suppress messages in the noise setting, i.e., having noise that leads us to output zero most of the time.  This may not be possible without effectively including sampling in the method, and incurring the corresponding error from sampling.
```

## References and Links exchanged

[1]: ../DiscreteLaplace/paper.pdf "UNIVERSALLY UTILITY-MAXIMIZING PRIVACY MECHANISMS"
1. [UNIVERSALLY UTILITY-MAXIMIZING PRIVACY MECHANISMS](../DiscreteLaplace/paper.pdf)

[2]: https://arxiv.org/pdf/1903.02837.pdf "The privacy blanket of the shuffle model"
2. [The privacy blanket of the shuffle model](https://arxiv.org/pdf/1903.02837.pdf)

[3]: https://arxiv.org/pdf/1103.2626.pdf "Distributed Private Data Analysis: On Simultaneously Solving How and What"
3. [Distributed Private Data Analysis: On Simultaneously Solving How and What](https://arxiv.org/pdf/1103.2626.pdf)

[4]: https://mathoverflow.net/questions/213221/what-is-a-two-sided-geometric-distribution "Distinction between one sided and 2 sided Geometric distributions"
4. [Distinction between one sided and 2 sided Geometric distributions](https://mathoverflow.net/questions/213221/what-is-a-two-sided-geometric-distribution)

[5]: https://arxiv.org/pdf/1811.12469.pdf "Amplification by Shuffling:
From Local to Central Differential Privacy via Anonymity"
[Amplification by Shuffling: From Local to Central Differential Privacy via Anonymity](https://arxiv.org/pdf/1811.12469.pdf "Amplification by Shuffling:)

[6]: https://privacytools.seas.harvard.edu/publications/separating-local-shuffled-differential-privacy-histograms "Seperating Local and Shuffle privacy via histograms"
[Seperating Local and Shuffle privacy via histograms](https://privacytools.seas.harvard.edu/publications/separating-local-shuffled-differential-privacy-histograms)

## Links

Streaming paper including voting:
https://arxiv.org/abs/1603.00213

Local differential privacy for voting/ranking
https://arxiv.org/pdf/1908.04920.pdf
(there may be some follow up)

Your notes on privacy:
https://abiswas3.github.io/differentialprivacy/

Bonus:
Mean estimation with low communication:
https://arxiv.org/abs/2010.02331
(privacy follows by applying randomized response to the bit that is sent)

</div>
