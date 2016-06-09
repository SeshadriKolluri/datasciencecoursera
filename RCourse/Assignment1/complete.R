# Problem No. 2 of Assignment No. 1
complete <- function(directory, id = 1:332){
    #create a lit of all the files in the directory
    filenames <- list.files(path=directory,full.names = TRUE)
    #read the selected range of files into a big list
    print(filenames[id])
    selected_data <-lapply(filenames[id],read.csv)
    #initialize a nobs vector with the same length as id
    nobs <- numeric(length(id))
    for (i in 1:length(id)) {
        #using complete.cases to identify complete data
        nobs[i] = sum(complete.cases(selected_data[[i]]))
    }
    data.frame(id,nobs)
}