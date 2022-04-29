pandoc  --mathjax=../code/es5/tex-chtml.js -s -c ./blog.css -A ./footer.html -H ./header.html Readme.md -o index.html
# TODO: Re-write these summaries with code once again. 
cd Definitions/ && ./build && cd ../
# cd ShufflePrivacy/ && ./build && cd ../

# # cd ExponentialMechanism/ && ./build && cd ../
# # cd SuccintHist-Bassily && ./build && cd ../
# # cd FrequencyEstimationSurvey && ./build && cd ../
# cd ShuffleSumMeanEstimateRasmus && ./build && cd ../
# cd ShuffleSumBinaryRasmus && ./build && cd ../
# cd PrivateMeanEstimation && ./build && cd ../
# cd PureProtocols  && ./build && cd ../
# cd EquivalenceOfPrivacyModels && ./build && cd ../
# # cd PrivateVoting  && ./build && cd ../
# # cd VotingSummary  && ./build && cd ../
cd CheuShuffleRR  && ./build && cd ../
# cd RRSurvey && ./build && cd ../
# cd PrivateSetUnion && ./build && cd ../
