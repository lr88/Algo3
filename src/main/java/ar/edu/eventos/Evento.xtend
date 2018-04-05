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
	boolean estadoDelEvento = true
	

	new(String unNombre, Locacion unaLocacion, Usuario unOrganizador) {
		nombre = unNombre
		locacion = unaLocacion
		organizador = unOrganizador
	}

	def duracion() {
		Duration.between(inicioDelEvento, finDelEvento).toHours()
	}
	

	
}

