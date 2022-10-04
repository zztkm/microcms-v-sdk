test:
	v test .

doc:
	v doc -readme -o dist/ -f html .
	mv dist/microcms.html dist/index.html

fmt:
	v fmt -w .