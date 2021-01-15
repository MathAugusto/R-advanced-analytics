# importando e vendo os dados e suas descrições
data <- read.csv("Churn.csv", sep = ";", na.strings = "", stringsAsFactors = T)
head(data)
summary(data)

# nomeando as colunas do DataFrame
colnames(data) = c("id", "score", "estado", "genero", "idade",
                   "patrimonio", "saldo", "produtos", 
                   "temCartCredito", "ativo","salario", "saiu" )
head(data)

# ANÁLISE EXPLORATÓRIA 
# Começar pelos DADOS CATEGÓRICOS - Usando BarPlot
# Estado
counts = table(data$estado)
barplot(counts, main = "estado", xlab = "estado")
# Gênero
counts = table(data$genero)
barplot(counts, main = "genero", xlab = "genero")

# DADOS NUMÉRICOS (para verificar anormalidades nos valores)
# Score
summary(data$score)
boxplot(data$score)
histogram(data$score)
# Idade
summary(data$idade)
boxplot(data$idade)
histogram(data$idade)
# Saldo
summary(data$saldo)
boxplot(data$saldo)
histogram(data$saldo)
# Salario
summary(data$salario)
boxplot(data$salario)
histogram(data$salario)

# Vendo os campos com valor faltante
# Usando !complete.cases (aplicando o oposto da função com o sinal de "!") 
data[!complete.cases(data),]
# Salario-----------------------------------------------------------------------
summary(data$salario)
# Ver mediana
median(data$salario, na.rm = T)
# Atribuindo nos N/A's
data[is.na(data$salario),]$salario = median(data$salario, na.rm = T)
# Genero------------------------------------------------------------------------
unique(data$genero)
summary(data$genero)
# Tranformando os dados
data[is.na(data$genero) | data$genero == "M",]$genero = "Masculino"
data[data$genero == "Fem" | data$genero == "F",]$genero = "Feminino"
# Remover levels nao usados e tranformar em factor
data$genero = factor(data$genero)
# Idade-------------------------------------------------------------------------
summary(data$idade)
# obter valores anormais
data[data$idade < 0 | data$idade > 110,]$idade
# retirar os valores anormais caso precise calcular a MEDIA(eu usei a MEDIANA):
# Não interfere no resultado da mediana
idade_certa <- data[data$idade > 0 | data$idade < 110,]$idade
# mediana da "idade_certa"
median(idade_certa)
# aplicar mediana "idade_certa" nos valores anormais
data[data$idade < 0 | data$idade > 110,]$idade <- median(idade_certa)
# Verificar
summary(data$idade)
# ID----------------------------------------------------------------------------
# ID's duplicados salvos em x
x <- data[duplicated(data$id),]
x
# Para apagar todas linhas duplicadas ::: data <- data[ !data$id %in% c(x$id),]
# OU 
# Para selecionar linhas duplicadas, coloca-las no array c() :::
data <- data[-c(82),]
# Verificar
x <- data[duplicated(data$id),]
x
# ESTADO------------------------------------------------------------------------
# Estados com nome errado ou fora do eixo (regiao Sul do Brasil, nesse caso)
unique(data$estado)
summary(data$estado)
# Passando os a MODA dos estados(RS) para os valores invalidos:
data[ !data$estado %in% c("RS","SC","PR"),]$estado = "RS"
# Transformando em factor para remover levels nao usados:
data$estado <- factor(data$estado)
# Conferindo:
summary(data$estado)
# SALARIO-----------------------------------------------------------------------
# CRIANDO UM OUTLIER PARA SALARIOS FORA DO PADRAO (SUBSTITUIR COM A MEDIANA)
# Caso salario seja mais que 2x o desvio padrao do salario:
desv <- sd(data$salario, na.rm = TRUE)
# Valores que ficam fora da metrica criada:
data[data$salario >= 2 *desv, ]$salario
# mediana dos salarios:
median(data$salario)
# Atribuindo mediana para os valores filtrados:
data[data$salario >= 2 *desv, ]$salario <- median(data$salario)
# Checar:
data[data$salario >= 2 *desv, ]$salario
# Desvio padrao dos salarios:
desv



