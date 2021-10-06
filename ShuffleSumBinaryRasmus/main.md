
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
# Private Counting from Anonymous Messages: Near-Optimal Accuracy with Vanishing Communication Overhead

[Paper being discussed](./binarySums.pdf) published @ FORC Foundations of Responsible Computing
 2020

## Problem Statement 

```In this work, we study the problem of summing (aggregating) binary numbers.
```

The following screenshot is taken from the [official talk](https://www.youtube.com/watch?v=wkF_uBo-bLo) by one of the authors and provides an overview of shuffle privacy.
<img src="pngs/overview.png" height="300px" width="600px"></img>


## Contribution

For the simple problem of binary sum estimation, if I want to send 1 message per user only then the accuracy bounds by given by [[2][2]] and [[1][1]] are tight. You cannot do better! This paper proves a lower bound. If there is wiggle room on the number of messages I can send then the accuracy of the central case is achievable. They improve the bounds on the number of messages by making it disappear as $n$ goes to infinity.

<img src="pngs/related_work.png" height="300px" width="600px"></img>

## References 

[1]: https://arxiv.org/abs/1808.01394 "Distributed differential privacy via shuffling"
[2]: https://arxiv.org/pdf/1903.02837.pdf "The privacy blanket of the shuffle model"

</div>