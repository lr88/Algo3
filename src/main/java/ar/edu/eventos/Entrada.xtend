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
	val EventoAbierto EventoAbierto

	new(EventoAbierto unEventoAbierto) {
		EventoAbierto = unEventoAbierto
	}

	def void postergarEvento() {
		usuario.recibirMensaje("se postergo el evento\n")
	}

	def void cancelarEvento() {
		usuario.recibirMensaje("se cancelo el evento\n")
	}

	def elEventoFuePostegadoOCancelado() {
		EventoAbierto.elEventoFuePostegadoOCancelado
	}

	def diasFaltantes() {
		Duration.between(LocalDateTime.now, EventoAbierto.fechaDeInicioDelEvento).toDays()
	}

	def void devolverDinero() {
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

	def devolverDineroCorrespondienteALosDiasFaltantes() {
		usuario.plataQueTengo = usuario.plataQueTengo + (diasFaltantes + 1) * diezPorCiento * valorDeLAEntrada
	}

	def devolverElPorsentajeMaximo() {
		usuario.plataQueTengo = usuario.plataQueTengo + 8 * diezPorCiento * valorDeLAEntrada
	}

	def void devolverEltotal() {
		usuario.plataQueTengo = usuario.plataQueTengo + valorDeLAEntrada
	}

}
