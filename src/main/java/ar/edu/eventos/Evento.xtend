package ar.edu.eventos

import java.time.LocalDateTime
import java.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Evento {

	LocalDateTime inicioDelEvento
	LocalDateTime finDelEvento
	String nombre
	String nombreDeLaLocacion
	Point ubicacion

	new(String unNombre) {
		nombre = unNombre
	}

	def locacion(Point lugar,String unNombre) {
		nombreDeLaLocacion=unNombre
		ubicacion=lugar
	}

	def long duracion() {
		Duration.between(inicioDelEvento, finDelEvento).getSeconds()
	}

	def distancia(Point punto){
	   this.ubicacion.distance(punto)
	}
}
