setwd("D:\\Projetos & Estudos\\Side Projects\\unicamp-salarios")

#Lendo a tabela processada do pdf
wage_table = read.table("processed.txt", header = TRUE, sep = "\t") 

rem_bruta = wage_table$Remuneracao.Bruta

#Distribui��o de remunera��es (bruto)
hist(rem_bruta, breaks = 200, 
     col = "black", main = "Remunera��o Bruta Unicamp",
     ylab = "Frequ�ncia", xlab = "Valor")

#Maior (e menor) remunera��o Bruta e matr�cula correspondente:
#maior
print(max(rem_bruta))
max_index = which(rem_bruta == max(rem_bruta))
print(wage_table$Matricula[max_index])
#menor
print(min(rem_bruta))
min_index = which(rem_bruta == min(rem_bruta))
print(wage_table$Matricula[min_index])

#Quantos est�o acima do teto:
over = which(rem_bruta > 21631.05)
tot_over = length(over)
print(tot_over)
print(tot_over/length(wage_table$Matricula) * 100)

#Soma dos sal�rios e parcela que est� acima do teto:
#total
print(sum(rem_bruta)) 
print(sum(rem_bruta) * 13)
#acima do teto
print(sum(rem_bruta[over]))
print(sum(rem_bruta[over]) * 13)
#propor��o:
print(sum(rem_bruta[over])/sum(rem_bruta) * 100)










