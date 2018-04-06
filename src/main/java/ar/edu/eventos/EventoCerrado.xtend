package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.time.LocalDateTime

@Accessors
class EventoCerrado extends Evento {
	
	int cantidadMaxima
	List<Invitacion> invitaciones
	
	
	new(String unNombre, Locacion unaLocacion, int cantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion,LocalDateTime unInicioDelEvento,LocalDateTime unFinDelEvento) {
		super(unNombre, unaLocacion, unOrganizador, unInicioDelEvento, unFinDelEvento)
		fechaMaximaDeConfirmacion = unaFechaMaximaDeConfirmacion
	}

	def capacidadMaxima() {
		cantidadMaxima
	}

	def boolean esExitoso() {
		cantidadMaxima * 0.8 < this.cuantosAvamos && estadoDelEvento

	}

	def boolean esUnFracaso() {
		cantidadMaxima * 0.5 > this.cuantosAvamos

	}

	def invitarAUnUsuario(Usuario unUsuario, int unaCantidadDeAcompañantes) {
		new Invitacion(unUsuario, unaCantidadDeAcompañantes, this)
	}

	def pedirConfirmacionDeLasEntradas() {
		invitaciones.forEach[invitacion|invitacion.queresVenir()]
	}

	def int cuantosAvamos() {
		1
	}

	def cancelarEvento() {
		estadoDelEvento = false // que pasa cuando se cancela un evento
	}

}
