# This will be automated eventually- being lazy for now
pandoc -s -c main.css -A footer.html -H main_header.html  README.md -o index.html
cd Scratch/ && ./build && cd ../
cd ShufflePrivacy/ && ./build && cd ../
cd Definitions/ && ./build && cd ../
cd ConcentrationInequalities/ && ./build && cd ../
cd ExponentialMechanism/ && ./build && cd ../
cd SuccintHist-Bassily && ./build && cd ../
cd FrequencyEstimationSurvey && ./build && cd ../
cd ShuffleSumMeanEstimateRasmus && ./build && cd ../
cd ShuffleSumBinaryRasmus && ./build && cd ../
cd PrivateMeanEstimation && ./build && cd ../
cd PureProtocols  && ./build && cd ../
cd EquivalenceOfPrivacyModels && ./build && cd ../
cd PrivateVoting  && ./build && cd ../
cd VotingSummary  && ./build && cd ../
cd CheuShuffleRR  && ./build && cd ../
cd RRSurvey && ./build && cd ../
cd Proposal && ./build && cd ../
cd SecurityBasics && ./build && cd ../
cd conferences && ./build && cd ../
cd PrivateSetUnion && ./build && cd ../
cd PracticalMethodsForSecureAggregation && ./build && cd ../ 
# cd private_histograms/ && ./build && cd ../

