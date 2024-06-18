library(tidyverse)

# Preparation

df1 <- data.frame(x = rnorm(100),
                  y = rnorm(100))

df2 <- data.frame(x = rnorm(100),
                  y = rnorm(100))

df3 <- data.frame(x = rnorm(100),
                  y = rnorm(100))



overview <- data.frame(Country = LETTERS[1:3],
                       NameData = sprintf("df%s",1:3),
                       Date = c("2020-06-23","2019-03-14","2020-08-03"),stringsAsFactors = FALSE)



# For each row in overview: make a different report (same structure, different data, different titles)

for(i in 1:nrow(overview)){
  
  
  
  titletemp <- overview$Country[i]
  dftemp <- get(overview$NameData[i])
  datetemp <- overview$Date[i]
  subtitletemp <- sprintf("A random substitle: %s", sample(letters[1:26],1))
  
  
# The following - commented out - part is quite complex. It is a way to dynamically alter footers in your
# automated pdf-reports. The approach is based on:
#                     - Using latex-code to make the footer
#                     - Having a header.tex file with that code
#                     - in R, we can read the header.tex-file (it is basically a .txt) and alter what we need
#                           then write it away as header2.tex
# if you need this approach, change 'header.tex' to 'header2.tex' in the quarto-report file
  
  
  # # if you want a dynamic header, you have to define it before rendering (cannot be done by knitting the rmarkdown-file
  # # with the rstudio-knit-button), add it to the header.tex-file and save it
  # # here, we'll save it in a new file: header2.tex, and header2.tex is included in the rmarkdown (take a look at the
  # # YAML-header). If you don't want a dynamic footer, delete/comment out the following lines and in the 
  # # rmd - YAML - header: change header2.tex to header.tex
  # 
  # # Construct footer. In latex \\ (surounded by spaces) is an end of line. Since \ is a special character, we need
  # # to add an \ for each \: to get \\ in latex, we have to type \\\\
  # footer <- sprintf("Country = %s \\\\ Dataset = %s \\\\Date = %s", titletemp, overview$NameData[i], datetemp)
  # 
  # addfooter <- c("\\pagestyle{fancy}",                 # is already in header.tex, but no problem it will be in there twice
  #                sprintf("\\fancyfoot[C]{%s}",footer), # C: center part of footer: the footer we constructed   
  #                "\\fancyfoot[R]{\\thepage}")          # R: right part of footer: page number
  # 
  # 
  # addfooter <- stringr::str_replace_all(addfooter,"\\_","\\\\_")
  # 
  # # Rewrite header.tex and rename to header2.tex, to add footer
  # head <- readLines("header.tex")                         
  # head <- c(head, addfooter)
  # writeLines(head,"header2.tex")
  
  
  rmarkdown::render("Ex_AutomatedReport_Report.qmd", 
                    params = list(title = sprintf("Country %s",titletemp),
                                  date = datetemp, subtitle = subtitletemp),
                    output_format = "pdf_document", output_file = sprintf("Report_%s",titletemp))
  
}