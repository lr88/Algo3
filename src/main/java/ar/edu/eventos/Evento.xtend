package ar.edu.eventos

import java.time.Duration
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Evento {

	LocalDateTime fechaMaximaDeConfirmacion
	LocalDateTime fechaActual = LocalDateTime.now()
	LocalDateTime inicioDelEvento
	LocalDateTime finDelEvento
	String nombre
	Locacion locacion
	Usuario organizador
	var Boolean fuePostergado = false
	var Boolean fueCancelado = false
	
	
	new(String unNombre, Locacion unaLocacion, Usuario unOrganizador, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {
		nombre = unNombre
		locacion = unaLocacion
		organizador = unOrganizador
		inicioDelEvento = unInicioDelEvento
		finDelEvento = unFinDelEvento
	}

	def duracion() {
		Duration.between(inicioDelEvento, finDelEvento).toHours()
	}

	def terminoElEvento() {
		Duration.between(finDelEvento, fechaActual).toMillis() > 0
	}

	def void cambiarFecha(LocalDateTime nuevaFecha) {}

	def void cancelarElEvento(Evento unEvento) {}

	def void postergarElEvento(Evento unEvento, LocalDateTime NuevaFechaDeInicioDelEvento) {}
}
