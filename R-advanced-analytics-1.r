# Import do dataset e tranformando valores vazios em NA para trata-los no futuro
fin <- read.csv('Future-500.csv', na.strings=c(""))

head(fin,3)

str(fin)

summary(fin)

# non-factor to factor
fin$ID <- factor(fin$ID)

# non-factor to factor
fin$Inception <- factor(fin$Inception)
str(fin)

# Tirando caracteres indesejados 
fin$Expenses <- gsub('Dollars','',fin$Expenses)
fin$Expenses <- gsub(',','',fin$Expenses)

fin$Revenue <- gsub(',','',fin$Revenue)
fin$Revenue <- gsub('\\$','',fin$Revenue)

fin$Growth <- gsub('%','',fin$Growth)

str(fin)

# Transformando caracteres indesejados 
fin$Expenses <- as.numeric(fin$Expenses)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)

str(fin)

# Verificar linhas onde existem valores missing/NA
fin[!complete.cases(fin),]

# Filtrar sem uar o which()
fin[fin$Employees == 45,]

# Usar o which() para filtrar apenas valores do dataframe que não aparecerem como N/A's
fin[which(fin$Employees == 45),]

# Acha valores missing em uma determinada coluna 
fin[is.na(fin$Expenses),]

# Removendo linhas com dados missing
fin_backup <- fin # Caso algo dê errado
# Passar de volta para o data frame a coluna selecionada (mas com !, para passar somente os que não são N/A)
fin <- fin[!is.na(fin$Industry),]
head(fin, 20)
# linhas 14 e 15 que continham valor Industry faltando, foram removidas

# Fazendo um Reset do index do dataframe (caso precise )
rownames(fin) <- NULL
tail(fin, 20) # Agora o index vai até 498

# Preechendo missing data (antes de preencher)
fin[is.na(fin$State) & fin$City == "New York",]

# Preechendo missing data (depois de preencher)
fin[is.na(fin$State) & fin$City == "San Francisco", "State"] <- "CA"
fin[is.na(fin$State) & fin$City == "New York", "State"] <- "NY"
# check
fin[c(11,377),]

fin[!complete.cases(fin),]

# Criando variavel para preencher o missing data com a mediana
median_retail <- median(fin[fin$Industry == "Retail", "Employees"], na.rm=TRUE)
median_financial <- median(fin[fin$Industry == "Financial Services", "Employees"], na.rm=TRUE)
median_growth_const <- median(fin[fin$Industry == "Construction", "Growth"], na.rm=TRUE)

# Passando a mediana para os valores N/A
fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"] <- median_retail
fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"] <- median_financial
fin[is.na(fin$Growth) & fin$Industry == "Construction", "Growth"] <- median_growth_const

# Checando retail
fin[3,]

# Checando financial
fin[330,]

# Checando growth_Construction
fin[8,]

# Criando variavel para preencher o missing data com a mediana( COLUNA Revenue E COM Industry == Construction)
median_rev_const <- median(fin[fin$Industry == "Construction", "Revenue"], na.rm=TRUE)
fin[is.na(fin$Revenue) & fin$Industry == "Construction", "Revenue"] <- median_rev_const

# Criando variavel para preencher o missing data com a mediana( COLUNA Expenses E COM Industry == Construction)
median_exp_const <- median(fin[fin$Industry == "Construction", "Expenses"], na.rm=TRUE)
fin[is.na(fin$Expenses) & fin$Industry == "Construction" & is.na(fin$Profit),"Expenses"] <- median_exp_const

# Passando o resultado de um cálculo para as linhas Profit N/A
fin[is.na(fin$Profit),"Profit"] <- fin[is.na(fin$Profit),"Revenue"] - fin[is.na(fin$Profit),"Expenses"]

# Passando o resultado de um cálculo para as linhas Expenses N/A
fin[is.na(fin$Expenses),"Expenses"] <- fin[is.na(fin$Expenses),"Revenue"] - fin[is.na(fin$Expenses),"Profit"]

install.packages("ggplot2")
library(ggplot2)

fin[!complete.cases(fin),]

# Visualização dos dados
# Scatterplot classificando por industria, mostrando revenue x expenses, e size = profit
p <- ggplot(data=fin)
p + geom_point(aes(x=Revenue,y=Expenses,
                  color=Industry, size=Profit))

# Scatterplot classificando por industria, mas inclui a relaçao mostrando as tendencias de revenue x expenses
d <- ggplot(data=fin, aes(x=Revenue,y=Expenses,
                  color=Industry))
d + geom_point() + 
    geom_smooth(fill=NA, size=1.2)

# Boxplot + jitter mostrando os resultados de crescimento por indústria
f <- ggplot(data=fin, aes(x=Industry,y=Growth,
                  color=Industry))
f + geom_jitter(size=0.5) +
geom_boxplot(size=1,alpha=0.5,outlier.color=NA)
