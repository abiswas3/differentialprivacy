<div class="container"> 

**Some notation**: $F$ is always a finite field $\mathbb{Z}_p$ where $p$ is a very very large prime. $\mathbb{G}$ is always some abelian  group.

# Function Secret Sharing 

## Notation and prelims

## Distributed Point Functions

<div class="lemma">
<h4>Definition</h4>
Point function $f_{\alpha,\beta}$ for $\alpha \in \{0, 1\}^n$ and $\beta \in \mathbb{G}$,is defined to be the function $f : \{0,1 \}^n \rightarrow \mathbb{G}$ such that $f(\alpha)=\beta$ and $f(x) = 0$ for $x \neq \alpha$. We will sometimes refer to a point function with $|\beta| = 1$ (resp., $|\beta| > 1$) as a single-bit (resp., multi-bit) point function. A Distributed Point Function (DPF) is an FSS for the family of all point functions, with the leakage $Leak(\hat{f}) = (1^n,\mathbb{G})$.
</div>
<br>

The above statement is a formal way of describing the following pictures:

<img src="./pngs/point_functions.jpg" width=95%></img>

A distributed point function describes the following idea (note almost always the $Eval$ will be additive. Though we only require that it be linear - So shamirs secret sharing also works instead of additive secret sharing.)



## Latest Formulation for General DPF 

The figure below taken from this [talk](https://www.youtube.com/watch?v=Zm-MUVve2_w) by [Elette Boyle](https://scholar.google.com/citations?user=tLjnqu0AAAAJ&hl=en), describes the related work in building efficient protocols for DPF's. 

<img src="./pngs/history.png" width=75%></img>

We describe the latest formulation in this section -- the full description can be found in section 3.2 of this [paper](https://dl.acm.org/doi/10.1145/2976749.2978429). In this protocol, we $F= \mathbb{Z}_2$, so the $+$ operation can be interpreted as the $XOR$ operation.

Assume we have access to a length doubling PRNG as described below. They key generation process is as follows:

1. The client samples $s_0$ and $s_1$ uniformly at random from $\{ 0, 1\}^{\lambda}$, where $\lambda$ is the security parameter. It sends $s_0$ to server 0 and $s_1$ to server 1. Additionally it sends $t_0 \sim \{0,1\}$ to server 0 and $t_1 = t_0 + 1$ to server 1.

2. It also sends each server a correction word $CW_{0}$. The clients follow the protocol described in the picture above.

## Incremental DPF

## Extractable DPF

# References 
</div>


</div>
