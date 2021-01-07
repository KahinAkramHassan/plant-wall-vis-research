

#Loading multiple files into a single dataframe
load_data <- function(path, pattern) { 
  files <- dir(path, pattern = pattern, full.names = TRUE)
  #We remove the first entry which is from the pilot test with dummy data
  files <- files[-1]
  
  cat(length(files)," files were found in the data directory.")
  tables <- lapply(files, read.csv)
  do.call(rbind, tables)
}

#Add an upper case letter at the beginning of each cells of a column
capFirst <- function(s) {
  paste(toupper(substring(s, 1, 1)), substring(s, 2), sep = "")
}
