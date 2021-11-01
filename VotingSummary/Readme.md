<div class="container">
# Election Methods

A review of rank aggregation methods with code. Consider the following problem where 8 voters have voted for 5 candidates - A, B, C, D and E. Shown below is the code for computing Kemeny optimal ranking, borda rank and Kwik Sort ranks for such a problem in a non private setting.

## Kemeny–Young method

The Kemeny optimal ranking is a desirable aggregate ranking because it places first the [Condorcet winner](https://en.wikipedia.org/wiki/Condorcet_method). Assume we have a set of candidates $A$. A vote on the candidate set comprises of a ordering of the candidates in $A$. Say we had $n$ such votes := $\tau = (\tau_1, \tau_2, \dots, \tau_n)$. Let the final ranking of the candidates in $A$ be $\sigma$. The badness of a ranking is the average kendal tau distance between $\sigma$ and members of $\tau$. The ranking with the smallest badness is the kemeny young optimal ranking. 

Intutively, if we treat all voters to be equal, and took each of their votes -- ran bubble sort on them till they became this minimum ranking. We would need the smallest number of total swaps over all the votes. Or in other words, if we looked at pairwise head to head matchups between candidates -- the Kemeny Optimal ranking has the most number of pairs that agree with the voters.
<div class="intution">Write this better</div>

See [[4][4]] for production level implementation details. The wikipedia page for Kendal-Tau distance is also very informative.

## Borda Aggregation

[[3][3]] claims that Borda-aggregation is a 5-approximation of the optimal rank aggregation. Borda count is computationally simple. For each vote submitted, it gives the candidate a score based on its position in the vote/submitted ranking. For example first place gets a score of 0 and $m$'th place gets a score of $m-1$. Then all the scores for all votes are summed and the candidates are ranked in increasing order of their scores.


## KwikSort

[[5][5]] show this algorithm is a 2-approximation of optimal rank aggregation.


## References

[1]: https://arxiv.org/pdf/1206.5265.pdf "Consensus ranking under the exponential model"
1. [Consensus ranking under the exponential model](https://arxiv.org/pdf/1206.5265.pdf)

[2]: https://dl.acm.org/doi/pdf/10.5555/2791220.2791224 "Rank Aggregation: Together We’re Strong"
2. [Rank Aggregation: Together We’re Strong](https://dl.acm.org/doi/pdf/10.5555/2791220.2791224)

[3]: https://cse.buffalo.edu/faculty/atri/papers/algos/FAS-journal-final.pdf "Ordering by weighted number of wins gives a good
ranking for weighted tournaments"
3. [Ordering by weighted number of wins gives a good
ranking for weighted tournaments](https://cse.buffalo.edu/faculty/atri/papers/algos/FAS-journal-final.pdf)

[4]: https://docs.scipy.org/doc/scipy-0.15.1/reference/generated/scipy.stats.kendalltau.html "Practical Details on Kendall-Tau"
4. [Practical details on Kendall-tau](https://docs.scipy.org/doc/scipy-0.15.1/reference/generated/scipy.stats.kendalltau.html)

[5]: http://dimacs.rutgers.edu/~alantha/papers2/aggregating_journal.pdf "Aggregating Inconsistent Information: Ranking and Clustering"
5. [Aggregating Inconsistent Information: Ranking and Clustering](http://dimacs.rutgers.edu/~alantha/papers2/aggregating_journal.pdf)

</div>