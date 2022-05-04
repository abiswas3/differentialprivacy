$\newcommand{\G}{\mathbb{G}}$
$\newcommand{\A}{\mathcal{A}}$
$\newcommand{\P}[1]{\mathbb{P}[#1]}$
# Random Self Reducibility of Discrete logarithms
Source: Dan Boneh And Victor Shoup

An important property of the discrete-log function in a group $\G$ is that it is either hard almost everywhere in $\G$ or easy everywhere in $\G$. A middle ground where discrete-log is easy for some inputs and hard for others is not possible.

Suppose there is an efficient algorithm that $\A$ can solve the DL problem given $u \xleftarrow{R} \G$, then $\P{\A(u) = D\log(u)} = \epsilon$

Here, the probability is over the random choice of $u$, as well as any random choices made by $\A$ itself.


Suppose $\epsilon = 0.1$. Then the group $\G$ is of little use in cryptography since an eavesdropper can use $\A$ to break 10% of all Diffie-Hellman key exchanges. However, this does not mean that A is able to compute $D\log_g(u)$ with non-zero probability for all $u \in G$. It could be the case that for 10% of the inputs $u \in G$, algorithm A always computes $D\log_g(u)$, while for the remaining 90%, it never computes $D\log_g(u)$ => The left hand side of the figure below. 

![[Screenshot 2022-05-04 at 12.36.58.png]]

We show that it if that happens, then it should be easy to solve discrete log for all values in $\G$.

We show how to convert $\A$ into an efficient algorithm $B$ with the following property: for all $u \in G$, algorithm $B$ on input $u$ successfully computes $D\log_g(u)$ with probability $\epsilon$. Here, the probability is only over the random choices made by $B$. We do so using a reduction that maps **a given discrete-log instance** to **a random discrete-log instance**. Such a reduction is called a random self reduction.
