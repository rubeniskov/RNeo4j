test:
	tests/test.sh

test_all:
	neokit/neorun tests/test_all.sh 2.3.1 2.2.6 2.1.8

install:
	R CMD INSTALL --no-multiarch --with-keep.source ../RNeo4j

source:
	R CMD build ../RNeo4j

binary:
	R CMD INSTALL --build --preclean ../RNeo4j

update:
	sed 's/$(OLD)/$(NEW)/' DESCRIPTION > tempfile && mv tempfile DESCRIPTION
	sed 's/$(OLD)/$(NEW)/' R/internal.R > tempfile && mv tempfile R/internal.R

version:
	/usr/bin/Rscript -e 'packageDescription("RNeo4j")["Version"];'
	
readme:
	/usr/bin/Rscript -e 'library(knitr);knit("README.Rmd", "README.md");'
	
download_neo4j:
	neokit/neoget -i -x 2.3.1 2.2.6 2.1.8
	neokit/neoctl unzip 2.3.1 2.2.6 2.1.8
	
cran:
	export PATH="$PATH:/usr/texbin"
	- rm *.tar.gz
	./build.sh
	R CMD check --as-cran *.tar.gz
	rm -rf RNeo4j.Rcheck
	
pdf:
	R CMD Rd2pdf ../RNeo4j
	rm -rf .*Rd2pdf