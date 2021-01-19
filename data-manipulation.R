# DATA MANIPULATION

# Instalar pacote dplyr para limpar dados
install.packages('dplyr')
library(dplyr)
# Instalar pacote nycflights13 para acessar um grande dataset
install.packages('nycflights13')
library(nycflights13)
head(flights)
summary(flights)

# FUNÇÕES DO DPLYR:
# Filter: data frame, colunas filtradas,
head(filter(flights, month ==11, day==3, carrier=='AA'))
# Slice: selciona as rows pela posição
slice(flights, 1:7)
# Arrange: semelhante ao filtro, mas ele ordena os resultados apenas:
# usar desc(ordena ao contrario)
head(arrange(flights, year, month, day, desc(arr_time)))
# Select: seleciona subconjuntos para variáveis numéricas
head(select(flights, carrier, arr_time))
# Rename: Renomear colunas, mas passada de uma forma "diferente"
head(rename(flights, airline_carrier = carrier))
# Distinct: valores distintos ou unicos de uma coluna ou tabela
distinct(select(flights, carrier))
# Mutate: adiciona novas colunas
mutate((flights, new_col = arr_delay * dep_delay))
# Transmutate:  retorna a nova coluna criada
head(transmutate((flights, new_col = arr_delay * dep_delay)))
# Summarise: permite obter resultados de linhas agregando alguma função:
# (dataframe, nova coluna = função e parametros adicionais)
summarise(flights, mean_air_time = mean(air_time, na.rm = TRUE))
# Sample: Pega linhas aleatórias (quantidade(n) ou porcentagem(frac))
#numero
sample_n(flights, 10)
#porcentagem
sample_frac(flights, 0.10)





