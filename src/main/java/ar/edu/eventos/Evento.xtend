package ar.edu.eventos

import java.time.LocalDateTime
import java.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Evento {

	LocalDateTime inicioDelEvento
	LocalDateTime finDelEvento
	String nombre
	Locacion locación

	new(String unNombre, Locacion unaLocación) {
		nombre = unNombre
		locación = unaLocación
	}

	def duracion() {
		Duration.between(inicioDelEvento, finDelEvento).toHours()
	}

}
