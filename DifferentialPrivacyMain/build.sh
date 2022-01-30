pandoc  --mathjax=../code/es5/tex-chtml.js -s -c ./blog.css -A ./footer.html -H ./header.html Readme.md -o index.html
cd ShufflePrivacy/ && ./build && cd ../
cd Definitions/ && ./build && cd ../
# cd ConcentrationInequalities/ && ./build && cd ../
# cd ExponentialMechanism/ && ./build && cd ../
# cd SuccintHist-Bassily && ./build && cd ../
# cd FrequencyEstimationSurvey && ./build && cd ../
cd ShuffleSumMeanEstimateRasmus && ./build && cd ../
cd ShuffleSumBinaryRasmus && ./build && cd ../
cd PrivateMeanEstimation && ./build && cd ../
cd PureProtocols  && ./build && cd ../
cd EquivalenceOfPrivacyModels && ./build && cd ../
# cd PrivateVoting  && ./build && cd ../
# cd VotingSummary  && ./build && cd ../
cd CheuShuffleRR  && ./build && cd ../
cd RRSurvey && ./build && cd ../
cd PrivateSetUnion && ./build && cd ../
