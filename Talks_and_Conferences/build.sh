pandoc  --mathjax=../code/es5/tex-chtml.js -s -c ./conference.css -A ./conference_footer.html -H ./conference_header.html main.md -o index.html
pandoc  --mathjax=../code/es5/tex-chtml.js -s -c ./conference.css -A ./conference_footer.html -H ./conference_header.html talks.md -o talks.html
cd conference_summaries 
for value in NIPS_2021 ICML_2021
do
	pandoc  --mathjax=../../code/es5/tex-chtml.js -s -c ../conference.css -A ../conference_footer.html -H ../conference_header.html $value.md -o $value.html
done
cd ../
