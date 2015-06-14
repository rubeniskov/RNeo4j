#!/usr/bin/env Rscript
docs = list.files("man")

for (i in 1:length(docs)) {
  input_file = paste("man", docs[i], sep="/")
  output_file = paste0(sub(".Rd", ".html", docs[i]))
  command = paste("R CMD Rdconv -o", output_file, "--type=html", input_file)
  system(command)
}