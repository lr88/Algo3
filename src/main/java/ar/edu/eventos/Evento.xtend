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
	LocacionEventos locacion
	List<Usuario> usuario = newArrayList
	Organizador organizador

	new(String unNombre, LocacionEventos unaLocacion) {
		nombre = unNombre
		locacion = unaLocacion
	}

	def duracion() {
		Duration.between(inicioDelEvento, finDelEvento).toHours()
	}

	def cantidadDeInvitados() {
		usuario.size()
	}

	/*Organizador: Es el usuario que crea y organiza el evento.   */
	def organizador(Organizador _persona) {
		this.organizador = _persona
	}

}
