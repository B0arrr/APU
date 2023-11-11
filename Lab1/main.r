# (a)
a <- 11 / log(11)
b <- 2 * a
cat("a =", a, "\n")
cat("b =", b, "\n")
cat("Wieksza wartosc:", ifelse(a > b, "a", "b"), "\n")

# (b)
?tan

# (c)
a <- seq(80, 235)
suma_a <- sum(a)
cat("Suma liczb w wektorze a:", suma_a, "\n")

# (d)
funkcje_sum <- ls(pattern = "sum")
print(funkcje_sum)

# (e)
setwd("C:/R")
a <- "smartfon Huawei"
save(a, file = "zmienna_a.RData")
rm(a)
cat("Wartosc zmiennej a po usunieciu:", exists("a"), "\n")
load("zmienna_a.RData")
cat("Wartosc zmiennej a po wczytaniu z pliku:", a, "\n")

# (f)
library(gridExtra)
?Titanic
head(Titanic)

# (g)
wektor_ciag_liczb <- seq(300, 220, by = -8)
print(wektor_ciag_liczb)

# (h)
a <- seq(60, 30, by = -1)
b <- seq(30, 50, by = 1)
d <- c(b, a)
print(d)

# (i)
nazwa <- c("P60 Pro", "Nova 11i", "Nova 11 Pro", "Mate 50 Pro", "Nova Y61",
           "Nova 9", "Nova 10", "Nova 11", "Nova 8i", "Nova Y90")
wyswietlacz <- c(6.67, 6.8, 6.78, 6.74, 6.52, 6.57, 6.67, 6.7, 6.67, 6.7)
pamiec_RAM <- c(8, 8, 8, 8, 4, 8, 8, 8, 6, 6)
pamiec_wbudowana <- c(256, 128, 256, 256, 64, 128, 128, 256, 128, 128)
aparat_foto <- c(48, 48, 50, 64, 50, 50, 50, 50, 64, 50)
cena <- c(4499, 1019, 2199, 3499, 649, 1249, 1799, 2599, 899, 1029)
liczba_opinii <- c(13, 6, 2, 12, 2, 11, 6, 1, 11, 8)
smartfony <- data.frame(
  Nazwa = nazwa,
  Wyswietlacz = wyswietlacz,
  Pamiec_RAM = pamiec_RAM,
  Pamiec_wbudowana = pamiec_wbudowana,
  Aparat_foto = aparat_foto,
  Cena = cena,
  Liczba_opinii = liczba_opinii
)
print(smartfony)
srednia_cena <- mean(smartfony$Cena)
cat("Srednia cena smartfonow:", srednia_cena, "\n")

# (j)
nowy_smartfon <- data.frame(
  Nazwa = "Nova 9 SE",
  Wyswietlacz = 6.78,
  Pamiec_RAM = 8,
  Pamiec_wbudowana = 128,
  Aparat_foto = 108,
  Cena = 899,
  Liczba_opinii = 7
)
smartfony <- rbind(smartfony, nowy_smartfon)
print(smartfony)
srednia_cena_po_dodaniu <- mean(smartfony$Cena)
cat("Nowa srednia cena smartfonow:", srednia_cena_po_dodaniu, "\n")

# (k)
smartfony$Ocena_klientow <- seq(0, 5, by = 0.5)
smartfony$Ocena_klientow <- as.factor(smartfony$Ocena_klientow)
print(smartfony)
srednia_cena_dla_oceny <- tapply(smartfony$Cena, smartfony$Ocena_klientow, mean)
cat("Srednia cena dla kazdej oceny klientow:\n")
print(srednia_cena_dla_oceny)

# (l)
nowe_smartfony <- data.frame(
  Nazwa = c("Y6p", "P40 Lite", "P smart 2021", "P50 Pro"),
  Wyswietlacz = c(6.3, 6.39, 6.67, 6.6),
  Pamiec_RAM = c(3, 4, 4, 8),
  Pamiec_wbudowana = c(64, 64, 128, 256),
  Aparat_foto = c(13, 48, 48, 50),
  Cena = c(299, 499, 599, 4499),
  Liczba_opinii = c(24, 45, 45, 8),
  Ocena_klientow = c(0, 0.5, 1, 1.5)
)
smartfony <- rbind(smartfony, nowe_smartfony)
library(plotrix)
oceny_klientow <- as.numeric(levels(smartfony$Ocena_klientow))
counts <- table(smartfony$Ocena_klientow)
barplot(counts, names.arg = oceny_klientow, main = "Liczba reprezentantow dla kazdej oceny klientow",
        xlab = "Ocena klientow", ylab = "Liczba reprezentantow", col = "skyblue")

# (m)
library(plotrix)
liczba_ocen <- table(smartfony$Ocena_klientow)
procenty_ocen <- prop.table(liczba_ocen) * 100
pie(procenty_ocen, labels = names(procenty_ocen), main = "Procentowy udzial kazdej oceny klientow")
fan.plot(procenty_ocen, labels = names(procenty_ocen), main = "Procentowy udzial kazdej oceny klientow")

# (n)
smartfony$status_opinii <- cut(smartfony$Liczba_opinii, breaks = c(-Inf, 0, 50, 100, Inf),
                               labels = c("nie ma", "mniej 50 opinii", "50-100 opinii", "wiecej 100 opinii"))
smartfony$status_opinii <- as.factor(smartfony$status_opinii)
print(smartfony)
library(plotrix)
status_opinii_prop <- prop.table(table(smartfony$status_opinii)) * 100
pie(status_opinii_prop, labels = names(status_opinii_prop), main = "Procentowy udzial w statusach opinii")

# (o)
zdania_o_smartfonach <- paste(smartfony$Nazwa, "ma ocene klientow", smartfony$Ocena_klientow,
                              "bo ma liczbe opinii", smartfony$Liczba_opinii, sep = " ")
cat(zdania_o_smartfonach, sep = "\n")

# (p)
write.csv(smartfony, file = "smartfony.csv", row.names = FALSE)
wczytane_smartfony <- read.csv("smartfony.csv")
print(wczytane_smartfony)