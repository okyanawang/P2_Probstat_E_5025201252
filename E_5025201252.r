# NO 1 ________________________________________________________________________________________________________________________________
# A
x <- c(78,75,67,77,70,72,28,74,77)
y <- c(100,95,70,90,90,90,89,90,100)
data <- data.frame (
  group = rep(c("x", "y"), each = 9),
  saturation = c(x, y)
)
cat(sprintf("S. Deviasi data X -> %f", sd(x)))
cat(sprintf("S. Deviasi data X -> %f", sd(y)))
# B
alt <- "greater"
t.test(x, y, alternative = alt, var.equal = FALSE)
# C
var.test(x, y)
t.test(x, y, mu = 0, var.equal = TRUE)

# NOMOR 2 (A ada di readme) ________________________________________________________________________________________________________________________________
# B
library(BSDA)
rata_rata <- 23500
standar_deviasi <- 3900
pemilik_mobil <- 100
tsum.test(
  mean.x = rata_rata, 
  sd(standar_deviasi), 
  n.x = pemilik_mobil, 
  var.equal = FALSE)
#C
data.mean <- 235000
data.a <- 20000
data.sd <- 3900
data.n <- 100
z <- (data.mean-data.a)/(data.sd/sqrt(data.n))
2*pnorm(-abs(z))

# Soal 3
# Soal 3a
# H0 dan H1 -> explanation on readme
# soal 3b 
# Hitung Sampel Statistik
tsum.test(mean.x=3.64, s.x = 1.67, n.x = 19, 
          mean.y =2.79 , s.y = 1.32, n.y = 27, 
          alternative = "greater", var.equal = TRUE)
# soal 3c
# Lakukan Uji Statistik (df =2)
install.packages("mosaic")
library(mosaic)
plotDist(dist='t', df=2, col="blue")
# soal 3d
# Nilai Kritikal
qchisq(p = 0.05, df = 2, lower.tail=FALSE)
# soal 3e
# README
# soal 3f
# README

# 4.
onewayanova = read.table("onewayanova.txt",h=T)
onewayanova

# a.
# set group jadi factor
onewayanova$Group <- as.factor(onewayanova$Group)

# memberikan label
onewayanova$Group = factor(onewayanova$Group,labels = c("kucing oren", "kucing hitam", "kucing putih"))

Group1 <- subset(onewayanova, Group == "kucing oren")
Group2 <- subset(onewayanova, Group == "kucing hitam")
Group3 <- subset(onewayanova, Group == "kucing putih")

qqnorm(Group1$Length)
qqline(Group1$Length)

qqnorm(Group2$Length)
qqline(Group2$Length)

qqnorm(Group3$Length)
qqline(Group3$Length)

# b.
# Homogeneneity of variances
bartlett.test(Length ~ Group, data = onewayanova)

# c.
#One Way ANOVA
#lm = linier model
model1 = lm(Length ~ Group, data = onewayanova)
anova(model1)

# d
#  menolak null hypotesis / H0, maka menunjukkan adanya perbedaan panjang antara ketiga spesies atau rata-rata panjangnya sama

# e.
#Post-hoc test TukeyHSD
TukeyHSD(aov(model1))

# f.
install.packages("ggplot2")
library("ggplot2")

ggplot(onewayanova, aes(x = Group, y = Length)) +
  geom_boxplot(color = c("#00AFBB", "#E7B800", "#FC4E07")) +
  scale_x_discrete() + xlab("Group") + ylab("Length (cm)")



#5
#Letakkan .csv pada directory C:\Users\USER\Documents
GTL <- read_csv("GTL.csv")
head(GTL)

str(GTL)

#5A
soal_5a<-function(){
  qplot(x = Temp, y = Light, geom = "point", data = GTL) +
    facet_grid(.~Glass, labeller = label_both)
}
soal_5a()

#5B
soal_5b<-function(){
  GTL$Glass <- as.factor(GTL$Glass)
  GTL$Temp_Factor <- as.factor(GTL$Temp)
  str(GTL)
  
  anova <- aov(Light ~ Glass*Temp_Factor, data = GTL)
  summary(anova)
}
soal_5b()


#5C
soal_5c<-function(){
  data_summary <- group_by(GTL, Glass, Temp) %>%
    summarise(mean=mean(Light), sd=sd(Light)) %>%
    arrange(desc(mean))
  print(data_summary)
}
soal_5c()


#5D
soal_5d<-function(){
  tukey <- TukeyHSD(anova)
  print(tukey)
}
soal_5d()

#5E
soal_5e<-function(){
  tukey.cld <- multcompLetters4(anova, tukey)
  print(tukey.cld)
  
  cld <- as.data.frame.list(tukey.cld$`Glass:Temp_Factor`)
  data_summary$Tukey <- cld$Letters
  print(data_summary)
  
  #Opsional: export .csv
  write.csv("GTL_summary.csv")
}
soal_5e()