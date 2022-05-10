# Non Interactive Verifiable Secret Sharing
#PedersenCommitments
[Source](https://link.springer.com/content/pdf/10.1007/3-540-46766-1_9.pdf)

I think Pedersen's commitments should give me everything I need. 

## Secret Sharing Defintion

## Verifiable Secret Sharing Defintion
A Verifiable Secret Sharing protocol takes place between the dealer $D$ and parties $P_1, \dots, P_K$ such that the following two holds:

+ $P_i$ accepts => (dealer followed the distribution protocol ) and (dealer and $P_i$ followed the interaction)
+ If S_1 and S_2 both reconstruct a secret, then $\mathbb{P}[s_1 \neq s_2]$ is negligible. 

[Proof of security](https://crypto.stanford.edu/cs355/20sp/lec3.pdf)


