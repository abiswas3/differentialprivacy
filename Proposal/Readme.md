\newcommand{\P}[3]{\mathbb{P}_{#2 \sim #3}\Big[#1\Big]}
\newcommand{\D}{\mathbb{D}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\E}{\mathbb{E}}
\newcommand{\max}{\text{max}}
\newcommand{\S}[1]{\Delta #1}
\newcommand{\RBinHist}{\textit{R}_{\epsilon, \delta}^{zsum}}
\newcommand{\ABinHist}{\textit{A}_{\epsilon, \delta}^{zsum}}
\newcommand{\PBinHist}{\textit{P}_{\epsilon, \delta}^{zsum}}
\newcommand{\localP}{\textit{P} = (\textit{R}, \textit{A})}
\newcommand{\epsDelta}{(\epsilon, \delta)}
\newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}

<div class="container">

# Working Title: Algorithms for Private Federated Aggregation with Theoretical Guarantees

## Motivation

We are experiencing a surge in the adoption of Artificial Intelligence (AI) across the tech industry and society. According to the Harvard Business Review [[1][1]], 86% of the surveyed companies claimed they use AI as a mainstream technology and 67% companies plan to further invest in AI. Personal activities such as browsing the news, searching for articles or listening to music, are now influenced by AI powered technology [[2][2]]. These algorithms are fined tuned for the end user and are designed to maximise user engagement; thereby, their success almost always hinges on large scale user data collection. Furthermore, these algorithms have proven to be major economic drivers in the 21st century. According to [[4][4]], *digital advertising contributed to €526 billion in Gross Value Added to the European Economy*. With the growing popularity of data intensive deep learning algorithms [[11][11]], users find themselves being continuously montiored. Search engines like Google, Amazon and Bing record user clicks to optimise algorithms [[3][3]] and tailor search results for users. Social media companies like Instagram, Twitter and Facebook use polls and surveys to illicit opinion on topics ranging from politics to sports. This large scale recording and continous monitoring has raised ethical concerns about user privacy. Massive AI/Machine learning pipelines lead to complex software systems that are more vulnerable to breaches and attacks. Just in the 21st century, 3 billion user accounts have been compromised at Yahoo [[5][5]], 1.1 billion users had their usenames and mobile numbers compromised at Ali Baba [[7][7]] and LinkedIN had 700 million user accounts posted on the dark web [[6][6]]. These breaches have serious explicit and implicit consequences. The explicit consequences include loss of privacy in the form of credit card, telpehone numbers and other vital personal information being compromised. Implicit consequences often show up in the form hacktivism, the use of computer-based techniques such as hacking as a form of civil disobedience to promote a political agenda or social change. British consulting firm Cambridge Analytica collected facebook user data without consent to influence political elections [[8][8]]. One form of defense against the aforementioned risks are legal restrictions that prevent companies from logging or storing user data such as the GDPR laws [[9][9]]. These laws ensure privacy by restricting companies from storing data or making consent explicit. However, there is a feeling that such laws stifle innovation [[10][10]]. As stated earlier, these algorithms are highly desirable and contribute to economic growth. Given these concerns, there has been a focus on building privacy enhancing technology (PET) that aims for a middle ground. Differential Privacy will be the primary focus of our research. It is a branch of PET, in which the algorithms make the following promise to users - *“You will not be affected, adversely or otherwise, by allowing your data to be used in any study or analysis, no matter what other studies, data sets, or information sources, are available.”* **CITE dwork book**. In the next section we outline existing research in differential privacy and some open problems we wish to understand.

Source: Permute and Flip
Differential privacy is by now considered a de facto standard for protecting confi- dentiality of user data in statistical applications and has been adopted by organiza- tions such as Google [15, 3], Apple [26], Microsoft [9] and the U.S. Census Bureau [21, 16, 1]. 


## Background

Computer science researchers are often interested in learning as efficiently as possible, fundamental primitives such as sums, averages, most frequent item (heavy hitter) etc of a large population [[12][12]]. These primitives prove to be important as they can be composed to answer complex queries about the poulation. For example the theoretical understanding of supervised learning hinges on our ability to understand how sums of bounded random variables behave [[13][13]]**CITE ERM**. Differential privacy addresses the paradox of learning nothing about an individual while learning useful information about a population. Additionally,  algorithms defined by the composition of differentially private algorithms also satisfy privacy [[14][14]]**CITE composition**. Given this property, researchers have been trying to understand the theoretical implications of computing aforementioned primitives privately. This has led to the emergence of three different trust models for privacy- central, local and shuffle privacy. In central privacy [[15][15]]**CITE LAPLACE MECH**, members of the population send their true values to a trusted aggregator/analyser. The aggregator applies a carefully selected random transformation on aggregate statistics of the population and publishes it. In the local model, each member applies their own random transformation and send their privatised data to a non trusted aggregator. The aggregator performs aggregation on noisy data and releases the population statistics. The trust model of the local model allows each user plausible deniability. Thus itprovides more privacy than that of central model but this comes at the cost of accuracy of population statistics. The theoretical guarantees and practical implications of computing mean and sums of populations has been studied in detail in the last ten years. The Laplace Mechanism [[15][15]] estimates the mean of a real valued population within constant error. Under the local model, [[16][16]] prove a tight lower bound on error of $\Omega(\sqrt{n})$  is necessary for estimating the mean of a population. It links the well studied randomised response algorithms [[17][17]] **CITE RR** for anonymised survey design to privacy showing they are optimal . This deep understanding of means and sums have enabled us to compute [histograms](), [quantiles](), [heavy hitters]() and other complex primitves privately with theoretical guarantees.

The shuffle model lies in between the central and local model **CITE BORJA BLANKET**. The shuffle model can be thought of an anonymous local model analysed from a central perspective **CITE AMPLIFICATION OF PRIVACY**. Under the shuffled model, each member of the population performs their own random transformations (like in local privacy) but magnitude of random transformations should be enough to guarantee central privacy. Thus the accuracy guarantees in the shuffled model are closer to that of central privacy while the privacy guarantees are close to the local model. Recent work by [Cheu II]() and [Gazi III]() have developed that give near central accuracy for sum and mean estimation of real valued populations. [Gazi I]() has also proved lower bounds for shuffle privacy linking it to central and local privacy.

Rank Aggregation is a regime which uses the primitives described above to compute a ranking that can serve as a single best representative of a collection of preferences over a set of items. Non private Rank Aggregation has been studied ad nauseam in the Machine Learning and Search engine community owing to its direct applicatin to web search and recommendations. However, rank aggregation has not received the same degree of attention under the lens of privacy. [Hay] has applied ugnder understanding of private mean estimation to describe private versions of borda count and kwik sort ranking. Under the central model, revisited the exponential mechanism to generate an algorithm for ranking optimal in kendall tau. However a distributed algorithm for ranking with theoretical gurantees remains open. Given the importance of ranking to Machine Learning and social science community we wish to focus on the problem of distributed ranking with theoretical guarantees.



## Research directions


### PHD Objectives

* To develop new practical distributed algorithms with theoretical guarantees that preserve privacy.
* Extend distributed privacy to the problem of ranking and social choice.
* Unify exisiting distributed algorithms under a single proof framework. 
* Develop a scalable open source implementations of distributed algorithms and integrate with existing open soure implementations.


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


[13]:
13. []()

[14]:
14. []()

[15]:http://www.dbis.informatik.hu-berlin.de/fileadmin/lectures/SS2011/VL_Privacy/Differential_Privacy.pdf "Differential Privacy"
15. [Differential Privacy](http://www.dbis.informatik.hu-berlin.de/fileadmin/lectures/SS2011/VL_Privacy/Differential_Privacy.pdf)


[16]: https://timroughgarden.org/papers/priv.pdf "UNIVERSALLY UTILITY-MAXIMIZING PRIVACY MECHANISMS"
16. [UNIVERSALLY UTILITY-MAXIMIZING PRIVACY MECHANISMS](https://timroughgarden.org/papers/priv.pdf)

[17]:
17. []()

[18]:
18. []()

[19]:
19. []()

[20]:
20. []()

[21]:
21. []()

[22]:
22. []()

[23]:
23. []()

[24]:
24. []()

[25]:
25. []()




</div>