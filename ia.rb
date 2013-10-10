#!/usr/bin/ruby

=begin
Este es el método para mostrar el array
=end

class Matriz

	def initialize(t)
		@a=Array.new(t.to_i,'*'){Array.new(t.to_i,'*')}
		
		for i in (0..@a.length-1)
			@a[i][0]='H'		
		end
		
		for i in (0..@a.length-1)
			@a[0][i]='H'		
		end

		for i in (0..@a.length-1)
			@a[@a.length-1][i]='H'		
		end

		for i in (0..@a.length-1)
			@a[i][@a.length-1]='H'		
		end	
	end

	def get_Matriz
		matriz=@a
		return matriz
	end


	def mostrar_Matriz
		for y in(0..@a.length-1)
			
			for x in(0..@a.length-1)
				
				print "#{@a[y][x]} "
				
				
			end
			puts "\n"
			
		end
	
	end

	def poner_Objetos(obj, t)
		t=t-2

		for i in(0...obj.to_i)
			x=1+rand(t)
			y=1+rand(t)

			while @a[y][x] == [1][1]
				x=1+rand(t)
				y=1+rand(t)
			end	
			@a[x][y]='O'	
		end

	end

end

class Cortador < Matriz

	def initialize(m)
		@matriz=m		
		@x=1
		@y=0
		@matriz[@y][@x]='L'
		@u_posiciones=Array.new()
		@reciclaje=Array.new()
		@pos=0
		@pos1=0
		@pudo_mover=false
	end

	def mover 
			if (@matriz[@y-1][@x]=='*') #Arriba
				@matriz[@y][@x]='x'
				@y=@y-1
				@matriz[@y][@x]='L'
				@pudo_mover=true
			elsif (@matriz[@y][@x-1]=='*')#izquierda
				@matriz[@y][@x]='x'
				@x=@x-1
				@matriz[@y][@x]='L'
				@pudo_mover=true
			elsif (@matriz[@y+1][@x]=='*')#abajo
				@matriz[@y][@x]='x'
				@y=@y+1
				@matriz[@y][@x]='L'
				@pudo_mover=true
			elsif (@matriz[@y][@x+1]=='*')#derecha
				@matriz[@y][@x]='x'
				@x=@x+1
				@matriz[@y][@x]='L'
				@pudo_mover=true	
			else	
				@matriz[@y][@x]='x'				
				@pudo_mover=false		
			end
		
			if @pudo_mover==true
				@u_posiciones[@pos]=[@y,@x,'']
				@pos=@pos+1
			else	
				@t= (@u_posiciones.length-1)
				
				puts "entro"
				puts @t					
					
					if @u_posiciones[@t][2]!='*'
						@u_posiciones[@t][2]='*'
						@t=@t-1	
						@x=@u_posiciones[@t][1]
						@y=@u_posiciones[@t][0]	
						#@pos=@pos-1	
					end	
						
					puts "entro2"			
					@matriz[@y][@x]='L'
			end
		if (@u_posiciones==[])
			return true	
		else
			return false
		end
		
	end

	def get_posiciones

		posiciones=@u_posiciones
		return posiciones.drop(0)	
	end

=begin
Este es el método para mostrar el array
=end

print "Cual es el tamaño del terreno\n"
STDOUT.flush
t=gets.chomp

print "Cuantos objetos desea poner\n"
STDOUT.flush
o=gets.chomp

matriz= Matriz.new(t)
matriz.poner_Objetos(o,t.to_i)
cortador=Cortador.new(matriz.get_Matriz)



cortado=false	
	
	while (cortado!=true)  
		matriz.mostrar_Matriz
		cortado=cortador.mover
		sleep(0.7)		
		system'clear' 
		puts "\n---------------------\n"
		print cortador.get_posiciones
		puts "\n---------------------\n"
	end
