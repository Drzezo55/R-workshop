library(readxl)
library(dmetar)
library(meta)
df <- read_excel("data.xlsx")
m.bin <- metabin(event.e = event.e, 
                 n.e = n.e,
                 event.c = event.c,
                 n.c = n.c,
                 studlab = author,
                 data = df,
                 sm = "RR",
                 method = "MH",
                 MH.exact = TRUE,
                 fixed = TRUE,
                 random = FALSE)
summary(m.bin)
png(file = "forestplot.png", width = 2800, height = 2400, res = 300)

meta::forest(m.bin, 
             sortvar = TE,
             prediction = TRUE, test.overall = TRUE, 
             print.tau2 = FALSE, label.e = "Music", label.c = "control",
             type.study = "circle", col.diamond = "green", col.study = "orange")

dev.off()
loo <- metainf(m.bin)
png(file = "forestplot_loo.png", width = 2800, height = 2400, res = 300)
meta::forest(loo, col = "blue", col.diamond = "red", type = "circle")
dev.off()
