if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
install.packages("tidyverse")
BiocManager::install("QDNAseq", dependencies = TRUE)
BiocManager::install("Biobase")
BiocManager::install("CGHcall")
BiocManager::install("matrixStats")
BiocManager::install("R.utils")
BiocManager::install("Rsamtools")
BiocManager::install("future.apply", force = TRUE)
BiocManager::install("QDNAseq.hg19")
library(QDNAseq)
install.packages("fig.cap")
install.packages("png")
library(png)
set.seed(5)
N <- 100
x <- runif(N)
y<-0.1*x+2.5*x^2-2*x^3 + rnorm(N,0,0.01)
img1_path <- readpng("https://github.com/MikeRBell88/QDNAseq-Bioinformatics/blob/b97c84ab34e86dbf7535f34881bfa2eb205bedd9/CNVMethodsTable.png)

install.packages("highlightFilters")
browseVignettes("QDNAseq")
bins <- getBinAnnotations(binSize=15)
bins
install.packages("devtools")
install.packages("readPNG")
devtools::install_github("lbusett/insert_table")



### Processing BAM files

# sample data for purpose of study 

LGG150 <- read.csv("https://github.com/MikeRBell88/QDNAseq-Bioinformatics/raw/main/LGG150.rda", row.names=NULL)
data(LGG150) # sample data for purpose of study 
readCounts <- (LGG150)

readCounts

plot(readCounts, logTransform=FALSE, ylim=c(-50, 200))

highlightFilters(readCounts, logTransform=FALSE,
                   residual=TRUE, blacklist=TRUE)

readCountsFiltered <- applyFilters(readCounts, residual=TRUE, blacklist=TRUE)

isobarPlot(readCountsFiltered)

readCountsFiltered <- estimateCorrection(readCountsFiltered)

noisePlot(readCountsFiltered)

copyNumbers <- correctBins(readCountsFiltered)

copyNumbers

copyNumbersNormalized <- normalizeBins(copyNumbers)

copyNumbersSmooth <- smoothOutlierBins(copyNumbersNormalized)

plot(copyNumbersSmooth)

exportBins(copyNumbersSmooth, file="LGG150.txt")

exportBins(copyNumbersSmooth, file="LGG150.igv", format="igv")

exportBins(copyNumbersSmooth, file="LGG150.bed", format="bed")


### Downstream Analyses

copyNumbersSegmented <- segmentBins(copyNumbersSmooth, transformFun="sqrt")

copyNumbersSegmented <- normalizeSegmentedBins(copyNumbersSegmented)

plot(copyNumbersSegmented)

copyNumbersCalled <- callBins(copyNumbersSegmented)

plot(copyNumbersCalled)

exportBins(copyNumbersCalled, "copyNumbersCalled.vcf")

exportBins(copyNumbersCalled, "copyNumbersCalled.seg")

cgh <- makeCgh(copyNumbersCalled)

cgh

### Parallel Computation
copyNumbers <- callBins(..., ncpus=4)
=======
>>>>>>> dd92cfcabd4a8a27d3f4fbd5c507ecc7a45d9399

! [Alt text]("/Users/Mike's PC/Pictures/CNVMethodsTable.png")
