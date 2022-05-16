# Our Data Ourselves
Notes for Our Data Ourselves by Dwork et al

**Authors:** #CynthiaDwork, #KrishnaramKenthapadi #FrankMcSherry #IlyaMironov #MoniNaor

Want to able to generate noise from typical DP distributions in a distributed manner. Questions are :

* How many people must behave so we get it right
* If those people behave, how do we generate say the simplest kind of noise: Binomial. Apprently this is closely related to Damgards paper of converting Arithmetic shares into Binary shares [[Damgard_ArithmethicToBinary]].

To generate noise from a binomial distribution in a distributed manner:

```
Coin flipping in shares (and otherwise) is well studied, and can be achieved by having each participant non-malleably verifiably share out a value in GF(2), and then locally summing (in GF(2)) the shares from all n secret sharings.
This suggests a conceptually straightforward solution: Generate many coins
in shares, convert the shares from GF(2) to shares of values in a large field GF(q)
(or to shares of integers), and then sum the shares
```

Dwork also assumes the existence of non-malleable verifiable secret sharing. For verifiable secret sharing see notes from the BIU talk [[VerifiableSecretSharing]]. For non malleability, I think she just refers to the Reed-Solomon code version that allows $< \frac{t}{3}$ corruptions. This paper was published before Vipul Kumars [[Non-Malleable codes]] was published and [[SecretSharingNonMalleable]] was also found in the t-split model.

The protocol is described in my main notes.

1) XOR dirty bits with unbiased bits and you get unbiased bits as the outcome. If you want to choose the bias of the bits then you're in bit of trouble. 
2) 

