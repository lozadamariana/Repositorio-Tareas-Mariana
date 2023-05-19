### A Pluto.jl notebook ###
# v0.19.22

using Markdown
using InteractiveUtils

# ╔═╡ 9d4d3c67-3d08-4b14-8dcb-eb41649f0c0f
using Plots

# ╔═╡ f4a77582-9121-4881-8139-fcb01d4ef6b9
html"""
<style>
	main {
		margin: 0 auto;
		max-width: 2000px;
    	padding-left: max(160px, 10%);
    	padding-right: max(160px, 10%);
	}
</style>
"""

# ╔═╡ 6f5f31aa-2941-42f5-aceb-bedb2bd30ea2
md"# Caminante aleatorio
Un caminante aleatorio (o _random walk_, en inglés) es un tipo de modelo estocástico en el cual la posición de una partícula en cierto instante depende de su posición en el instante previo y alguna variable aleatoria que determina su subsecuente dirección y la longitud de paso.

Este tipo de modelo es muy útil para hacer simulaciones en Física Estadística; por ejemplo, se puede utilizar para modelar el movimiento browniano de moléculas en un gas.
"

# ╔═╡ 62816dec-c81a-40cb-aebd-8bda77d5e389
md" ## Caminante aleatorio en una dimensión
El modelo más sencillo de un caminante aleatorio es aquel en el que una partícula:
* se mueve en un tiempo discreto y en intervalos de tiempo uniformes;
* se mueve en un espacio discreto de una sola dimensión con tamaño de paso uniforme;
* en cada paso, tiene igual probabilidad de moverse en cualquiera de los dos sentidos posibles.

Los primeros dos puntos son fáciles de modelar: para el primer punto, podemos modelar el tiempo con los números naturales y, para el segundo, podemos modelar el espacio con los números enteros, suponiendo -por simplicidad- que la posición inicial de la partícula es el origen (`0`) y que el tamaño de casa paso es `1`. En otras palabras, para simular el paso del tiempo podemos iterar sobre un arreglo de números naturales consecutivos y, para registar cada posición, podemos crear un arreglo que inicialmente sólo contenga la posición inicial, (`[0]`) y posteriormente añadir las posiciones subsecuentes como entradas a este arreglo.

La cuestión ahora es, ¿cómo modelamos el tercer punto?
"

# ╔═╡ 6dd575bd-5ee7-49ab-8234-ab83eff83ebf
md"### La función `rand`
Julia tiene varias funciones para generar números aleatorios (puedes consultar su documentación [aquí](https://docs.julialang.org/en/v1/stdlib/Random/#Random-generation-functions)). Una de ellas es `rand`. Para conocer lo que hace esta función a través de ejemplos, crea celdas individuales para cada uno de los siguientes comandos y ejecuta cada una de ellas varias veces hasta que tengas una idea de qué es lo que hacen:
* `rand()`
* `rand(Int)`
* `rand(Bool)`"

# ╔═╡ d3e89523-095f-4f2f-aa2c-b38887c187eb
md"Ahora, haz lo mismo para los siguientes comandos, creando las nuevas celdas _debajo_ de la celda que define a la variable `n=1` (y arriba del **Ejercicio**) y cambiando el valor de `n` (ejecutando la celda en la que se define) varias veces antes de revisar la documentación de nuevo:
* `rand(n)`
* `rand(Int,n)`
* `rand(Bool,n)`"

# ╔═╡ 712bfc18-334c-470f-8809-1a1388be7b66
n=1

# ╔═╡ 97ec59e8-2d0d-43d3-b2c8-dd74c7020352
md"**Ejercicio** Crea una función `aleatorioUniforme` que tome como argumentos dos números `a` y `b`, y devuelva como salida un número aleatorio distribuido uniformemente en el intervalo $[a,b]\subset\mathbb{R}$. (Sugerencia: Utiliza `rand()` y un poco de aritmética.)"

# ╔═╡ d4caf15c-4f99-44e4-9222-519433799348
# Tu código va aquí :)
begin
	function aleatorioUniforme(a,b) #declaramos la función
	noAleatorio = (a+(b-a)*rand()) #se utiliza la función rand de para generar un número aleatorio. Luego, se multiplica este número 									aleatorio por (b - a) y se le suma a para obtener un número aleatorio en el rango [a, b)
		return noAleatorio #regrese la función noAleatorio
	end
end

# ╔═╡ acc9af92-7e10-41dc-8799-e86c380dc39d
aleatorioUniforme(2,16)

# ╔═╡ 737eb77d-ce3f-4eac-9f38-5cbae8bd2636
md"**Ejercicio** Verifica con un histograma que tu función `aleatorioUniforme` realmente cumpla la propiedad desada. (Pista: ¿Cómo debería verse el histograma?)"

# ╔═╡ dde71c48-f741-4f63-a99e-a10235d58ad5
# ╠═╡ disabled = true
#=╠═╡
using Plots
  ╠═╡ =#

# ╔═╡ 41a80720-ab01-4931-b86f-1c72cf48c993
# Tu código (comentado) va aquí :)
begin
	function histograma(a,b)
	muestras = [aleatorioUniforme(a,b) for _ in 1:5]

	histogram(muestras, title = "Función aleatorioUniforme", xlabel = "Valor aleatorio", ylabel = "frecuencia", legend=histograma)
	end
end

# ╔═╡ a35f7416-8003-4edb-aad1-1ea0de388f67
histograma(2,16)

# ╔═╡ 5eedcedb-7dd6-45b0-8a06-238bf6b358f7
md" ### Modelando una caminata aleatoria

Como estamos modelando el espacio con los números enteros, cada paso sucesivo de nuestro caminante aleatorio debería sumar o restar `1` a la posición anterior con igual probabilidad. 

**Ejercicio** Crea una función `unPaso` que no tome argumentos de entrada y devuelva sólamente los valores `1` y `-1` con igual probabilidad. (Pista: La forma más sencilla de hacerlo es usando `rand(Bool)` y un poco de aritmética...)"

# ╔═╡ fc77bf6a-1864-431a-bd9b-0e3a471d81b7
# Tu código va aquí :)
begin
	function unPaso() #declaramos la función y se genera un valor boleano aleatorio
		if rand(Bool) #si el valor aleatorio es verdadero, regresa 1
			return 1
		else  #si el valor aleatorio es falso, regresa -1
			return -1 
		end
	end
end

# ╔═╡ 66146a2e-acaf-4183-bf31-20c92a3be04a
unPaso() #No declaramos nada en la función para que nos devuelva un número aleatorio

# ╔═╡ d3a7fcb3-b0a5-4b41-bf95-ac3ffdce7fb6
md" **Ejercicio** Crea una función `variosPasos` que tome como argumento un número entero positivo `n` y devuelva un arreglo con `n` entradas, donde cada una de ellas tiene la misma probabilidad de ser `1` ó `-1`. (Pista: Recuerda que colocar un punto (`.`) antes de un operador aritmético hace que funcione con arreglos.)"

# ╔═╡ 544fdf8f-fb78-40be-8618-f071c47f00b2
# Tu código va aquí :)
begin
	function variosPasos(n::Int) #condición para que se tome un número entero positivo
		x = Array{Int}(undef, n) 
		for i in 1:n
			if rand(Bool) #generar un valor booleano aleatorio
			x[i] = 1 #si la condición es verdadera, se le asigna el 1
			else 
			x[i] = -1 #si es falsa, se le asiga -1
			end
		end
		print(x) #imprima x
	end
end	

# ╔═╡ 64cf4e1a-8efa-48dc-921a-eb2ddbc7f3e8
variosPasos(3)

# ╔═╡ f2bb54fd-ccb9-4e8d-b8c4-3a4058ffbe4c
md" **Ejercicio** Crea una función `caminataAleatoria` que
* tome como entrada un número de pasos `n` y
* devuelva como salida un arreglo con `n+1` posiciones, incluyendo la posición inicial `0`, simulando una caminata aleatoria. (Sugerencia: Puedes usar cualquiera de las funciones `unPaso` o `variosPasos`; la que te resulte más cómoda.)"

# ╔═╡ 9d09fc0f-ccba-477d-9968-82b9554f44e2
# Tu código (comentado) va aquí :)
begin
	function caminataAleatoria(n::Int) #condición para que se tome un número entero positivo
		pasos = Array{Int}(undef, n+1) #arrelgo del tipo entero con tamaño n+1
		posicion = 0 #comience en la posición 0, esta sera la posición inicial
		pasos[1] = posicion #Se asigna la posición inicial al primer elemento del arreglo

		for i in 2:n+1 #representa los pasos de la caminata comenzando desde el segundo paso hasta el n+1
			if rand(Bool) #generar un número booleano aleatorio
				posicion += 1 #se incrementa la variable 1 en 1 
			else
				posicion -= 1 #se resta la variable de 1 en 1
			end
		pasos[i] = posicion #Se asigna la posición actual al elemento correspondiente en el arreglo
		end
	return pasos #se devuelve el arreglo caminata que contiene las posiciones en cada paso de la caminata
	end
end

# ╔═╡ 7489a41c-bb8b-4ac4-8791-c42a6689e6fb
caminataAleatoria(3)

# ╔═╡ 1e68a5ca-d78e-4371-a63c-d329d11b187f
md"""**Ejercicio** Crea una función `graficaCaminata` que

* tome como entrada un arreglo -que supondremos que simula una caminata aleatoria en una dimensión- y 
* devuelva como salida una gráfica de posición contra número de pasos, usando _puntos_ (`scatter`) y con etiquetas en los ejes.

(Sugerencia: Crea un bloque de código con `begin` y `end` para poder hacer todo en una sola celda de Pluto.)

Luego, en una celda aparte, define una variable `n2` como un número entero positivo y aplica tu función `graficaCaminata` a `caminataAleatoria(n2)` para generar gráficas de caminatas aleatorias.
"""

# ╔═╡ 1ed85ab5-476d-4851-a0ab-c627f972b2c9
# Tu código (comentado) va aquí :)
begin
	function graficaCaminata(resultado::Array{Int})
		nPasos = length(resultado)
		lugar = resultado

		scatter(1:nPasos,lugar, legend = flase, title = "Grafica Caminata", xlabel="Número de pasos", ylabel="Posición")
	end
end

# ╔═╡ 42d2ea41-709c-475d-b9d2-46b78ef32dd0
graficaCaminata(resultado)

# ╔═╡ da4cd960-8f9d-470a-95c9-82723cc76071
n2 = 5

# ╔═╡ 03ce62ce-df19-4682-bbb8-d7b175f9448e
caminataAleatoria(n2)

# ╔═╡ 07edca52-f4bc-478f-b823-9811c320e171
md"**Ejercicio** Crea una función `graficaCaminata!` que sea una versión modificadora de la función anterior y utilice gráficas con líneas rectas punteadas (pues esto nos ayudará a discernir las trayectorias de distintos puntos más fácilmente). Luego, genera una gráfica con 5 caminatas aleatorias.
"

# ╔═╡ 896d6213-105b-403f-8aed-632303c7ba2b
# Tu código (comentado) va aquí :)
function graficaCaminata!(caminata)
	n = length(caminata)-1
	plot(0:n, caminata, xlabel="Número de pasos", ylabel="Posición", title="graficaCaminata!")
end

# ╔═╡ 75d3a337-a3b2-4319-bd1b-72d2642caef7
md"**Ejercicio** Crea una función `animaCaminata` que
* tome como entrada un arreglo -que supondremos que simula una caminata aleatoria en una dimensión- y
* devuelva como salida una *animación* de la caminata. (Sugerencia: Usa tu función `graficaCaminata`.)"

# ╔═╡ 7a0b1904-17e8-4cce-af17-70182a27da49
# Tu código (comentado) va aquí :)
ya esta


# ╔═╡ 24490a53-4b2b-49bd-bf9d-f8994ed6a3a7
md"""### Caminante aleatorio en dos dimensiones

Generalicemos nuestro modelo de caminante aleatorio suponiendo que ahora nuestra partícula se mueve en un espacio _continuo_ de _dos_ dimensiones espaciales; con tamaño de paso _continuo_ y _variable_. Es decir que, a pesar de que seguiremos modelando con un tiempo discreto e intervalos de tiempo uniformes, ahora el espacio será _continuo_ y tendrá _dos_ dimensiones espaciales.
"""

# ╔═╡ 09361d57-7c4c-4832-afc4-edf6f8819368
md""" **Ejercicio** Crea una función `caminataAleatoria2D` que
* tome como entrada un número de pasos `n` y
* devuelva como salida un arreglo con dos subarreglos que tengan `n+1` "posiciones" cada uno -uno de posiciones horizontales y otro de posiciones verticales, incluyendo las posiciones iniciales `0` en cada caso-, simulando una caminata aleatoria.
Utiliza tu función `aleatorioUniforme` para generar números aleatorios en el intervalo $[-1,1]$ y suma números generados por esta función a las posiciones horizontales y verticales para simular un paso continuo en dos dimensiones."""

# ╔═╡ d1c6a096-583d-4f85-b2cd-89d227311c1d
# Tu código (comentado) va aquí :)
function caminataAleatoria2D(n::Int) #declarar la función caminataAleatoria2D que toma un argumento n de tipo entero
    horizontal = zeros(n+1) #arreglo lleno de ceros con longitud n+1 en la posición horizontal
    vertical = zeros(n+1) #arreglo lleno de ceros con longitud n+1 en la posición vertical
    
    for i in 2:n+1 #ciclo for desde 2 hasta n+1
        pasoHorizontal = aleatorioUniforme(-1, 1)  #se generan dos pasos aleatorios utilizando aleatorioUniforme
        paso_vertical = aleatorioUniforme(-1, 1)   #que crea un número aleatorio entre -1 y 1
        
        horizontal[i] = horizontal[i-1] + pasoHorizontal #se calculan las nuevas posiciones horizontales y verticales 
        vertical[i] = vertical[i-1] + pasoVertical       #sumando los pasos aleatorios a las posiciones anteriores
    end
    
    return [horizontal, vertical]
end

# ╔═╡ 59161770-45a4-4f72-9e30-f642306aa818
caminataAleatoria2D(5)

# ╔═╡ 893d49c4-ab84-4c57-a9e3-54116575ade3
md"""**Ejercicio** Crea una función `graficaCaminata2D` que

* tome como entrada un arreglo con dos subarreglos -que, supondremos, simulan una caminata aleatoria en dos dimensiones- y 
* devuelva como salida una gráfica bidimensional que muestre la trayectoria de la caminata con una línea punteada.

(Sugerencia: Crea un bloque de código con `begin` y `end` para poder hacer todo en una sola celda de Pluto.)

Luego, en una celda aparte, define una variable `n3` como un número entero positivo y aplica tu función `graficaCaminata2D` a `caminataAleatoria2D(n3)` para generar gráficas de caminatas aleatorias en dos dimensiones.
"""

# ╔═╡ d292165a-b37b-47a6-a61e-dbdafbf1f928
# Tu código (comentado) va aquí :)
begin
function graficaCaminata2D(caminata::Array{Array{Float64, 1}, 1}) #declarar la función con dos subarreglos del tipo Float
    horizontal = caminata[1] #declaramos los subarreglos para la posición horizontal
    vertical = caminata[2] #declaramos los subarreglos para la posición vertical 
    
    plot(horizontal, vertical, linestyle=:dash, markersize=2, aspect_ratio=:equal, legend=false, xlabel ="Posición horizontal", ylabel="Posición vertical", title = "Caminata Aleatoria 2D") #creamos la gráfica 
end

# Ejemplo 
ejemplo = [[0.0, 4.0, 2.0, 1.0, 5.0], [0.0, 1.0, 1.0, 2.0, 2.0]]
graficaCaminata2D(ejemplo)
end

# ╔═╡ 4f61cb7d-42ee-4eb3-8750-d25ae3bba652
begin
	n3 = 7
	graficaCaminata2D(caminataAleatoria2D(n3))
end

# ╔═╡ eb7afba3-6d48-4406-8ac7-75521a965a14
md"**Ejercicio** Crea una función `graficaCaminata2D!` que sea una versión modificadora de la función anterior. Luego, genera una gráfica con 5 caminatas aleatorias en dos dimensiones (espaciales).
"

# ╔═╡ ff3c8595-0466-412e-b20b-30336916f573
# Tu código (comentado) va aquí :)

# ╔═╡ ec2b4750-3522-4c26-87ff-06b0b2e3b5d6
md"**Ejercicio** Crea una función `animaCaminata2D` que
* tome como entrada un arreglo con dos subarreglos -que, supondremos, simulan una caminata aleatoria en dos dimensiones- y 
* devuelva como salida una *animación* de la caminata. (Sugerencia: Usa tu función `graficaCaminata2D`.)"

# ╔═╡ ef1706ee-85dc-422b-98fa-aa43f75ae098
md"**Ejercicio** ¡Haz una caminata aleatoria en tres dimensiones espaciales y grafícala! (Así se modelan, por ejemplo, las partículas en un gas)." 

# ╔═╡ 48e666c6-3a29-4ebb-993f-06696a49b025
# Tu código (comentado) va aquí :)
function caminataAleatoria3D(n::Int)
    posiciones_x = zeros(n+1)
    posiciones_y = zeros(n+1)
    posiciones_z = zeros(n+1)
    
    for i in 2:n+1
        paso_x = aleatorioUniforme(-1, 1)
        paso_y = aleatorioUniforme(-1, 1)
        paso_z = aleatorioUniforme(-1, 1)
        
        posiciones_x[i] = posiciones_x[i-1] + paso_x
        posiciones_y[i] = posiciones_y[i-1] + paso_y
        posiciones_z[i] = posiciones_z[i-1] + paso_z
    end
    
    return [posiciones_x, posiciones_y, posiciones_z]
end

function graficaCaminata3D(caminata::Array{Array{Float64, 1}, 1})
    posiciones_x = caminata[1]
    posiciones_y = caminata[2]
    posiciones_z = caminata[3]
    
    plot3d(posiciones_x, posiciones_y, posiciones_z, linestyle=:dash, markersize=2, legend=false)
    xlabel!("Posición X")
    ylabel!("Posición Y")
    zlabel!("Posición Z")
    title!("Caminata Aleatoria 3D")
end

# Generar una caminata aleatoria en 3D con 100 pasos
caminata_3d = caminataAleatoria3D(100)

# Graficar la caminata aleatoria en 3D
graficaCaminata3D(caminata_3d)

# ╔═╡ 21d14d0f-a5c8-42f1-b9ab-acb973d71482
caminataAleatoria3D(2)

# ╔═╡ 2b36ffc7-7e4b-4c54-8651-c525c11b299a
graficaCaminata!(caminata)

# ╔═╡ f08b6ef6-65c1-4b53-ba50-128e589f70ee
# Tu código (comentado) va aquí :)
begin 
    horizontal = caminata[1] #declaramos los subarreglos para la posición horizontal
    vertical = caminata[2] #declaramos los subarreglos para la posición vertical
		frames = length(horizontal)
	anim = @animate for i in 1:frames
        plot(phorizontal[1:i], vertical[1:i], linestyle=:dash, markersize=2, aspect_ratio=:equal, legend=false)
        xlabel!("Posición horizontal")
        ylabel!("Posición vertical")
        title!("Caminata Aleatoria 2D")
   		end
    gif(anim, "caminata.gif", fps = 10)
	return anim
# Ejemplo de uso
caminata_ejemplo = [[0.0, 1.0, 2.0, 1.0, 2.0], [0.0, 1.0, 1.0, 2.0, 2.0]]
animaCaminata2D(caminata_ejemplo)
end

# ╔═╡ 9bdee65a-5b90-4e1f-aec8-9939ba1c32e3
md""" #### Nota final

Como aclaración, la razón por la cual en los **Ejercicios** de los _notebooks_ de este curso generalmente se definen muchas funciones "pequeñas" que luego se unen en una función "grande" _no es necesariamente porque esto sea **siempre** la mejor práctica_, sino por una cuestión pedagógica. Cuando estamos aprendiendo a programar y queremos implementar la solución a un problema, es mucho más fácil dividirlo en problemas más pequeños y fáciles de atacar que, después de solucionar, podamos integrar en una solución al problema principal. Sin embargo, para hacer un uso eficiente de los recursos computacionales, generalmente no es recomendable crear funciones que hagan _cada pequeña cosa_, pues todas ellas ocupan espacio en la memoria, por lo que es preferible hacer una implementación más deliberada una vez resuelto el problema usando la estrategia anterior. Recordemos que la principal utilidad de las funciones está en crear bloques de código _reutilizables_ por lo que, una vez implementado un programa, debe encontrarse un punto medio entre cuántas funciones _realmente necesitamos_ por su reutilizabilidad y cuántos recursos computacionales  tenemos a nuestra disposición.

"""

# ╔═╡ 8a5ab06a-12c5-4966-ba10-6d33e920f730
md""" ## Recursos complementarios
* Documentación de [funciones de generación aleatoria](https://docs.julialang.org/en/v1/stdlib/Random/#Random-generation-functions) en Julia.
"""

# ╔═╡ 74e480de-ae20-46ca-a65a-6fb8db3fc202
md""" ## Créditos
Este _notebook_ de Pluto fue basado parcialmente en los _notebooks_ de Jupyter `4. Caminatas aleatorias.ipynb` y `Tarea 1.ipynb` del repositorio [`FisicaComputacional2019_3`](https://github.com/dpsanders/FisicaComputacional2019_3/) del Dr. David Philip Sanders. 
"""

# ╔═╡ 8e79d696-1797-44ca-abbc-e0a1c3264073
caminata = caminataAleatoria(n2)

# ╔═╡ c5075b9c-58c6-48cf-b3a0-09054b135075
begin
	n_pasos = 12
	caminata = caminataAleatoria3D(n_pasos)
	graficaCaminata3D(caminata)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"

[compat]
Plots = "~1.38.12"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "39d0d5866236472d6bc1a58c4e663ea8a2a2e057"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e30f2f4e20f7f186dc36529910beaedc60cfa644"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.16.0"

[[deps.ChangesOfVariables]]
deps = ["LinearAlgebra", "Test"]
git-tree-sha1 = "f84967c4497e0e1955f9a582c232b02847c5f589"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.7"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "9c209fb7536406834aa938fb149964b985de6c83"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.1"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "be6ab11021cd29f0344d5c4357b163af05a48cba"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.21.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "96d823b94ba8d187a6d8f0826e731195a74b90e9"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "d014972cd6f5afb1f8cd7adf000b7a966d62c304"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.5"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f670f269909a9114df1380cc0fcaa316fff655fb"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.5+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "41f7dfb2b20e7e8bf64f6b6fae98f4d2df027b06"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.4"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "6667aadd1cdee2c6cd068128b3d226ebc4fb0c67"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.9"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "099e356f267354f46ba65087981a77da23a279b7"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9ff31d101d987eb9d66bd8b176ac7c277beccd09"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.20+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "f92e1315dadf8c46561fb9396e525f7200cdc227"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.5"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "d03ef538114b38f89d66776f2d8fdc0280f90621"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.12"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "259e206946c293698122f63e2b513a7c99a244e8"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╟─f4a77582-9121-4881-8139-fcb01d4ef6b9
# ╟─6f5f31aa-2941-42f5-aceb-bedb2bd30ea2
# ╟─62816dec-c81a-40cb-aebd-8bda77d5e389
# ╟─6dd575bd-5ee7-49ab-8234-ab83eff83ebf
# ╟─d3e89523-095f-4f2f-aa2c-b38887c187eb
# ╠═712bfc18-334c-470f-8809-1a1388be7b66
# ╟─97ec59e8-2d0d-43d3-b2c8-dd74c7020352
# ╠═d4caf15c-4f99-44e4-9222-519433799348
# ╠═acc9af92-7e10-41dc-8799-e86c380dc39d
# ╟─737eb77d-ce3f-4eac-9f38-5cbae8bd2636
# ╠═dde71c48-f741-4f63-a99e-a10235d58ad5
# ╠═41a80720-ab01-4931-b86f-1c72cf48c993
# ╠═a35f7416-8003-4edb-aad1-1ea0de388f67
# ╟─5eedcedb-7dd6-45b0-8a06-238bf6b358f7
# ╠═fc77bf6a-1864-431a-bd9b-0e3a471d81b7
# ╠═66146a2e-acaf-4183-bf31-20c92a3be04a
# ╟─d3a7fcb3-b0a5-4b41-bf95-ac3ffdce7fb6
# ╠═544fdf8f-fb78-40be-8618-f071c47f00b2
# ╠═64cf4e1a-8efa-48dc-921a-eb2ddbc7f3e8
# ╟─f2bb54fd-ccb9-4e8d-b8c4-3a4058ffbe4c
# ╠═9d09fc0f-ccba-477d-9968-82b9554f44e2
# ╠═7489a41c-bb8b-4ac4-8791-c42a6689e6fb
# ╟─1e68a5ca-d78e-4371-a63c-d329d11b187f
# ╠═1ed85ab5-476d-4851-a0ab-c627f972b2c9
# ╠═42d2ea41-709c-475d-b9d2-46b78ef32dd0
# ╠═03ce62ce-df19-4682-bbb8-d7b175f9448e
# ╠═da4cd960-8f9d-470a-95c9-82723cc76071
# ╠═8e79d696-1797-44ca-abbc-e0a1c3264073
# ╟─07edca52-f4bc-478f-b823-9811c320e171
# ╠═896d6213-105b-403f-8aed-632303c7ba2b
# ╠═2b36ffc7-7e4b-4c54-8651-c525c11b299a
# ╟─75d3a337-a3b2-4319-bd1b-72d2642caef7
# ╠═7a0b1904-17e8-4cce-af17-70182a27da49
# ╟─24490a53-4b2b-49bd-bf9d-f8994ed6a3a7
# ╟─09361d57-7c4c-4832-afc4-edf6f8819368
# ╠═d1c6a096-583d-4f85-b2cd-89d227311c1d
# ╠═59161770-45a4-4f72-9e30-f642306aa818
# ╟─893d49c4-ab84-4c57-a9e3-54116575ade3
# ╠═d292165a-b37b-47a6-a61e-dbdafbf1f928
# ╠═4f61cb7d-42ee-4eb3-8750-d25ae3bba652
# ╟─eb7afba3-6d48-4406-8ac7-75521a965a14
# ╠═ff3c8595-0466-412e-b20b-30336916f573
# ╟─ec2b4750-3522-4c26-87ff-06b0b2e3b5d6
# ╠═f08b6ef6-65c1-4b53-ba50-128e589f70ee
# ╟─ef1706ee-85dc-422b-98fa-aa43f75ae098
# ╠═9d4d3c67-3d08-4b14-8dcb-eb41649f0c0f
# ╠═48e666c6-3a29-4ebb-993f-06696a49b025
# ╠═21d14d0f-a5c8-42f1-b9ab-acb973d71482
# ╠═c5075b9c-58c6-48cf-b3a0-09054b135075
# ╟─9bdee65a-5b90-4e1f-aec8-9939ba1c32e3
# ╟─8a5ab06a-12c5-4966-ba10-6d33e920f730
# ╟─74e480de-ae20-46ca-a65a-6fb8db3fc202
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
