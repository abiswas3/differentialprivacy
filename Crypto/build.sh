pandoc  --mathjax=../code/es5/tex-chtml.js -s -c ./crypto.css -A ./cryptoFooter.html -H ./cryptoHeader.html Readme.md -o index.html
cd SNIPs/ && ./build && cd ../
cd Foundations && ./build.sh && cd ../
