util <- read.csv("P3-Machine-Utilization.csv")

head(util, 10)

summary(util)

# Criando nova coluna
util$Utilization <- 1-util$Percent.Idle 
head(util, 10)

# Handling Data-Times com POSIXct()
util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")

head(util,10)

summary(util)

# Removendo coluna
util$Timestamp <- NULL

head(util,10)

# Mundando colunas de posição [c(linhas),c(colunas)]
util <- util[,c(4,3,2,1)]

head(util,10)

summary(util)

# Lists
RL1 <- util[util$Machine == "RL1",]

summary(RL1)

RL1$Machine <- factor(RL1$Machine)

summary(RL1)

# LISTAS 
# Utilização Mensal (excluindo valores N/A)
util_stats_rl1 <- c(min(RL1$Utilization, na.rm=TRUE),
                    mean(RL1$Utilization, na.rm=TRUE),
                    max(RL1$Utilization, na.rm=TRUE))

util_stats_rl1

# Quantidade de vezes que esteve abaixo de 90%
util_under_90_flag <- length(which(RL1$Utilization < 0.90)) > 0
util_under_90_flag

# Criando uma lista
lista1 <- list("RL1",util_stats_rl1,util_under_90_flag)
lista1

# Criando uma lista e atribuindo nome para colunas:
# lista1 <- list(Machine="RL1",Stats=util_stats_rl1,LowThreshold=util_under_90_flag)

# Nomeando as colunas da lista
names(lista1) <- c("Machine","Stats","LowThreshold")

lista1

# Acessar elementos da lista, TIPO 1
lista1[2]
typeof(lista1[2])

# Acessar elementos da lista, TIPO 2
lista1[[2]]
typeof(lista1[[2]])

# Acessando o terceiro elementos da lista, TIPO 3
lista1$Stats[3]
typeof(lista1$Stats[3])

# Adicionando novo componente
lista1[4] <- "New Information"
lista1

# Deletando novo componente
lista1[4] <-NULL

# Criando lista de datas com Utilization == NA
lista1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
lista1

lista1$Data <- RL1
head(lista1,5)

summary(lista1)

# Subsets:
sub_set <- lista1[c("Machine","Stats")]
sub_set

# TIMESERIES PLOT
library("ggplot2")

head(util)

p <- ggplot(data=util)
p + geom_line(aes(x=PosixTime,y=Utilization,
                 colour=Machine),size=0.8) +
    facet_grid(Machine~.) +
    geom_hline(yintercept=0.90, colour="Gray", size=1.2, linetype=3)
