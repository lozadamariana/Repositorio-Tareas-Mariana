### A Pluto.jl notebook ###
# v0.19.22

using Markdown
using InteractiveUtils

# ╔═╡ 11874950-e260-11ed-0336-3563c0241ca2
md"## Ejercicio 3: Torres de Hanoi

1. _Diseña un algoritmo que resuelva este problema y justifica (no es necesario escribir una demostración) por qué devuelve el número mínimo de movimientos. Represéntalo en pseudocódigo o diagrama de flujo (4 puntos)._ 
2. _Implementa el algoritmo en Julia. Tu programa será aceptado si devuelve las respuestas correctas para cada n, con 1 ≤ n ≤ 16._ 
 "

# ╔═╡ 902d9eea-29ce-4e77-bbd7-d89ece5111a5
md" El pseudocódigo para resolver el problema se ve de la siguiente manera:

	1. Con una serie de movimientos, mover los primeros n-1 discos a la torre central
	2. Mover el disco n a la torre de la derecha
	3. Con una serie de movimientios, mover los n-1 discos a la torre derecha

Estos tres pasos utilizandolos de manera recursiva y respetando que un disco más grande siempre va abajo, es como funciona el problema. 

Ahora, para conocer el número mínimo de movimientos, basta con fijarse en los primeros casos:

-> Cuando se tiene un disco, se realizará un movimiento, el disco 1 a la torre derecha.

-> Cuando se tienen 2 discos, el disco 1 va a la torre central, el disco 2 a la torre derecha y por último, el disco 1 a la torre derecha. En este caso, se necesitaron de 3 pasos.

-> Cuando se tienen 3 discos, el disco 1 va a la torre derecha, el disco 2 a la torre central, el disco 1 a la torre central, el disco 3 a la torre derecha, el disco 1 nuevamente a la torre izquierda, el disco 2 a la torre derecha y el disco 1 a la torre derecha. En este caso se necesitaron de 7 pasos.

Por lo que nos damos cuenta que existe un patrón; siendo n el número de discos, el número mínimo de pasos saldrá de la expresión: 
				2^n -1
"

# ╔═╡ 59893233-bf01-42ec-bf46-7e874ba8c7f6
begin
	function movimientos(n, t_izquierda, t_derecha, t_central) #Establecemos una función con las variables de las torres y "n" el número de discos	
		
		if n == 1  #Establecer un caso base
			disco(t_izquierda, t_derecha) #solo mueve el disco de la torre izquierda a la derecha
			
		else
			movimientos(n-1, t_izquierda, t_central, t_derecha) #se mueven todos los discos a la torre central, menos el disco n
			disco(t_izquierda, t_derecha) #mueve el disco n a la torre derecha
			movimientos(n-1, t_central, t_derecha, t_izquierda) #movemos los discos n-1 de la torre central, a la torre derecha (porque ahora todos los discos n-1 están en la torre central, por eso se cambia el orden)
		end
	end
	
	function disco(desde, hacia) #imprime que se esta moviendo un disco de una torre hacia la otra 
		println("mover disco de ", desde, " a ", hacia, " ")
	end
end

# ╔═╡ a5909f08-eebe-475d-80a3-8e19f2029f35
begin 
	n = 1
	movimientos(n, "1", "3", "2")
 	K = (2^n -1) 
	print("el número de movimientos mínimos es ")
	print(K)
end

# ╔═╡ Cell order:
# ╟─11874950-e260-11ed-0336-3563c0241ca2
# ╠═902d9eea-29ce-4e77-bbd7-d89ece5111a5
# ╠═59893233-bf01-42ec-bf46-7e874ba8c7f6
# ╠═a5909f08-eebe-475d-80a3-8e19f2029f35
