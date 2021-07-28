require(readxl)
require(markdown)
require(rmarkdown)
require(dplyr)

datmarks <- readxl::read_xlsx("February Data.xlsx")

datmarks <- datmarks[, 1:10]

datmarks[, 7:10] <- round(100*datmarks[, 7:10], 2)

for(i in 1:length(unique(datmarks$Name))){
  datmark <- datmarks[ datmarks$Name == unique(datmarks$Name)[i] , ]
  nam <- unique(datmark$Name)
  datmark <- datmark %>% arrange(desc(Marks))
  render("Template.rmd", output_file = paste0(nam, ' Marks-February21', '.html'))
}
