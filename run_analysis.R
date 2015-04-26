
#update library
library(data.table)
library(tidyr)
library(dplyr)

#assign filepath to url variables
url1 <- "test/subject_test.txt"
url2 <- "test/x_test.txt"
url3 <- "test/y_test.txt"
url4 <- "train/subject_train.txt"
url5 <- "train/x_train.txt"
url6 <- "train/y_train.txt"
urlfeatures<- "features.txt"
urlactivity<- "activity_labels.txt"


#read data into tables
mydata1 <- read.table(url1, sep="",header=FALSE, na.strings=c("NA", "N/A","?"),
                     stringsAsFactors=FALSE,nrows=-1L)
mydata2 <- read.table(url2, sep="",header=FALSE, na.strings=c("NA", "N/A","?"),
                      stringsAsFactors=FALSE,nrows=-1L)
mydata3 <- read.table(url3, sep="",header=FALSE, na.strings=c("NA", "N/A","?"),
                      stringsAsFactors=FALSE,nrows=-1L)
mydata4 <- read.table(url4, sep="",header=FALSE, na.strings=c("NA", "N/A","?"),
                      stringsAsFactors=FALSE,nrows=-1L)
mydata5 <- read.table(url5, sep="",header=FALSE, na.strings=c("NA", "N/A","?"),
                      stringsAsFactors=FALSE,nrows=-1L)
mydata6 <- read.table(url6, sep="",header=FALSE, na.strings=c("NA", "N/A","?"),
                      stringsAsFactors=FALSE,nrows=-1L)

myheaders <- read.table(urlfeatures, sep="",header=FALSE, stringsAsFactors=FALSE,nrows=-1L)
myactivity <- read.table(urlactivity, sep="",header=FALSE, stringsAsFactors=FALSE,nrows=-1L)

#create list of variables, identify all with "mean" or "std" in the names and create the list of variables (as columns)
#which would include meanFreq() measures but not the measures for the additional 'Angle' features

myheaderlist <- c(myheaders[ ,2])
stdcol<- grep("std",myheaderlist)
meancol <-grep("mean",myheaderlist)
colkeep<- append(meancol,stdcol)

#assign names to working tables
colnames(mydata1) <- "Subject"
colnames(mydata2) <- myheaderlist[1:561]
colnames(mydata3) <- "Actnum"
colnames(mydata4) <- "Subject"
colnames(mydata5) <- myheaderlist[1:561]
colnames(mydata6) <- "Actnum"

colnames(myactivity)<- c("Actnum", "Activity")

#create subset of datatables based on shortlist of variable names
test <-mydata2[ ,c(colkeep)]
train <-mydata5[ ,c(colkeep)]
featurenames<- myheaderlist[c(colkeep)]

#join together subjectID, activityID and measures for test and train data
#then combine into one table
testdf <- cbind(mydata1, mydata3, test)
traindf<- cbind(mydata4, mydata6, train)
mydata <- rbind(testdf,traindf)
mydataDF <- tbl_df(mydata)

#Join the combined data table to the activity table then drop the activity IDs
#so that just the activity labels remain
mydataDFLabel <- inner_join(mydataDF,myactivity)
myfinalDF <- select(mydataDFLabel,-Actnum)

#gather columns of variables into rows
myfinalDFLong <- myfinalDF %>% gather(Variable, Measure, -Subject, -Activity)

#group by subject, activity and variables
DFGroup <- group_by(myfinalDFLong,Subject,Activity,Variable)

#caculate the mean for each
DFResult <- summarise(DFGroup,MEAN = mean(Measure))

#export data to file
write.table(DFResult,"tidydata.txt", row.name=FALSE)


