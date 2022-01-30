pandoc  --mathjax=../../code/es5/tex-chtml.js -s -c ../blog.css -A ../footer.html -H ../header.html Readme.md -o index.html
cd Asymptotics && ./build && cd ..
