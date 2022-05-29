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
## diketahui
rata_rata <- 23500
standar_deviasi <- 3900
pemilik_mobil <- 100
## hasil
tsum.test(
  mean.x = rata_rata, 
  sd(standar_deviasi), 
  n.x = pemilik_mobil, 
  var.equal = FALSE)

#C
## diketahui
data.mean <- 235000
data.a <- 20000
data.sd <- 3900
data.n <- 100
## hasil
z <- (data.mean-data.a)/(data.sd/sqrt(data.n))
2*pnorm(-abs(z))

# NOMOR 3 (A,F ada di readme) ________________________________________________________________________________________________________________________________
#A
## diketahui
bandung.n <- 19
bandung.mean <- 3.64
bandung.sd <- 1.67

bali.n <- 27
bali.mean <- 2.79
bali.sd <- 1.32

a <- 0

## hasil
bandung.z <- (bandung.mean-a)/(bandung.sd/sqrt(bandung.n))
bali.z <- (bali.mean-a)/(bali.sd/sqrt(bali.n))

cat(sprintf("No 3.a Nilai H0  -> %f", bandung.z))

cat(sprintf("No 3.a Nilai H1 -> %f", bali.z))

# B
## diketahui
alt <- "greater"
## hasil
tsum.test(
  mean.x = bandung.mean, 
  s.x = bandung.sd, 
  n.x = bandung.n, 
  mean.y = bali.mean, 
  s.y = bali.sd, 
  n.y = bali.n,
  alternative = alt, 
  var.equal = TRUE
)

# C
library(mosaic)
## diketahui
df <- 2
## hasil
plotDist(dist = 't', df = df)

# D
## diketahui
alpha <- 0.05
df <- 2
## hasil
result <- qchisq(p = alpha, df = df, lower.tail = FALSE)
cat(sprintf("No 3.d Nilai Kritikal -> %f", result))

#E
critical <- 5.991465
statistic <- 3.64 + 2.79

critical < statistic

# NOMOR 4 (D ada di readme) ________________________________________________________________________________________________________________________________
# A

library(ggplot2)

oneWayData  <- read.table(url("https://rstatisticsandresearch.weebly.com/uploads/1/0/2/6/1026585/onewayanova.txt"))
dim(oneWayData)
head(oneWayData)
attach(oneWayData)

oneWayData$Length <- as.factor(oneWayData$V2)
oneWayData$Group <- as.factor(oneWayData$V1)
oneWayData$Group = factor(oneWayData$Group,labels = c("Kucing Oren","Kucing Hitam","Kucing Putih","Kucing Oren"))
class(oneWayData$Group)

grup1 <- subset(oneWayData, Group == "Kucing Oren")
grup2 <- subset(oneWayData, Group == "Kucing Hitam")
grup3 <- subset(oneWayData, Group == "Kucing Putih")

ggplot(
  data = grup1, 
  aes(sample = Length)
  ) + geom_qq()
  
ggplot(
  data = grup2, 
  aes(sample = Length)
  ) + geom_qq()
  
ggplot(
  data = grup3, 
  aes(sample = Length)
  ) + geom_qq()



# B
bartlett.test(oneWayData$Group, oneWayData$Length)

# C
qqnorm(grup1$Length)
qqline(grup1$Length)

# E
model <- lm(Length~Group, data = oneWayData)
anova(model)
TukeyHSD(aov(model))

#F
ggplot(
  oneWayData, 
  aes(x = Group, y = Length)) + geom_boxplot(colour = "black") + scale_x_discrete() + xlab("Species") + ylab("Length")


# NOMOR 5 ________________________________________________________________________________________________________________________________
library(ggplot2)
library(readr)
library(dplyr)
library(multcompView)
# A

id <- "1aLUOdw_LVJq6VQrQEkuQhZ8FW43FemTJ"
GTLData <- read.csv(sprintf("https://docs.google.com/uc?id=%s&export=download", id))
head(GTLData)
str(GTLData)
qplot(
  x = Temp, 
  y = Light, 
  geom = "point", 
  data = GTLData) + facet_grid(.~Glass, labeller = label_both)

# B
GTLData$Glass <- as.factor(GTLData$Glass)
GTLData$Temp_Factor <- as.factor(GTLData$Temp)
str(GTLData)

anova <- aov(Light ~ Glass*Temp_Factor, data = GTLData)
summary(anova)

# C
summary_table <- group_by(GTLData, Glass, Temp) 
  %>%
  summarise(
    mean = mean(Light), 
    sd = sd(Light)) 
  %>%
  arrange(desc(mean))

print(summary_table)

# D
anova <- aov(Light ~ Glass*Temp_Factor, data = GTLData)
print(TukeyHSD(anova))

# E
anova <- aov(Light ~ Glass*Temp_Factor, data = GTLData)
tukey <- TukeyHSD(anova)

compare_data <- multcompLetters4(anova, tukey)
print(compare_data)

cld <- as.data.frame.list(compare_data$`Glass:Temp_Factor`)
compare_data$Tukey <- cld$Letters
print(compare_data)