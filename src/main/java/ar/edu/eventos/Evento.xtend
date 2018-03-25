package ar.edu.eventos

import java.time.LocalDateTime
import java.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class Evento {

	LocalDateTime inicioDelEvento
	LocalDateTime finDelEvento
	String nombre
	String nombreDeLaLocacion
	Float locacionX
	Float locacionY

	new(String unNombre) {
		nombre = unNombre
	}

	def String elNombreDeLaLocacion(String unNombre) {
		nombreDeLaLocacion = unNombre
	}

	def ubicacion(float X, float Y) {
		locacionX = X
		locacionY = Y
	}

	def long duracion() {
		Duration.between(inicioDelEvento, finDelEvento).getSeconds()
	}

	def double distancia(float puntoX,float puntoY){
	Math.sqrt((Math.pow(puntoX-locacionX,2))+(Math.pow(puntoY-locacionY,2)))
	}
}
