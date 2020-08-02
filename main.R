df1 <- read.csv("application_record.csv")
df1
df2 <- read.csv("credit_record.csv")
df2
#renaming columns
names(df1)[2] <- "Gender"
names(df1)[3] <- "Own_car"
names(df1)[4] <- "Own_realty"
names(df1)[5] <- "No_children"
names(df1)[6] <- "Income"
names(df1)[7] <- "Income_type"
names(df1)[8] <- "Education"
names(df1)[9] <- "Marital_status"
names(df1)[10] <- "Housing_type"
names(df1)[11] <- "DateOfBirth"
names(df1)[12] <- "DateOfEmployed"
names(df1)[13] <- "Mobil"
names(df1)[14] <- "Workphone"
names(df1)[15] <- "Phone"
names(df1)[16] <- "Email"
names(df1)[17] <- "Occupation"
names(df1)[18] <- "No_family_members"

#cleaning missing values / empty strings
clean_application_record <- df1[!apply(df1,1,function(x) any(x=="")),]
anyNA(clean_application_record)

#Int to Date
clean_application_record$DateOfBirth <- as.Date(clean_application_record$DateOfBirth, origin="1970-01-01")
clean_application_record$DateOfEmployed <- as.Date(clean_application_record$DateOfEmployed, origin="1970-01-01")

#Own_car and Own_realty
clean_application_record$Own_car[clean_application_record$Own_car=='Y'] <- '1'
clean_application_record$Own_car[clean_application_record$Own_car=='N'] <- '0'
clean_application_record$Own_realty[clean_application_record$Own_realty=='Y'] <- '1'
clean_application_record$Own_realty[clean_application_record$Own_realty=='N'] <- '0'
clean_application_record$Own_car <- as.integer(clean_application_record$Own_car)
clean_application_record$Own_realty <- as.integer(clean_application_record$Own_realty)

#Gender and marital_status
clean_application_record$Gender[clean_application_record$Gender=='M'] <- '1'
clean_application_record$Gender[clean_application_record$Gender=='F'] <- '2'
clean_application_record$Gender <- as.integer(clean_application_record$Gender)
summary(clean_application_record$Own_car)

clean_credit_record <- df2
#saving dataset
write.csv(clean_application_record,'clean_application_record.csv')
write.csv(clean_credit_record,'clean_credit_record.csv')

str(clean_application_record)
