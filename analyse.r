setwd("~/your-path/unicamp-salarios")

# Lendo a tabela processada do pdf
wage_table = read.table("processed.txt", header = TRUE, sep = "\t") 

rem_bruta = wage_table$Remuneracao.Bruta

# Distribuicão de remuneracões (bruto)
hist(rem_bruta, breaks = 200, 
     col = "black", main = "Remuneracão Bruta Unicamp",
     ylab = "Frequ?ncia", xlab = "Valor")

# Maior (e menor) remuneracão Bruta e matrícula correspondente:
# maior
print(max(rem_bruta))
max_index = which(rem_bruta == max(rem_bruta))
print(wage_table$Matricula[max_index])
# menor
print(min(rem_bruta))
min_index = which(rem_bruta == min(rem_bruta))
print(wage_table$Matricula[min_index])

# Quantos estão acima do teto:
over = which(rem_bruta > 21631.05)
tot_over = length(over)
print(tot_over)
print(tot_over/length(wage_table$Matricula) * 100)

# Soma dos salários e parcela que está acima do teto:
# total
print(sum(rem_bruta)) 
print(sum(rem_bruta) * 13)
# acima do teto
montante_acima = sum(rem_bruta[over]) - length(over) * 21631.05
print(montante_acima)
print(montante_acima * 13)
# proporcão:
print(montante_acima/sum(rem_bruta) * 100)










