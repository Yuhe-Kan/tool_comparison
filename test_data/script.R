## input data generation for eight evaluated tools
#1.  METAGENassist
# data transformation
library(microbiomeMarker)
library(phyloseq)
data(caporaso)
ps<-caporaso;ps
library(metagMisc)
otu_tax_table <- phyloseq_to_df(ps, addtax = TRUE)
prefixes <- paste0("D_", 0:6, "__")
cols_to_modify <- 2:8

# exporting otutable and metadata
# exporting otutable
otu_tax_table[cols_to_modify] <- Map(function(col, prefix) paste0(prefix, col),
                                     otu_tax_table[cols_to_modify], prefixes)
otu_tax_table$ID <- apply(otu_tax_table[, 2:8], 1, function(x) paste(x, collapse = ";"))
otu_tax_table$SampleID <- apply(otu_tax_table[, c(ncol(otu_tax_table),1)], 1, function(x) paste(x, collapse = " "))
otu_tax_table <- otu_tax_table[, c(ncol(otu_tax_table),9:(ncol(otu_tax_table)-2))]
write.table(otu_tax_table, "D:/otu_tax_tab.csv", quote = FALSE, sep = ",", row.names = FALSE, col.names = TRUE)

# exporting metadata (only keeping one column)
metadata<-as.data.frame(as.matrix(sample_data(ps)));metadata
class(metadata)
library(tibble)
metadata<-rownames_to_column(metadata,var = "SampleID");metadata
write.table(metadata,"D:/metadata.csv",quote = F,sep=',',row.names = F,col.names = T)


#2. shiny-phyloseq
# data transformation
library(microbiomeMarker)
data(caporaso)
ps_phy<-caporaso;ps
path<-"D:/" #setting your path
save(ps_phy,file = file.path(path, "ps_phy.RData"))

# importing input data
# install.packages("shiny")
shiny::runGitHub("shiny-phyloseq","joey711")


#3. ampvis2
# loading data
library(microeco)
library(phyloseq)
library(file2meco)
library(microbiomeMarker)
data(caporaso)
ps<-caporaso;ps

# exporting otutable and metadata
# exporting otutable
library(metagMisc)
otu_tax_table <- phyloseq_to_df(ps, addtax = TRUE)
class(otu_tax_table)
otu_tax_table <- otu_tax_table[, c(1, 9:ncol(otu_tax_table), 2:8)]
write.table(otu_tax_table,"D:/otu_tax_table.txt",quote = F,sep=';',row.names = F,col.names = T)

# exporting metadata
metadata<-as.data.frame(as.matrix(sample_data(ps)));metadata
class(metadata)
library(tibble)
metadata<-rownames_to_column(metadata,var = "SampleID");metadata
write.table(metadata,"D:/metadata.txt",quote = F,sep='\t',row.names = F,col.names = T)

#4. animalcules
# data transformation
library(microeco)
library(phyloseq)
library(file2meco)
library(microbiomeMarker)
data(caporaso)
ps<-caporaso;ps
meco<-phyloseq2meco(ps)
path<-"D:/" #setting your path
meco$save_table(dirpath = path, sep = "\t",quote = F)

# importing input data
# if (!requireNamespace("devtools", quietly=TRUE))
# install.packages("devtools")
# devtools::install_github("wejlab/animalcules")
library(animalcules)
run_animalcules()

#5. wiSDOM
# data transformation
library(microbiomeMarker)
library(phyloseq)
data(caporaso)
ps<-caporaso;ps
library(metagMisc)
otu_tax_table <- phyloseq_to_df(ps, addtax = TRUE)
prefixes <- paste0("D_", 0:6, "__")
cols_to_modify <- 2:8

# exporting otutable and metadata
# exporting otutable
otu_tax_table[cols_to_modify] <- Map(function(col, prefix) paste0(prefix, col),
                                     otu_tax_table[cols_to_modify], prefixes)
otu_tax_table$ID <- apply(otu_tax_table[, 2:8], 1, function(x) paste(x, collapse = ";"))
otu_tax_table$Taxonomy <- apply(otu_tax_table[, c(ncol(otu_tax_table),1)], 1, function(x) paste(x, collapse = " "))
otu_tax_table <- otu_tax_table[, c(ncol(otu_tax_table),9:(ncol(otu_tax_table)-2))]
write.table(otu_tax_table,"D:/otu_tax_tab.txt",quote = F,sep='\t',row.names = F,col.names = T)
# exporting metadata (only keeping one column)
metadata<-as.data.frame(as.matrix(sample_data(ps)));metadata
class(metadata)
library(tibble)
metadata<-rownames_to_column(metadata,var = "ID");metadata
metadata<- metadata[,1:2] #Based on the research objectives, keep one column (variable)
write.table(metadata,"D:/metadata.txt",quote = F,sep='\t',row.names = F,col.names = F)

# importing input data
# install.packages('shiny')
library(shiny)
shiny::runGitHub('wiSDOM','lunching')

#6. Mian
# data transformation
library(microeco)
library(phyloseq)
library(file2meco)
library(microbiomeMarker)
data(caporaso)
ps<-caporaso;ps

# exporting otutab
library(tibble)
otu<-t(as.data.frame((otu_table(ps))))
otu<-as.data.frame(otu)
otu<-rownames_to_column(otu,var = "Sample Labels")
View(otu)
write.table(otu,"D:/otutab.txt",quote = F,sep='\t',row.names = F,col.names = T)

# exporting taxtab
tax<-as.data.frame(tax_table(ps))
View(tax)
write.table(tax,"D:/taxtab.txt",quote = F,sep='\t',row.names = T,col.names = F)
# adding "OTU	Taxonomy" in first row of file named "taxtab.txt"

# exporting metadata
metadata<-as.data.frame(as.matrix(sample_data(ps)))
View(metadata)
class(metadata)
metadata<-rownames_to_column(metadata,var = "SampleID");metadata
write.table(metadata,"D:/metadata.txt",quote = F,sep='\t',row.names = F,col.names = T)

#7. Namco
library(phyloseq)
library(file2meco)
library(microbiomeMarker)
data(caporaso)
ps<-caporaso;ps
meco<-phyloseq2meco(ps)
path<-"D:/"
meco$save_table(dirpath = path, sep = "\t",quote = F)

#8. Microbiome Analyst2.0
library(phyloseq)
library(file2meco)
library(microbiomeMarker)
data(caporaso)
ps<-caporaso;ps
meco<-phyloseq2meco(ps)
meco$save_table(dirpath = "D:/", sep = ",",quote = F)
# Microbiome AnalystR，feature_table中ID手动改为#NAME,sample_table中ID手动改为sample-id,tax_table中ID手动改为#TAXONOMY


