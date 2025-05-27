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


table_d_df$max_factor <- sapply(table_d_df$factors, max)
table_d_df$no_unique_factors <- sapply(table_d_df$non_rep_factors, function(x) length(x))

plot(table_d_df$Freq, table_d_df$max_factor)
cor(table_d_df$Freq, table_d_df$max_factor)  # -0.27

plot(table_d_df$Freq, table_d_df$no_unique_factors)
cor(table_d_df$Freq, table_d_df$no_unique_factors) # 0.26

# probably though the correlation is bad because
# the data is not normalized
# (no tiene en cuenta que cuanto mayor es d menos posibles tripletas
# podemos encontrar)

# quiero hacer la misma tabla pero ahora teniendo en cuenta
# el numero de tripletas que encontramos

# Idea: dividir entre el número de tripletas que encontramos

# añadir no_triplets a table_d_df
triplets_df <- read.csv("datos/no_tripletas_hasta_7927.csv")
table_d_df <- merge(table_d_df, triplets_df, by.y = "d", all.x = TRUE)
# volver a ordenar
table_d_df <- table_d_df[order(-table_d_df$Freq), ]
rownames(table_d_df) <- NULL

# frecuencia normalizada: freq / no_triplets
table_d_df$norm_freq <- table_d_df$Freq / table_d_df$no_triplets

# ordenamos resp. la nueva frecuencia
table_d_df <- table_d_df[order(-table_d_df$norm_freq), ]
# guardamos la antigua numeración para ver las diferencias

# repetimos las relaciones

plot(table_d_df$norm_freq, table_d_df$factors_mean)
cor(table_d_df$norm_freq, table_d_df$factors_mean) # -0.32

plot(table_d_df$norm_freq, table_d_df$non_rep_factors_mean)
cor(table_d_df$norm_freq, table_d_df$non_rep_factors_mean) # -0.35

plot(table_d_df$norm_freq, table_d_df$max_factor)
cor(table_d_df$norm_freq, table_d_df$max_factor)  # -0.35

plot(table_d_df$norm_freq, table_d_df$no_unique_factors)
cor(table_d_df$norm_freq, table_d_df$no_unique_factors) # 0.34

# ligeramente mejor

# habría que ver si se puede hacer una mejor normalización de las frecuencias
