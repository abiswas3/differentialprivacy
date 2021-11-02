# This will be automated eventually- being lazy for now
pandoc -s -c main.css -A footer.html -H main_header.html  README.md -o index.html
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
<<<<<<< HEAD
cd EquivalenceOfPrivacyModels && ./build && cd ../
=======
cd PrivateVoting  && ./build && cd ../
cd VotingSummary  && ./build && cd ../
>>>>>>> a7827bfbad140426fb1e83118d7184354cb27bd4

# cd private_histograms/ && ./build && cd ../

