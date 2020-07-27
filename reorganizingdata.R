final <- subset(new_merged,select = -c(ID,Mobil))
final$Marital_status <- gsub(" / not married","", final$Marital_status)
final$Education <- gsub(" / secondary special","", final$Education)

unique(final[,'Marital_status'])


final$Gender <- as.factor(final$Gender)
final$Risk_user <- as.factor(final$Risk_user)
final$Marital_status <- as.factor(final$Marital_status)
final$Own_car <- as.factor(final$Own_car)
final$Own_realty <- as.factor(final$Own_realty)
final$Income_type <- as.factor(final$Income_type)
final$Housing_type <- as.factor(final$Housing_type)
final$Workphone <- as.factor(final$Workphone)
final$Phone <- as.factor(final$Phone)
final$Email <- as.factor(final$Email)
final$Occupation <- as.factor(final$Occupation)
final$Education <- as.factor(final$Education)

write.csv(final,'final.csv')

################

