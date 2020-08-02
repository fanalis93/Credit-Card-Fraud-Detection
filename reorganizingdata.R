#data for visualization
final <- subset(new_merged,select = -c(ID,Mobil))
final$Marital_status <- gsub(" / not married","", final$Marital_status)
final$Education <- gsub(" / secondary special","", final$Education)

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

#data for modeling
final <- read.csv('final.csv')
final_model_data <- subset(final,select = c('Gender','Own_car','Own_realty','No_children','Income','Marital_status','No_family_members','Risk_user'))

#single = 1,married =2
final_model_data$Marital_status <- as.character(final_model_data$Marital_status)
final_model_data$Marital_status[final_model_data$Marital_status=='Single'] <- '1'
final_model_data$Marital_status[final_model_data$Marital_status=='Married'] <- '2'
final_model_data$Marital_status[final_model_data$Marital_status=='Civil marriage'] <- '2'
final_model_data$Marital_status[final_model_data$Marital_status=='Separated'] <- '2'
final_model_data$Marital_status[final_model_data$Marital_status=='Widow'] <- '2'


final_model_data$Marital_status <- as.numeric(final_model_data$Marital_status)
final_model_data$Risk_user <- as.factor(final_model_data$Risk_user)

write.csv(final_model_data,'final_model_data.csv')
