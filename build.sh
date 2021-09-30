# This will be automated eventually- being lazy for now
pandoc -s -c blog.css -A footer.html -H header.html  README.md -o index.html
cd ShufflePrivacy/ && ./build && cd ../
cd Definitions/ && ./build && cd ../
cd ConcentrationInequalities/ && ./build && cd ../
cd ExponentialMechanism/ && ./build && cd ../
cd SuccintHist-Bassily && ./build && cd ../
cd FrequencyEstimationSurvey && ./build && cd ../
# cd private_histograms/ && ./build && cd ../

