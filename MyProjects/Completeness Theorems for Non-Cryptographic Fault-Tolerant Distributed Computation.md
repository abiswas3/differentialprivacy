#ShafiGoldwasser
#BenOr

**Defintion:**
A protocol is $t$-private if any set of at most $t$ players cannot compute after the protocol what those $t$ players could could compute jointly from their inputs and outputs.

**Defintion:**
A protocol is $t$-resilient if any set of at most $t$ players cannot affect the correctness of output the remaining honest players. This only makes sense if the function has a specification incase those byzantine players do not give input or are caught cheating. The output is usually this upside down T.


**Theoem 1**:
For every probabilistic function there exists a $t < \frac{1}{2}$ $t$-private protocol. 

