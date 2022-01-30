<div class="container">

Notes based on Lectures 1-5 of youtube series and chapters of 1-5 of Asymptotia by Spencer.

# Asymptotic Notation

**Why:** Sometimes we encounter really ugly looking functions like $f(n) = 7n^{5/2} + 18n^2\ln^3n$ and this is hard to analyse. However, if we only care about the function for very large values of n, then we can ignore certain terms and focus on the important ones. Then we simpify the important bits into standard forms we can understand. This writeup is about the formal language of simplifying functions to be able to compare them for really large values of their input. As an example, in this world functions like $f(n)= n^2$ and $g(n)= n^2 + n$ are roughly the same and can be treated as such.

<!-- When reading TCS papers I see variants of asymptotic notation and I do not always know what they mean. This lecture by Ryan, gives a summary of the most common asymptotic symbols and what they mean. Also provided are some classic tricks used to manipulate ugly functions into more standard forms for asymptotic analysis.
 -->

## Standard form

Before we analyse how a function behaves for very large values, we want to write them down in simple or standard form. A function $f(n)$ is in standard form if it is the product of:

* Constants such as $6, \sqrt{2\pi}, e$
* Constant powers of $\ln n$ such as $\sqrt{\ln n}, \left(\ln n \right)^{-1}$
* Constant powers of $n$ such as $n^{\frac{3}{5}, n^2, n^{-5}}$
* Exponentials such as $e^{-n}, 2^n$
* n^{cn} for constant $c$

Example, Stirlings formula $n^n e^{-n}\sqrt{2\pi n}$ is a complex looking thing in standard form.

## Complete list of Bachmann-Landau notations

* Big O(micron): $\mathcal{O}$ or $O$
* Big Omega: $\Omega$
* Big ThetaL $\Theta$
* Small O(micron): $\omega$
* On the order of: $f \sim g$
* Lazy Big O: $\widetilde{O}$
* Lazy Big Omega: $\widetilde{\Omega}$

### Hierarchy of Asymptotics

### Inverting Functions

### Taylors Series


</div>