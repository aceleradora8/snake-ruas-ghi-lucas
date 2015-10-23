require 'io/console'

###############################
=begin
Funcionalidades faltantes:
  parede de baixo não está com verificação quando bate gera erro
  X não esta andando reto
  X não está aumentando de tamanho quando pega comida
=end
#INICIANDO A @matriz
@matriz = Array.new
@matriz = [[],[],[],[],[],[],[]]
15.times{@matriz[0] << "-"}
15.times{@matriz[1] << "-"}
15.times{@matriz[2] << "-"}
15.times{@matriz[3] << "-"}
15.times{@matriz[4] << "-"}
15.times{@matriz[5] << "-"}
15.times{@matriz[6] << "-"}
@T1
@T2
@V = true
@lin = 0
@con = 0
@letra ="d"
@matriz[0][0]= "X"
@x = rand(14)
@y = rand(6)
@x=@x.to_i
@x=@y.to_i
@matriz[@x][@y] = "o"
@comida = 0
###############################
#Metodo de impressao
def imprimir (mat,com)
system 'clear'#LIMPA A TELA
puts"Bem Vindo ao jogo da Cobrinha!"
puts "Para mover digite A,W,D ou S e Q para sair"
print "\n  "
mat[0].each {|l|print "#{l}"}
print "\n  "
mat[1].each {|l|print "#{l}"}
print "\n  "
mat[2].each {|l|print "#{l}"}
print "\n  "
mat[3].each {|l|print "#{l}"}
print "\n  "
mat[4].each {|l|print "#{l}"}
print "\n  "
mat[5].each {|l|print "#{l}"}
print "\n  "
mat[6].each {|l|print "#{l}"}
puts " "
puts "Comida: #{com}"
end
###############################
#MOVIMENTO
def mover(mat,letra,lin,con)
  #Mover para baixo
  if letra =="s"&&lin<7
    mat[lin][con]="-"
    mat[lin+1][con]="X"
    lin += 1
    @lin = lin
  end
  #Mover para cima
  if letra =="w"&&lin>-1
    mat[lin][con]="-"
    mat[lin-1][con]="X"
    lin -=1
    @lin=lin
  end
  #Mover para direita
  if letra =="d"&&con<15
    mat[lin][con]="-"
    mat[lin][con+1]="X"
    con +=1
    @con=con
  end
  #Mover para esquerda
  if letra =="a"&&con>-1
    mat[lin][con]="-"
    mat[lin][con-1]="X"
    con -=1
    @con=con
  end
end
###############################
#SAIDA
def sair (l)
  if l == "q" || l == "Q"
    @V=false
  end
end
###############################
#GERAR COMIDA
def gera_comida(mat)
  if @x==@lin && @y ==@con
   @x=rand(14)#linha
   @y=rand(6)#coluna
   @x=@x.to_i
   @x=@y.to_i
   while @x==@lin && @y==@con#para n gerar comida em cima do X
     @x=rand(14)#linha
     @y=rand(6)#coluna
     @x=@x.to_i
     @x=@y.to_i
   end
   mat[@x][@y] = "o"
   @comida+=1
  end
end
###############################
#PERDER NA PAREDE
def parede()
  if @lin<0||@con<0||@con>14
    puts "Voce Perdeu!"
    @V=false
  end
end
###############################
#INICIANDO METODOS


@T1 = Thread.new do
	@letra = $stdin.getch.chomp 
   while(@V)
      @letra = $stdin.getch.chomp
    exit if @letra == 'q'
  end
end

@T2 = Thread.new do
  while(@V)
    imprimir(@matriz,@comida)
    #sleep(1)
  end
end#fim thread


while(@V)
sair(@letra)
gera_comida(@matriz)
parede()
  while((@letra == "d"|| @letra == "a"|| @letra == "s"|| @letra == "w")&&(@V))
    mover(@matriz,@letra,@lin,@con)
    sleep(1)
    sair(@letra)
    gera_comida(@matriz)
    parede()#<<
  end
end#fim while
##############################
