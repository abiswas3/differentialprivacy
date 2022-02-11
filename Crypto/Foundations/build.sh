pandoc  --mathjax=../../code/es5/tex-chtml.js -s -c ../crypto.css -A ../cryptoFooter.html -H ../cryptoHeader.html Readme.md -o index.html
cd Prelims/ && ./build && cd ./..
cd OneWayFunctions/ && ./build && cd ./..
cd PseudoRandomStuff/ && ./build && cd ./..

