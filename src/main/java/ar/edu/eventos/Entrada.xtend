package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration

@Accessors
class Entrada {

	var double valorDeLAEntrada
	var Usuario usuario
	val veintePorCiento = 0.2
	val diezPorCiento = 0.1
	val Evento evento

	new(Evento unEventoAbierto) {
		evento = unEventoAbierto
	}

	public def void postergarEvento() {
		usuario.recibirMensaje("se postergo el evento\n")
	}

	public def void cancelarEvento() {
		usuario.recibirMensaje("se cancelo el evento\n")
	}

	private def elEventoFuePostegadoOCancelado() {
		evento.elEventoFuePostegadoOCancelado
	}

	private def diasFaltantes() {
		Duration.between(LocalDateTime.now, evento.fechaDeInicioDelEvento).toDays()
	}

	public def void devolverDinero() {
		if (elEventoFuePostegadoOCancelado) {
			devolverEltotal
		} else {
			if (1 <= diasFaltantes && diasFaltantes <= 8) {
				devolverDineroCorrespondienteALosDiasFaltantes
			} else {
				devolverElPorsentajeMaximo()
			}
		}
	}

	private def devolverDineroCorrespondienteALosDiasFaltantes() {
		usuario.plataQueTengo = usuario.plataQueTengo + (diasFaltantes + 1) * diezPorCiento * valorDeLAEntrada
	}

	private def devolverElPorsentajeMaximo() {
		usuario.plataQueTengo = usuario.plataQueTengo + 8 * diezPorCiento * valorDeLAEntrada
	}

	public def void devolverEltotal() {
		usuario.plataQueTengo = usuario.plataQueTengo + valorDeLAEntrada
	}

}
