# This will be automated eventually- being lazy for now
pandoc -s -c main.css -A footer.html -H main_header.html README.md -o index.html
cd DifferentialPrivacyMain/ && ./build.sh && cd ../
cd SNIPs && ./build && cd ../ 
cd conferences && ./build && cd ../
# cd Scratch/ && ./build && cd ../
cd PrivateVoting  && ./build && cd ../


