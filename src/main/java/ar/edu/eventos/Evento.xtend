package ar.edu.eventos

import java.time.LocalDateTime
import java.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Evento {

	LocalDateTime inicioDelEvento
	LocalDateTime finDelEvento
	String nombre
	Locacion locacion
	Usuario organizador

	new(String unNombre, Locacion unaLocacion,Usuario unOrganizador) {
		nombre = unNombre
		locacion = unaLocacion
		organizador = unOrganizador
	}

	def duracion() {
		Duration.between(inicioDelEvento, finDelEvento).toHours()
	}




}
