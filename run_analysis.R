#### 
####  Please note that the execution is not as per the steps mentioned in the assignment
####  as i felt taking this route was fewer commands
####  further, no cleanup activity has been performed, and could take up significant amount of RAM
####  while creating all the data objects
####


# Load all the training and test data into dataframes 
# X_train.txt - training data
# y_train.txt - activity id corresponding to the training data - column names attached
# subject_train.txt - subjects who took part in the training - column names attached
# similarly we have test data
trainx <- read.table("X_train.txt")
trainy <- read.table("y_train.txt",col.names = "act.id")
trainsub <- read.table("subject_train.txt",col.names = "sub.id")
testx <- read.table("X_test.txt")
testy <- read.table("y_test.txt",col.names = "act.id")
testsub <- read.table("subject_test.txt",col.names = "sub.id")

# load activity labels, and merge them with the training and test activity
# 1 - Walking
# 2 - Walking Upstairs etc.
# activity ID and activity name linked to each observation
actlabel <- read.table("activity_labels.txt", col.names = c("act.id","activity"))
train_act <- merge(trainy,actlabel, by = "act.id", all = TRUE) 
test_act <- merge(testy,actlabel, by = "act.id", all = TRUE)

# activity linked to each subject in each observation
temp_train <- cbind(train_act,trainsub)
temp_test <- cbind(test_act,testsub)

# get a list of variables collected/calculated  
variables <- read.table("features.txt")
# get a list of variable indexes that have mean or Mean or std() in them
varsub <- grep("[Mm]ean|std()", variables$V2)

# associate the data with the variable names
names(trainx) <- variables$V2
names(testx) <- variables$V2

# extract only the variables that have a mean or Mean or std() in them
extracttrainx <- trainx[,varsub]
extracttestx <- testx[,varsub]

# associate the activity/subject table with the extracted data table 
train <- cbind(temp_train,extracttrainx)
test <- cbind(temp_test,extracttestx)

# Finally combine the training and test results
combined <- merge(train,test,all = TRUE)

# for the fifth assignment
# the first three variables are the key - note that activity id associates directly to the activity name
# thus grouping by 3 variables gives the same results
# the remaing variables are the data for which mean has to be calculated
# decided to use the command found in the plyr package
# na.rm = TRUE is a required parameter, else will give an error complaing about NA values  
# although they are completely missing

require("plyr")
groupcols <- colnames(combined)[1:3]
datacols <- colnames(combined)[4:ncol(combined)]
combinedmean <- ddply(combined, groupcols, function(x) colMeans(x[datacols],na.rm = TRUE))

# The file contains the output of combinedmean dataframe
write.table(combinedmean,"combinedmean.txt",row.name=FALSE) 




