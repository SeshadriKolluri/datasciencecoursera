corr <- function(directory, threshold = 0 ){
    #create a lit of all the files in the directory
    filenames <- list.files(path=directory,full.names = TRUE)
    #read the selected range of files into a big list
    selected_data <-lapply(filenames,read.csv)
    #check for number of complete observations in dataset
    correlations <- numeric();
    for (i in 1:length(selected_data)) {
        #using complete.cases to identify complete data
        nobs = sum(complete.cases(selected_data[[i]]))
        if (nobs > threshold ){
            correlations <-c(correlations,cor(selected_data[[i]]$sulfate,selected_data[[i]]$nitrate,use = "complete"))
        }
    }
    correlations
}