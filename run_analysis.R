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
trainy <- read.table("y_train.txt",col.names = "act_id")
trainsub <- read.table("subject_train.txt",col.names = "subject")
testx <- read.table("X_test.txt")
testy <- read.table("y_test.txt",col.names = "act_id")
testsub <- read.table("subject_test.txt",col.names = "subject")


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

# combine the training data
train_act_sub <- cbind(trainy,trainsub)
train <- cbind(train_act_sub,extracttrainx)

# combine the test data
test_act_sub <- cbind(testy,testsub)
test <- cbind(test_act_sub,extracttestx)

# combine training and test data
combined <- rbind(train,test) 

# load activity labels, and merge them with the training and test activity
# 1 - Walking
# 2 - Walking Upstairs etc.
# activity ID and activity name linked to each observation
actlabel <- read.table("activity_labels.txt", col.names = c("act_id","activity"))

#merge the activity with the combined data
withlabel <- merge(actlabel,combined, by = "act_id", all = TRUE)

# get rid of the activity id column
final <- withlabel[,(2:ncol(withlabel))]

# for the fifth assignment
# the first three variables are the key - note that activity id associates directly to the activity name
# thus grouping by 3 variables gives the same results
# the remaing variables are the data for which mean has to be calculated
# decided to use the command found in the plyr package
# na.rm = TRUE is a required parameter, else will give an error complaing about NA values  
# although they are completely missing

require("plyr")
groupcols <- colnames(final)[1:2]
datacols <- colnames(final)[3:ncol(final)]
combinedmean <- ddply(final, groupcols, function(x) colMeans(x[datacols],na.rm = TRUE))

# The file contains the output of combinedmean dataframe
write.table(combinedmean,"combinedmean.txt",row.name=FALSE) 


