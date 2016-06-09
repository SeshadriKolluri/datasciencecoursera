# Assignment 1, problem 1
pollutantmean <- function(directory, pollutant, id = 1:332){
    #create a lit of all the files in the directory
    filenames <- list.files(path=directory,full.names = TRUE)
    #read the selected range of files into a big list
    selected_data <-lapply(filenames[id],read.csv)
    #combine all the data frames
    combined_data <- do.call(rbind,selected_data)
    #calculate mean of the selected column, from the combine data frame
    mean(combined_data[,pollutant],na.rm=TRUE)
}