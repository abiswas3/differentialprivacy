<div class="container">

# Working Title: Distributed Rank Aggregation with Theoretical Guarantees

## Motivation

We are experiencing a surge in the adoption of Artificial Intelligence (AI) across the tech industry and society. According to the Harvard Business Review [[1][1]], 86% of the surveyed companies claimed they use AI as a mainstream technology and 67% companies plan to further invest in AI. Personal activities such as browsing the news, searching for articles or listening to music, are now influenced by AI powered technology [[2][2]]. These algorithms are designed to maximise user engagement; thereby, their success almost always hinges on large scale user data collection. Furthermore, these algorithms have proven to be major economic drivers in the 21st century. According to [[4][4]], *digital advertising contributed to €526 billion in Gross Value Added to the European Economy*. With the growing popularity of data intensive deep learning algorithms [[11][11]], users find themselves being continuously monitored. Search engines like Google, Amazon and Bing record user clicks to optimise algorithms [[3][3]] and tailor search results for users. Social media companies like Instagram, Twitter and Facebook use polls and surveys to illicit opinion on topics ranging from politics to sports. This large scale recording and continuous monitoring has raised ethical concerns about user privacy. Massive AI/Machine learning pipelines lead to complex software systems that are more vulnerable to breaches and attacks. Just in the 21st century, 3 billion user accounts have been compromised at Yahoo [[5][5]], 1.1 billion users had their usernames and mobile numbers compromised at Ali Baba [[7][7]] and LinkedIN had 700 million user accounts posted on the dark web [[6][6]]. These breaches have serious explicit and implicit consequences. The explicit consequences include loss of privacy in the form of credit card, telephone numbers and other vital personal information being compromised. Implicit consequences often show up in the form hacktivism, the use of computer-based techniques such as hacking as a form of civil disobedience to promote a political agenda or social change. British consulting firm Cambridge Analytica collected Facebook user data without consent to influence political elections [[8][8]]. One form of defence against the aforementioned risks is legal restrictions. An example of such restrictions are GDPR laws [[9][9]] which restrict the freedom with which software entities can log or store user data. There is a feeling however, that such laws stifle innovation [[10][10]]. As stated earlier, these algorithms are highly desirable and contribute to economic growth. Given these concerns, there has been a renewed interest in building privacy enhancing technology (PET). Examples include Differential Privacy [[15][15]], Secure Multiparty Computation [[35][35]] and Homomorphic Encryption [[36][36]] among many others. Differential Privacy will be the primary focus of our research. It is a branch of PET, in which the algorithms make the following promise to users - *“You will not be affected, adversely or otherwise, by allowing your data to be used in any study or analysis, no matter what other studies, data sets, or information sources, are available.”* [[14][14]]. Differential privacy is considered a de facto standard for protecting confidentiality of user data in statistical applications and has been adopted by organizations such as Google [[28][28], [29][29]], Apple [[30][30]], Microsoft [[31][31]] and the U.S. Census Bureau [[32][32], [33][33], [34][34]]. 

## Background

Differential privacy addresses the paradox of learning nothing about an individual while learning useful information about a population. A useful property of differential privacy states that, algorithms defined by a composition of differentially private algorithms are also private [[14][14]]. Additionally, differential privacy is robust to post processing **CITE**. Computer scientists have studied algorithms for efficiently estimating primitives such as sums, averages and most frequent item (heavy hitter) of a large population for years [[12][12]]. These primitives are important as they are fundamental, and can be composed to answer complex queries which have practical real world implications. For example, the success of supervised machine learning relies on our understanding of the variance of sums of bounded random variables[[13][13]]. Owing to composability and the post processing property of privacy, researchers have been trying to estimate aforementioned primitives under differential privacy. This work has led to the categorisations of three trust models for differential privacy, namely, central, local and shuffle privacy. In central privacy [[15][15]], members of the population send their true values to a trusted aggregator/analyser. The aggregator applies a carefully selected random transformation to the aggregate statistics of the population and publishes it. In the local model, each member applies their own random transformation and sends their privatised data to a non trusted aggregator. The aggregator performs aggregation on noisy data and releases the population statistics. The trust model of the local model allows each user plausible deniability i.e. the aggregator is not able to guess an individuals true value with certainty. This implies the local model provides more privacy than the central model, but this comes at the cost of accuracy. The theoretical trade-off between privacy and accuracy for computing mean and sums of populations has been studied in detail in the last ten years. The Laplace Mechanism [[15][15]] estimates the mean of a real valued population up to constant error. Under the local model, [[16][16]] prove a tight lower bound on error, showing a square root dependency on the size of the population is unavoidable. They prove that the well studied randomised response algorithms [[22][22]] for anonymised survey design are optimal for local privacy. This theoretical understanding of means and sums have enabled us to compute histograms[[17][17]], heavy hitters [[18][18]], quantiles [[19][19]] and other complex primitives privately and efficiently.

The shuffle model lies in between the central and local model [[20][20]]. The shuffle model can be thought of an anonymous local model analysed from a central perspective [[21][21]]. Under the shuffled model, each member of the population performs their own random transformations (like in local privacy) but magnitude of random transformations are small enough to guarantee central privacy. It is desirable because the accuracy guarantees in the shuffled model are closer to that of central privacy while the privacy guarantees are close to that of the local model. In recent work, [[23][23]] and [[24][24]] have developed algorithms with error near central accuracy for sum and mean estimation of real valued populations. [[25][25]] describes a framework connecting shuffle privacy to local and central privacy by proving lower bounds for the shuffle model.

Rank aggregation is the process of computing a ranking that can serve as a single best representative of a collection of preferences over a set of items. Non private rank aggregation has been studied ad nauseam in the machine learning community owing to its direct application to web search and recommendations [[37][37]]. Most ranking algorithms can be described by a composition of the basic primitives described above. However, rank aggregation has not received the same degree of attention under the lens of privacy. [[26][26]] develop private versions of Borda count ranking [[38][38]] and Kwik sort ranking [[39][39]] under the central model. [[27][27]] propose a private version of Kwik sort under the local model. The shuffled model for ranking with near central error guarantees remains open. To the best of our knowledge, the optimal bounds for ranking have not been studied in detail even under the central model. Given the importance of ranking to Machine Learning and social science community we wish to focus on the problem of distributed ranking with theoretical guarantees.

### PHD Objectives

* To develop new practical distributed algorithms with theoretical guarantees that preserve privacy.
* Extend existing algorithms for distributed privacy to the problem of ranking and social choice.
* Unify existing distributed algorithms under a single proof framework. 
* Develop a scalable open source implementations of distributed algorithms and integrate with existing open source implementations.

## Research directions

**TODO**: Outline work with the exponential mechanism and secure comparison protocols.

## Timeline

### Year I

* Survey existing learning to rank and choice theory literature.
* Conduct literature review for distributed mechanisms for rank aggregation and mean estimation.
* Unify relevant algorithms under a single open source library for fair comparison on practical real world datasets.
* Propose first novel distributed private algorithm for rank aggregation.

### Year II

* Prove the theoretical framework for distributed algorithms for theory of social choice.
* Establish links with other well studied primitives. 
* Propose efficient and practical algorithms for distributed ranking.
* Open source a library scaleable distributed rank aggregation.

### Year III

* Continuing down themes covered in the second year or starting on other research directions  as previously listed

# References 

[1]: https://hbr.org/2021/09/ai-adoption-skyrocketed-over-the-last-18-months "Increase in AI Adoption"
1. [Increase in AI Adoption](https://hbr.org/2021/09/ai-adoption-skyrocketed-over-the-last-18-months)

[2]: https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/35599.pdf  "Personalized News Recommendation Based on Click Behavior "
2. [Personalized News Recommendation Based on Click
Behavior ](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/35599.pdf)


[3]: https://www.cs.cornell.edu/people/tj/publications/joachims_02c.pdf "Optimizing search engines using clickthrough data"
3. [Optimizing search engines using clickthrough data](https://www.cs.cornell.edu/people/tj/publications/joachims_02c.pdf)

[4]: https://datadrivenadvertising.eu/wp-content/uploads/2017/09/DigitalAdvertisingEconomicContribution_FINAL.pdf "Economic Gains of Ads"
4. [Economic Gains of Ads](https://datadrivenadvertising.eu/wp-content/uploads/2017/09/DigitalAdvertisingEconomicContribution_FINAL.pdf)

[5]: https://www.ncsc.gov.uk/news/yahoo-data-breach-ncsc-response "Yahoo data breach: NCSC response"
5. [Yahoo data breach: NCSC response](https://www.ncsc.gov.uk/news/yahoo-data-breach-ncsc-response)

[6]: https://www.forbes.com/sites/quickerbettertech/2021/07/05/a-linkedin-breach-exposes-92-of-usersand-other-small-business-tech-news/ "LinkedIn Data Breach"
6. [LinkedIn Data Breach](https://www.forbes.com/sites/quickerbettertech/2021/07/05/a-linkedin-breach-exposes-92-of-usersand-other-small-business-tech-news/)

[7]: https://www.bloomberg.com/news/articles/2021-06-16/alibaba-victim-of-huge-data-leak-as-china-tightens-security "Alibaba Victim of Huge Data Leak as China Tightens Security"
7. [Alibaba Victim of Huge Data Leak as China Tightens Security](https://www.bloomberg.com/news/articles/2021-06-16/alibaba-victim-of-huge-data-leak-as-china-tightens-security)

[8]: https://www.bbc.co.uk/news/world-43476762 "Cambridge Analytica: The data firm's global influence"
8. [Cambridge Analytica: The data firm's global influence](https://www.bbc.co.uk/news/world-43476762)

[9]: https://gdpr.eu/what-is-gdpr/ "GDPR Laws"
9. [GDPR Laws](https://gdpr.eu/what-is-gdpr/)

[10]: https://www.infosecurity-magazine.com/news/gdpr-is-stifling-innovation-says/ "GDPR stifle innovation"
10. [GDPR stifle innovation](https://www.infosecurity-magazine.com/news/gdpr-is-stifling-innovation-says/)

[11]: https://journalofbigdata.springeropen.com/articles/10.1186/s40537-014-0007-7 "Deep learning applications and challenges in big data analytics"
11. [Deep learning applications and challenges in big data analytics](https://journalofbigdata.springeropen.com/articles/10.1186/s40537-014-0007-7)

[12]: http://wrap.warwick.ac.uk/59804/ "Summary data structures for massive data"
12. [Summary data structures for massive data](http://wrap.warwick.ac.uk/59804/)


[13]: https://www.researchgate.net/profile/Yann-Lecun/publication/220500215_Measuring_the_VC-Dimension_of_a_Learning_Machine/links/0912f50f9e76564012000000/Measuring-the-VC-Dimension-of-a-Learning-Machine.pdf "Measuring the VC-dimension
of a Learning Machine"
13. [Measuring the VC-dimension of a Learning Machine](https://www.researchgate.net/profile/Yann-Lecun/publication/220500215_Measuring_the_VC-Dimension_of_a_Learning_Machine/links/0912f50f9e76564012000000/Measuring-the-VC-Dimension-of-a-Learning-Machine.pdf)

[14]: https://www.cis.upenn.edu/~aaroth/Papers/privacybook.pdf "The Algorithmic Foundations
of Differential Privacy"
14. [The Algorithmic Foundations of Differential Privacy](https://www.cis.upenn.edu/~aaroth/Papers/privacybook.pdf)

[15]:http://www.dbis.informatik.hu-berlin.de/fileadmin/lectures/SS2011/VL_Privacy/Differential_Privacy.pdf "Differential Privacy"
15. [Differential Privacy](http://www.dbis.informatik.hu-berlin.de/fileadmin/lectures/SS2011/VL_Privacy/Differential_Privacy.pdf)


[16]: https://timroughgarden.org/papers/priv.pdf "UNIVERSALLY UTILITY-MAXIMIZING PRIVACY MECHANISMS"
16. [UNIVERSALLY UTILITY-MAXIMIZING PRIVACY MECHANISMS](https://timroughgarden.org/papers/priv.pdf)

[17]: https://arxiv.org/abs/1504.04686 "Local, Private, Efficient Protocols for Succinct Histograms"
17. [Local, Private, Efficient Protocols for Succinct Histograms](https://arxiv.org/abs/1504.04686)

[18]: https://arxiv.org/abs/1902.08534 "Federated Heavy Hitters Discovery with Differential Privacy"
18. [Federated Heavy Hitters Discovery with Differential Privacy](https://arxiv.org/abs/1902.08534)

[19]: https://openreview.net/pdf?id=msTLiku_34p "Sample-and-threshold differential privacy: Histograms and applications"
19. [Sample-and-threshold differential privacy: Histograms and applications](https://openreview.net/pdf?id=msTLiku_34p)

[20]: https://arxiv.org/abs/1811.12469 "Amplification by Shuffling: From Local to Central Differential Privacy via Anonymity"
20. [Amplification by Shuffling: From Local to Central Differential Privacy via Anonymity](https://arxiv.org/abs/1811.12469)

[21]: https://arxiv.org/abs/1903.02837 "The Privacy Blanket of the Shuffle Model"
21. [The Privacy Blanket of the Shuffle Model](https://arxiv.org/abs/1903.02837)

[22]: https://imai.fas.harvard.edu/research/files/randresp.pdf "Design and Analysis of the Randomized Response Technique"
22. [Design and Analysis of the Randomized Response Technique](https://imai.fas.harvard.edu/research/files/randresp.pdf)

[23]: https://privacytools.seas.harvard.edu/publications/separating-local-shuffled-differential-privacy-histograms "Separating Local & Shuffled Differential Privacy via Histograms"
23. [Separating Local & Shuffled Differential Privacy via Histograms](https://privacytools.seas.harvard.edu/publications/separating-local-shuffled-differential-privacy-histograms)

[24]: https://arxiv.org/abs/2106.04247 "Private Counting from Anonymous Messages: Near-Optimal Accuracy with Vanishing Communication Overhead"
24. [Private Counting from Anonymous Messages: Near-Optimal Accuracy with Vanishing Communication Overhead](https://arxiv.org/abs/2106.04247)

[25]: https://arxiv.org/abs/1908.11358 "On the Power of Multiple Anonymous Messages"
25. [On the Power of Multiple Anonymous Messages](https://arxiv.org/abs/1908.11358)

[26]: https://people.cs.umass.edu/~miklau/assets/pubs/dp/hay17differentially.pdf "Differentially Private Rank Aggregation"
26. [Differentially Private Rank Aggregation](https://people.cs.umass.edu/~miklau/assets/pubs/dp/hay17differentially.pdf)

[27]: https://arxiv.org/abs/1908.04486 "Private Rank Aggregation under Local Differential Privacy"
27. [Private Rank Aggregation under Local Differential Privacy](https://arxiv.org/abs/1908.04486)

[28]: https://arxiv.org/abs/1407.6981 "Randomized aggregatable privacy-preserving ordinal response"
28. [Randomized aggregatable privacy-preserving ordinal response](https://arxiv.org/abs/1407.6981)

[29]: https://arxiv.org/abs/1710.00901 "Strong privacy for analytics in the crowd"
29. [Strong privacy for analytics in the crowd](https://arxiv.org/abs/1710.00901)

[30]: https://machinelearning.apple.com/research/learning-with-privacy-at-scale "Learning with privacy at scale"
30. [Learning with privacy at scale](https://machinelearning.apple.com/research/learning-with-privacy-at-scale)

[31]: https://proceedings.neurips.cc/paper/2017/file/253614bbac999b38b5b60cae531c4969-Paper.pdf "Collecting telemetry data privately"
31. [Collecting telemetry data privately](https://proceedings.neurips.cc/paper/2017/file/253614bbac999b38b5b60cae531c4969-Paper.pdf)

[32]: https://ieeexplore.ieee.org/document/4497436#:~:text=The%20source%20data%20for%20this,data%20while%20providing%20privacy%20guarantees. "Privacy: From theory to practice on the map"
32. [Privacy: From theory to practice on the map](https://ieeexplore.ieee.org/document/4497436#:~:text=The%20source%20data%20for%20this,data%20while%20providing%20privacy%20guarantees.)

[33]: https://dl.acm.org/doi/10.1145/3035918.3035940 "Utility cost of formal privacy for releasing national employer - employee statistics"
31. [Utility cost of formal privacy for releasing national employer- employee statistics](https://dl.acm.org/doi/10.1145/3035918.3035940)

[34]: https://core.ac.uk/download/pdf/219376854.pdf "The US Census Bureau adopts differential privacy."
34. [The US Census Bureau adopts differential privacy.](https://core.ac.uk/download/pdf/219376854.pdf)

[35]: https://eprint.iacr.org/2008/197.pdf "Secure Multiparty Computation for
Privacy-Preserving Data Mining"
35. [Secure Multiparty Computation for Privacy-Preserving Data Mining](https://eprint.iacr.org/2008/197.pdf)

[36]: https://eprint.iacr.org/2015/1192 "A Guide to Fully Homomorphic Encryption"
36. [A Guide to Fully Homomorphic Encryption](https://eprint.iacr.org/2015/1192)

[37]: https://www.amazon.co.uk/Learning-Rank-Information-Retrieval-Tie-Yan/dp/3642142664 "Learning to rank"
37. [Learning to rank](https://www.amazon.co.uk/Learning-Rank-Information-Retrieval-Tie-Yan/dp/3642142664)

[38]: https://apps.dtic.mil/sti/pdfs/ADA319245.pdf#page=29 "Applying the Borda Ranking Method"
38. [Applying the Borda Ranking Method](https://apps.dtic.mil/sti/pdfs/ADA319245.pdf#page=29)

[39]: https://faculty.ucmerced.edu/sim3/papers/2019-ECML-ranking-outliers.pdf "Fast and Parallelizable Ranking with Outliers from Pairwise Comparisons"
39. [Fast and Parallelizable Ranking with Outliers from Pairwise Comparisons](https://faculty.ucmerced.edu/sim3/papers/2019-ECML-ranking-outliers.pdf)
</div>