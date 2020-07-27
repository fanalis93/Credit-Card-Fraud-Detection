library(GGally)

plot(final$Income,final$Risk_user)
abline(lm(final$Risk_user ~ final$Income))

cor(new_merged$Income,new_merged$Risk_user)
cor(new_merged[,2:3])
ggcorr(new_merged)

#corr
ggcorr(num_std, 
       label = TRUE, 
       label_alpha = TRUE)
ggplot(final, aes(Risk_user, Income,)) + geom_point()

finalnumval <- new_merged[sapply(new_merged,is.numeric)]
numval <- subset(numval,select = -c(Mobil))
num_std <- subset(num_std,select = -c(Mobil))


library(corrgram)
corrgram(mtcars, order=NULL, lower.panel=panel.shade,
         upper.panel=NULL, text.panel=panel.txt,
         main="Car Milage Data (unsorted)")

table(new_merged$Risk_user)


############################
library(ggplot2)
library(ggExtra)
ggplot(data=final, mapping = aes(x=Marital_status,y=Income, color=Risk_user)) + geom_line()


p <- ggplot(final, aes(x=No_family_members, y=Income, color=Risk_user,size=Risk_user)) +
  geom_point()
print(p)
p1 <- ggMarginal(p, type="density")
p1
p1 <- ggMarginal(p, type="histogram", size=10)
p1
p2 <- ggMarginal(p, margins = 'x', color="purple", size=4)
p2



#wordcloud
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
set.seed(1234)
wordcloud(words = final$Income, freq = final$No_family_members, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


#########
p <- ggplot(data=final, aes(x=Income, y=Marital_status, colour=Occupation))
p +  geom_point()+geom_smooth(fill=NA, size=1.2)


#gender
final_viz = final
final_viz$Gender <- as.character(final$Gender)
final_viz$Gender[final_viz$Gender=='1'] <- 'Male'
final_viz$Gender[final_viz$Gender=='2'] <- 'Female'
write.csv(final_viz,'final_viz.csv')

rm(final_viz)
library(ggplot2)
ggplot(final) + geom_bar(aes(x = Marital_status, fill=Risk_user))









