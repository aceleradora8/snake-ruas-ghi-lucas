require 'io/console'
###############################
=begin
Funcionalidades faltantes:
  parede de baixo não está com verificação quando bate gera erro
  X não esta andando reto
  X não está aumentando de tamanho quando pega comida
=end
#INICIANDO A MATRIZ
matriz = Array.new(7, '-') { Array.new 15, '-' }

@flag = true
@eixo_x_da_cobra = 0
@eixo_y_da_cobra = 0
matriz[0][0] = "X"
@eixo_x_da_comida = rand(14)
@eixo_y_da_comida = rand(6)
@eixo_x_da_comida = @eixo_x_da_comida.to_i
@eixo_x_da_comida = @eixo_y_da_comida.to_i
matriz[@eixo_x_da_comida][@eixo_y_da_comida] = "o"
@comida = 0

###############################
#Metodo de impressao
def imprimir (matriz, comida)
  system 'clear'
  puts"Bem Vindo ao jogo da Cobrinha!"
  puts "Para mover digite A,W,D ou S e Q para sair"

  (0..6).each do |linha|
    puts " "
    print "  "
    matriz[linha].each { |coluna| print "#{coluna}" }
  end

  puts " "
  puts "Comida: #{comida}"
end

def mover(matriz, letra, linha, coluna)
  matriz[linha][coluna] = "-"
  case letra.downcase
    when 's'
      mover_para_baixo(matriz, linha, coluna)
    when 'w'
      mover_para_cima(matriz, linha, coluna)
    when 'd'
      mover_para_a_direita(matriz, linha, coluna)
    when 'a'
      mover_para_a_esquerda(matriz, linha, coluna)
  end
end

def mover_para_baixo(matriz, linha, coluna)
  if linha < 7
    matriz[linha + 1][coluna] = "X"
    linha += 1
    @eixo_x_da_cobra = linha
  end
end

def mover_para_cima(matriz, linha, coluna)
  if linha > -1
    matriz[linha - 1][coluna] = "X"
    linha -= 1
    @eixo_x_da_cobra = linha
  end
end

def mover_para_a_direita(matriz, linha, coluna)
  if coluna < 15
    matriz[linha][coluna + 1] = "X"
    coluna += 1
    @eixo_y_da_cobra = coluna
  end
end

def mover_para_a_esquerda(matriz, linha, coluna)
  if coluna > -1
    matriz[linha][coluna - 1] = "X"
    coluna -= 1
    @eixo_y_da_cobra = coluna
  end
end

###############################
#SAIDA
def sair (letra)
  @flag = false if letra.downcase.eql? 'q'
end
###############################
#GERAR COMIDA
def gera_comida(mat)
  if @eixo_x_da_comida==@eixo_x_da_cobra && @eixo_y_da_comida ==@eixo_y_da_cobra
   @eixo_x_da_comida=rand(14)#linha
   @eixo_y_da_comida=rand(6)#coluna
   @eixo_x_da_comida=@eixo_x_da_comida.to_i
   @eixo_x_da_comida=@eixo_y_da_comida.to_i
   while @eixo_x_da_comida==@eixo_x_da_cobra && @eixo_y_da_comida==@eixo_y_da_cobra#para n gerar comida em cima do X
     @eixo_x_da_comida=rand(14)#linha
     @eixo_y_da_comida=rand(6)#coluna
     @eixo_x_da_comida=@eixo_x_da_comida.to_i
     @eixo_y_da_comida=@eixo_y_da_comida.to_i
   end
   mat[@eixo_x_da_comida][@eixo_y_da_comida] = "o"
   @comida+=1
  end
end
###############################
#PERDER NA PAREDE
def parede()
  if @eixo_x_da_cobra<0||@eixo_y_da_cobra<0||@eixo_y_da_cobra>14
    puts "Voce Perdeu!"
    @flag = false
  end
end
###############################
#INICIANDO METODOS
while(@flag)
    imprimir(matriz, @comida)
    letra = STDIN.getch.chomp
    mover(matriz,letra, @eixo_x_da_cobra, @eixo_y_da_cobra)
    sair(letra)
    gera_comida(matriz)
    parede()
end#fim while
##############################

