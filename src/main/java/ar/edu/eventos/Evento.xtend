package ar.edu.eventos

import java.time.Duration
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Evento {

	LocalDateTime fechaMaximaDeConfirmacion
	LocalDateTime fechaActual = LocalDateTime.now()
	LocalDateTime fechaDeInicioDelEvento
	LocalDateTime fechaDeFinDelEvento
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
		fechaDeInicioDelEvento = unInicioDelEvento
		fechaDeFinDelEvento = unFinDelEvento
	}

	def duracion() {
		Duration.between(fechaDeInicioDelEvento, fechaDeFinDelEvento).toHours()
	}

	def terminoElEvento() {
		Duration.between(fechaDeFinDelEvento, fechaActual).toMillis() > 0
	}

	def void cambiarFecha(LocalDateTime nuevaFecha) {}

	def void cancelarElEvento(Evento unEvento) {}

	def void postergarElEvento(Evento unEvento, LocalDateTime NuevaFechaDeInicioDelEvento) {}
}
