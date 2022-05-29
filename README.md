# P2_Probstat_D_5025201252

Praktikum 2 Probabilitas dan Statistik 2022

```
Nama    : Okyan Awang Ramadhana
NRP     : 5025201252
Kelas   : Probstat E
```

## Soal 1
Seorang peneliti melakukan penelitian mengenai pengaruh aktivitas 𝐴 terhadap kadar saturasi oksigen pada manusia. Peneliti tersebut mengambil sampel sebanyak 9 responden. Pertama, sebelum melakukan aktivitas 𝐴, peneliti mencatat kadar saturasi oksigen dari 9 responden tersebut. Kemudian, 9 responden tersebut diminta melakukan aktivitas 𝐴. Setelah 15 menit, peneliti tersebut mencatat kembali kadar saturasi oksigen dari 9 responden tersebut. Berikut data dari 9 responden mengenai kadar saturasi oksigen sebelum dan sesudah melakukan aktivitas 𝐴
<img width="338" alt="image" src="/asset/p-1a.png">
Berdasarkan data pada tabel diatas, diketahui kadar saturasi oksigen dari
responden ke-3 ketika belum melakukan aktivitas 𝐴 sebanyak 67, dan setelah
melakukan aktivitas 𝐴 sebanyak 70.

### 1.A
_Carilah Standar Deviasi dari data selisih pasangan pengamatan tabel
diatas_

- kita akan mengekstrak data dari tabel tersebut dengan fungsi `c()` yang akan melakukan kombinasi menjadi vector pada data tabel kemudian disimpan pada variabel `x` dan `y`

```
x <- c(78,75,67,77,70,72,28,74,77)
y <- c(100,95,70,90,90,90,89,90,100)
```
- Visualisasi variabel `x` dan `y` akan disimpan kedalam `data`
- Kemudian dihitung standar deviasinya denggan fungsi `sd()`
```
cat(sprintf("S. Deviasi data X -> %f", sd(x)))
cat(sprintf("S. Deviasi data X -> %f", sd(y)))
```
<img width="338" alt="image" src="/asset/1a.png">

### 1.B
_carilah nilai t (p-value)_
`t-value` merupakan cara untuk mengukur perbedaan antara rata-rata populasi dan `p-value` adalah probabilitas untuk memperoleh `t-value` dengan nilai absolut setidaknya sebesar yang sebenarnya kita amati dalam data sampel jika nol hipotesis sebenarnya benar
disini hipotesa kita adalah `greater`
```
alt <- "greater"
t.test(x, y, alternative = alt, var.equal = FALSE)
```

<img width="340" alt="image" src="/asset/1b.png">

### 1.C

_tentukanlah apakah terdapat pengaruh yang signifikan secara statistika
dalam hal kadar saturasi oksigen , sebelum dan sesudah melakukan
aktivitas 𝐴 jika diketahui tingkat signifikansi 𝛼 = 5% serta H0 : “tidak ada
pengaruh yang signifikan secara statistika dalam hal kadar saturasi
oksigen , sebelum dan sesudah melakukan aktivitas 𝐴”_

- `tidak ada pengaruh yang signifikan` oleh karena itu, disini kita akan terlebih dahulu membandingkan data pada kolom `x` dan `y` dengan

```
var.test(x, y)
```

- kemudian diikuti dengan percobaan dengan `t.test()` untuk mengetahui apakah terdapat pengaruh yang signifikan secara statistika dalam hal kadar saturasi oksigen , sebelum dan sesudah melakukan aktivitas 𝐴

```
t.test(x, y, mu = 0, var.equal = TRUE)
```

sebelum

<img width="340" alt="image" src="https://user-images.githubusercontent.com/64743796/170865551-6ef98baf-5367-4d7d-8114-64f9a22cae87.png">

setelah

<img width="341" alt="image" src="https://user-images.githubusercontent.com/64743796/170865684-ea918111-3b36-4d49-8b7f-ed0fdaa2b5fd.png">

dapat dilihat bahwa jika dibandingkan dengan nilai sebelumnya, tidak terjadi perbedaan nilai yang signifikan setelah aktivitas 𝐴

## Soal 2

Diketahui bahwa mobil dikemudikan rata-rata lebih dari 20.000 kilometer per tahun.
Untuk menguji klaim ini, 100 pemilik mobil yang dipilih secara acak diminta untuk
mencatat jarak yang mereka tempuh. Jika sampel acak menunjukkan rata-rata
23.500 kilometer dan standar deviasi 3900 kilometer.

### 2.A
_Apakah Anda setuju dengan klaim tersebut?_ Setuju
### 2.B
_Jelaskan maksud dari output yang dihasilkan!_
```
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
```
<img width="265" alt="image" src="https://user-images.githubusercontent.com/64743796/170865849-b4b9e19c-b142-4eb3-96b7-59b470055b4c.png">
### 2.C
- Kita pertama akan menghitung nilai dari `p-value` dari data diatas
```
data.mean <- 235000
data.a <- 20000
data.sd <- 3900
data.n <- 100
z <- (data.mean-data.a)/(data.sd/sqrt(data.n))
2*pnorm(-abs(z))
```
<img width="245" alt="image" src="https://user-images.githubusercontent.com/64743796/170866565-efbc7cba-7a5c-45ad-a983-f5354a8fba76.png">

- dari nilai `p-value = 0` maka diketahui hipotesis nol ditolak dan pengujian kita signifikan secara statistik. Oleh karena itu, dapat kita tarik kesimpulan bahwa

```
Mobil dikemudikan rata-rata lebih dari 20.000 kilometer/tahun
```
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
Teori keputusan adalah teori formal pengambilan keputusan di bawah ketidakpastian. 
Aksinya adalah : `({a}_{a∈A})`
Kemungkinan konsekuensi : `({c}_{c∈C})` (tergantung pada keadaan dan tindakan)
Maka keputusan dapat dibuat dengan `t.test`

#### 3f
Kesimpulan
Kesimpulan yang didapatkan yaitu perbedaan rata-rata yang terjadi tidak ada jika dilihat dari uji statistik dan akan ada tetapi tidak signifikan jika dipengaruhi nilai kritikal.
