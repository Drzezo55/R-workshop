# Make sure meta and dmetar are already loaded
library(meta)
library(dmetar)
library(readxl)
data <- read_excel("data.xlsx")
View(data)
# exclude here
studies <- data$author %in% c("Awad 2001")
# get your own subset here
new_data <- data[!studies, ]

# Use metcont to pool results.
m <- metacont(n.e = n.exp,
                   mean.e = mean.exp,
                   sd.e = sd.exp,
                   n.c = n.cont,
                   mean.c = mean.cont,
                   sd.c = sd.cont,
                   studlab = author,
                   data = new_data,
                   sm = "SMD", subgroup = treatment,
                   method.smd = "Hedges",
                   fixed = FALSE,
                   random = TRUE, 
                   method.tau = "REML",
                   method.random.ci = "HK")

summary(m)
meta::forest(m, test.overall = FALSE, label.e = "vit c", col.circle = "orange", 
             col.diamond = "blue", test.effect.subgroup = TRUE, overall = FALSE,
             overall.hetstat = FALSE, test.subgroup = FALSE, 
             , label.c = "placebo", prediction = TRUE, type.study = "circle")

l <- metainf(m)
forest(l)
help("forest")

m$I2