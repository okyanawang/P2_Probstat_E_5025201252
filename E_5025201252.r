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
### Nomor 3
Diketahui perusahaan memiliki seorang data analyst ingin memecahkan permasalahan pengambilan keputusan dalam perusahaan tersebut. Selanjutnya didapatkanlah data berikut dari perusahaan saham tersebut.
</br>
![image](https://user-images.githubusercontent.com/70510279/170834251-73d308da-69c9-4e86-b2b8-4917e598efae.png)
Dari data diatas berilah keputusan serta kesimpulan yang didapatkan dari hasil diatas. Asumsikan nilai variancenya sama, apakah ada perbedaan pada rata-ratanya (α= 0.05)? Buatlah :

#### 3a
H0 dan H1
dilakukan perhitungan H0 sebagai berikut
</br>
![image](https://user-images.githubusercontent.com/70510279/170837176-254c2846-c1b7-47c0-aa9f-c3b2e5db149a.png)
</br>
dilakukan perhitungan H1 sebagai berikut
</br>
![image](https://user-images.githubusercontent.com/70510279/170837297-542b8a9e-309b-41be-92c5-880e284beef4.png)

#### 3b
Hitung Sampel Statistik
Penghitungan dilakukan sebagai berikut
```
tsum.test(mean.x=3.64, s.x = 1.67, n.x = 19, mean.y =2.79 , s.y = 1.32, n.y = 27, alternative = "greater", var.equal = TRUE)
```
![image](https://user-images.githubusercontent.com/70510279/170847031-6d2d82a4-dad1-4e70-b204-5782eb790bf7.png)


#### 3c
Lakukan Uji Statistik (df =2)

Melakukan install library `mosaic`
```
install.packages("mosaic")
library(mosaic)
```

```
plotDist(dist='t', df=2, col="blue")
```
![image](https://user-images.githubusercontent.com/70510279/170845594-721682ce-705c-4423-b6e2-5d3ad48e10cf.png)

#### 3d
Nilai kritikal
Adapun untuk mendapatkan nilai kritikal bisa menggunakan `qchisq` dengan `df=2` sesuai soal sebelumnya

![image](https://user-images.githubusercontent.com/70510279/170846422-617fe5b8-b90c-4e5a-9533-dfec22c62ff3.png)

#### 3e
Keputusan

Teori keputusan adalah teori formal pengambilan keputusan di bawah ketidakpastian. 
Aksinya adalah : `({a}_{a∈A})`
Kemungkinan konsekuensi : `({c}_{c∈C})` (tergantung pada keadaan dan tindakan)
Maka keputusan dapat dibuat dengan `t.test`

#### 3f
Kesimpulan
Kesimpulan yang didapatkan yaitu perbedaan rata-rata yang terjadi tidak ada jika dilihat dari uji statistik dan akan ada tetapi tidak signifikan jika dipengaruhi nilai kritikal.
