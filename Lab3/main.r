# library(neuralnet)
#
# prepare_data <- function(n) {
#   x <- seq(1, 10, length.out = n)
#   y <- x - 1/4
#   data.frame(x = x, y = y)
# }
#
# set.seed(123)
# training_data <- prepare_data(100)
#
# model <- neuralnet(y ~ x, data = training_data, hidden = c(5, 3), linear.output = TRUE)
#
# plot(training_data$x, training_data$y, col = "blue", type = "l", lwd = 2, xlab = "x", ylab = "f(x)")
# lines(training_data$x, predict(model, newdata = training_data), col = "red", lty = 2, lwd = 2)
# legend("topright", legend = c("Rzeczywista funkcja", "Sieć neuronowa"), col = c("blue", "red"), lty = 1:2, lwd = 2)

# library(neuralnet)
#
# dane <- read.csv("dane.csv")
#
# cechy <- dane[, 1:(ncol(dane)-1)]
# ceny <- dane[, ncol(dane)]
#
# cechy <- scale(cechy)
# ceny <- scale(ceny)
#
# set.seed(42)
# indeksy <- sample(1:nrow(dane), 0.8 * nrow(dane))
# cechy_treningowe <- cechy[indeksy, ]
# ceny_treningowe <- ceny[indeksy]
# cechy_testowe <- cechy[-indeksy, ]
# ceny_testowe <- ceny[-indeksy]
#
# model <- neuralnet(ceny_treningowe ~ ., data = cbind(cechy_treningowe, ceny_treningowe), hidden = c(5, 5))
#
# wyniki <- predict(model, newdata = cechy_testowe)
#
# blad <- mean((wyniki - ceny_testowe)^2)
# print(paste("Błąd średniokwadratowy: ", blad))
#
# plot(ceny_testowe, col = "red", ylim = range(c(ceny_testowe, wyniki)))
# points(wyniki, col = "blue")
# legend("topright", legend = c("Rzeczywiste ceny", "Przewidywane ceny"), col = c("red", "blue"), pch = 1)


library(neuralnet)

data <- read.csv("dane.csv")

features <- data[, c("Wyswietlacz", "Pamiec_RAM", "Pamiec_wbudowana", "Aparat_foto", "Liczba_opinii", "Ocena_klientow")]
target <- data$Cena

set.seed(123)
split_ratio <- 0.8
num_samples <- nrow(data)
train_indices <- sample(1:num_samples, size = round(split_ratio * num_samples))

train_data <- features[train_indices, ]
train_target <- target[train_indices]

test_data <- features[-train_indices, ]
test_target <- target[-train_indices]


model <- neuralnet(Cena ~ Wyswietlacz + Pamiec_RAM + Pamiec_wbudowana + Aparat_foto + Liczba_opinii + Ocena_klientow,
                   data = data.frame(Cena = train_target, train_data),
                   hidden = c(5, 3), # Liczba neuronów w warstwach ukrytych
                   linear.output = TRUE)

predictions <- predict(model, newdata = test_data)

results <- data.frame(Przewidywana_Cena = predictions, Rzeczywista_Cena = test_target)
print(results)

