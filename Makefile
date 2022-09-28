test:
	v test .

doc:
	v doc -o dist/ -f html .
	mv dist/microcms.html dist/index.html
