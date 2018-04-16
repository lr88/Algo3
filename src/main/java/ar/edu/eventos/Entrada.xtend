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
		unUsuario.entregarEntradaAlusuario(this)
		usuario.mensajes.add("Felicitaciones tu entrada fue comprada Con Exito")
		print("Felicitaciones tu entrada fue comprada Con Exito")
		usuario.plataQueTengo = usuario.plataQueTengo - valorDeLAEntrada
	}


	def elEventoFuePostegadoOCancelado(EventoAbierto unEvento){
		unEvento.fueCancelado || unEvento.fuePostergado
	}

	def void devolverDinero(LocalDateTime unaFecha, EventoAbierto unEvento) {
		if(elEventoFuePostegadoOCancelado(unEvento)){
				devolverEltotal			
		}
		else{
				if (0 < Duration.between(unaFecha, unEvento.inicioDelEvento).toDays() && Duration.between(unaFecha, unEvento.inicioDelEvento).toDays()  < 8) {
					usuario.plataQueTengo = usuario.plataQueTengo + (Duration.between(unaFecha, unEvento.inicioDelEvento).toDays() + 1) * diezPorCiento * valorDeLAEntrada
					}
		 		else {
					usuario.plataQueTengo = usuario.plataQueTengo + 8 * diezPorCiento * valorDeLAEntrada
				}
		}
	}

	def void devolverEltotal() {
		usuario.plataQueTengo = usuario.plataQueTengo + valorDeLAEntrada
		print("Felicitaciones tu entrada fue devuelta con su 100 % de su valor con Exito")
	}

}
