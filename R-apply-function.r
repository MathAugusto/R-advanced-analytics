#Importando os 4 DataFrames que serão usados(row.names=1 para não considerar como coluna da tabela):

chicago <- read.csv("weather-data/Chicago-C.csv",row.names=1)

houston <- read.csv("weather-data/Houston-C.csv",row.names=1)

newyork <- read.csv("weather-data/NewYork-C.csv",row.names=1)

sanfrancisco <- read.csv("weather-data/SanFrancisco-C.csv",row.names=1)

head(chicago)

head(houston)

head(newyork)

head(sanfrancisco)

# Tranformando os DataFrames em Matrizes
chicago <- as.matrix(chicago)
houston <- as.matrix(houston)
newyork <- as.matrix(newyork)
sanfrancisco <- as.matrix(sanfrancisco)

# Colocando todas as matrizes em uma Lista
Weather <- list(chicago=chicago,houston=houston,newyork=newyork,sanfrancisco=sanfrancisco)

Weather

# Função apply(data,linha ou coluna,função)
# para aplicar por linhas: apply(M,1, mean)
# para aplicar por colunas:apply(M,2, mean)
apply(chicago,1,mean)

apply(houston,1,mean)

apply(newyork,1,mean)

apply(sanfrancisco,1,mean)

# Aplica apply() em listas e vetores

# Fazendo matriz transposta utilizando a função lapply()
nova_lista <- lapply(Weather, t) 

nova_lista

# ROWMEANS() mais facil que aplicar 4x apply(data,1,mean)
lapply(Weather, rowMeans)
# Existem outras, exemplos:
#rowMeans
#colMeans
#rowSums
#colSums

# Extrair a temperatura mais alta de janeiro de todas as cidades SEM o lapply():
Weather[[1]][1,1]
Weather[[2]][1,1]
Weather[[3]][1,1]
Weather[[4]][1,1]

# Usando lapply()
lapply(Weather,"[",1,1)

# Usando lapply() todos os valores do mês de março
lapply(Weather,"[", ,3)

mean(Weather$chicago[[2]][1])

Weather

# Exibir a primeira linha de todas as cidades (AvgHigh_C) todos os meses do ano
lapply(Weather, function(x) x[1,])

# Exibir dados o mês de dezembro de todas as cidades
lapply(Weather, function(x) x[,12])

# Mostrando a diferença da temperatura max x min / min 
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))



# Sapply (mesma funçao que acima, so trocando o lapply por sapply)
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))

round(sapply(Weather, rowMeans), 2)

# MÁXIMO de cada coluna de cada cidade:
sapply(Weather, apply, 1, max)

# MÍNIMO de cada coluna de cada cidade:
sapply(Weather, apply, 1, min)

# Retorna a posiçao e valor do MAIOR valor da linha selecionada
which.max(chicago[1,])

sapply(Weather, function(y) apply(y,1,function(x) names(which.max(x))))

sapply(Weather, function(y) apply(y,1,function(x) names(which.min(x))))
