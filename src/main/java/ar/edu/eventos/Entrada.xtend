package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration

@Accessors
class Entrada {

	var double valorDeLAEntrada
	Usuario un_Usuario
	val veintePorCiento = 0.2
	val diezPorCiento = 0.10

	new(Usuario unUsuario, double unValorDeLaEntrada) {
		un_Usuario = unUsuario
		valorDeLAEntrada = unValorDeLaEntrada
		un_Usuario.recibirMensaje("Felicitaciones tu entrada fue comprada Con Exito")
	}

	def void devolverDinero(LocalDateTime unaFecha, EventoAbierto unEvento) {
		/*devuelve el dinero al dueño */
		un_Usuario.plataQueTengo = un_Usuario.plataQueTengo + valorDeLAEntrada * veintePorCiento
		/*más un 10% por cada día extra restante, hasta un 80% en total.  */
		if (Duration.between(unaFecha, unEvento.inicioDelEvento).toDays() < 6)
			un_Usuario.plataQueTengo = un_Usuario.plataQueTengo +
				Duration.between(unaFecha, unEvento.inicioDelEvento).toDays() * diezPorCiento * valorDeLAEntrada
	}

}
