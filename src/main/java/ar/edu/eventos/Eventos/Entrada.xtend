package ar.edu.eventos.Eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration
import ar.edu.eventos.Usuario.Usuario

@Accessors
class Entrada {
	
	public var double valorDeLaEntrada
	protected var Usuario usuario
	protected val veintePorCiento = 0.2
	protected val diezPorCiento = 0.1
	protected val Evento evento

	new(Evento unEventoAbierto) {
		evento = unEventoAbierto
	}

	public def void postergarEvento() {
		usuario.recibirMensaje("se postergo el evento\n")
	}

	public def void cancelarEvento() {
		usuario.recibirMensaje("se cancelo el evento\n")
	}

	protected def boolean elEventoFuePostegadoOCancelado() {
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

	private def void devolverDineroCorrespondienteALosDiasFaltantes() {
		usuario.plataQueTengo = usuario.plataQueTengo + (diasFaltantes + 1) * diezPorCiento * valorDeLaEntrada 
	}

	private def void devolverElPorsentajeMaximo() {
		usuario.plataQueTengo = usuario.plataQueTengo + 8 * diezPorCiento * valorDeLaEntrada
	}

	public def void devolverEltotal() {
		usuario.plataQueTengo = usuario.plataQueTengo + valorDeLaEntrada
	}

}
