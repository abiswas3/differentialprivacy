$\newcommand\Z{\mathbb{Z}}$
$\newcommand\jacobi[2]{(\frac{#1}{#2})}$
Why: I wanted to implement verifiable DP and need these things.

With this I might be able to implement stuff on the ingegers, but I'd like to implement these things on Elliptic curves.


# Probabilistic Primality Tests

For each odd positive integer $n$ define $W(n) \subset \Z_n$  such that 
+ Given $a \in \Z_n$ it can be check in deterministic poly time if $a \in W(n)$
+ If $n$ is prime then $W(n) = \emptyset$
+ If $n$ is composite then $|W(n)| \geq  n/2 $

 If $n$ is composite the elements of $W(n)$ are called composite and the elements of the complement set $L(n)$ are called liars.
 
## Fermat's Test

This test is not truly a probabilistic primality test since it usually fails to distinguish between prime numbers and special composite integers called Carmichael numbers.

#Theorem: Fermat's Little Theorem - If $n$ is prime then for any $a \in \Z_n^{+}$ we have $a^{n-1} = 1 \mod n$

If $a$ fails to pass Fermats test for primality then its called a Fermat witness for compositeness. Otherwise it's called a pseudo prime or a fermat liar to the primality test of $n$. Since it could be a dastardly Carmichael number!

#Theorem $n$ is a carmichael number iff (1) $n$ is not divisible by the square of any prime (2) $p-1$ divides $n-1$ for every prime divisior of $n$ 

As a result one can prove

#Theorem Every carmichael number is a product of 3 distinct primes. 


## Solovay-Strassen
Let $n$ be an odd prime then, $\jacobi{a}{n} = a^{\frac{n-1}{2}} \mod n$

## Miller-Rabin Test
