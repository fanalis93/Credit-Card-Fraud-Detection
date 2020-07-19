#importing clean datasets
to_merge1 <- read.csv("clean_application_record.csv")
to_merge2 <- read.csv("clean_credit_record.csv")

#reorganizing STATUS
to_merge2$STATUS[to_merge2$STATUS=='X'] <- '0'
to_merge2$STATUS[to_merge2$STATUS=='C'] <- '0'
to_merge2$STATUS[to_merge2$STATUS=='5'] <- '1'
to_merge2$STATUS[to_merge2$STATUS=='4'] <- '1'
to_merge2$STATUS[to_merge2$STATUS=='3'] <- '1'
to_merge2$STATUS[to_merge2$STATUS=='2'] <- '1'

#Changing datatype of STATUS
to_merge2$STATUS <- as.integer(to_merge2$STATUS)

#ignore 1st and MONTHS_BALANCE column
to_merge2 <- subset(to_merge2,select = -c(X,MONTHS_BALANCE))

#max
require(data.table)
new_cred <- data.table(to_merge2)
new_cred <- new_cred[ ,max(STATUS),by=ID]
names(new_cred)[2] <- "Risk_user"

#Storing the merged dataset
new_merged <- merge(x=to_merge1,y=new_cred,by="ID")
new_merged <- subset(new_merged,select = -c(X))
write.csv(new_merged,'new_merged.csv')

str(new_merged)

