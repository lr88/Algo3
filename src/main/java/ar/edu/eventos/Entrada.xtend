package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration

@Accessors
class Entrada {

	var double valorDeLAEntrada
	Usuario usuario
	val veintePorCiento = 0.2
	val diezPorCiento = 0.10

	new(Usuario unUsuario, double unValorDeLaEntrada) {
		usuario = unUsuario
		valorDeLAEntrada = unValorDeLaEntrada
		usuario.mensajes.add("Felicitaciones tu entrada fue comprada Con Exito")
		usuario.plataQueTengo = usuario.plataQueTengo - valorDeLAEntrada
	}

	def void devolverDinero(LocalDateTime unaFecha, EventoAbierto unEvento) {
		usuario.plataQueTengo = usuario.plataQueTengo + valorDeLAEntrada * 0.2
		if (Duration.between(unaFecha, unEvento.inicioDelEvento).toDays()  <= 6){
			usuario.plataQueTengo = usuario.plataQueTengo +	Duration.between(unaFecha, unEvento.inicioDelEvento).toDays() * diezPorCiento * valorDeLAEntrada 
		}
		else{
			
			usuario.plataQueTengo = usuario.plataQueTengo + 6 * diezPorCiento * valorDeLAEntrada
		}
		}

	def void devolverEltotal() {
		usuario.plataQueTengo = usuario.plataQueTengo + valorDeLAEntrada
	}

}
