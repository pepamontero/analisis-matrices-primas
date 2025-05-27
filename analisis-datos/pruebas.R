# Set cwd to the directory where this file is
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# Check cwd
getwd()

# Folder /data should be on the same directory as this file

# Open matrices
matrices <- read.csv("datos/matrices_3x3_hasta_7927.csv", header = TRUE)
# Save columns from matrices as single elements
attach(matrices)

### Find number of matrices dep. on distance

table_d <- table(d)
table_d_df <- as.data.frame(table(d))
table_d_df <- table_d_df[order(-table_d_df$Freq), ]
rownames(table_d_df) <- NULL

# we saw that frequency of distances has relation to
# factorization of the distance
# thus we want to add a column with factorization

library("numbers")
table_d_df$factors <- lapply(as.numeric(as.character(table_d_df$d)), primeFactors)

# theory: distances with lower factors have more frequencies
# so i want to plot the mean of (non-repeating?) factors against frequency

table_d_df$factors_mean <- sapply(table_d_df$factors, mean) 
table_d_df$non_rep_factors <- lapply(table_d_df$factors, unique)
table_d_df$non_rep_factors_mean <- sapply(table_d_df$non_rep_factors, mean)

plot(table_d_df$Freq, table_d_df$factors_mean)
cor(table_d_df$Freq, table_d_df$factors_mean) # -0.24

plot(table_d_df$Freq, table_d_df$non_rep_factors_mean)
cor(table_d_df$Freq, table_d_df$non_rep_factors_mean) # -0.26

# some correlation is found but it's weak
# let's see if we compare it with the max prime factor
# AND most importantly the number of unique factors







