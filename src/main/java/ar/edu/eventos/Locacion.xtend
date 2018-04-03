package ar.edu.eventos

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Locacion {

	Point ubicacion
	String nombreDeLaLocacion

	new(Point lugar, String unNombre) {
	}

	def distancia(Point punto) {
		return this.ubicacion.distance(punto)
	}

}

class LocacionEventos extends Locacion {
	val double superficieM2
	val double distribucionM2PorPersona = 0.8

	new(Point lugar, String unNombre, double unaSuperficieM2) {
		super(lugar, unNombre)
		nombreDeLaLocacion = unNombre
		ubicacion = lugar
		superficieM2 = unaSuperficieM2

	}

	def superficie(EventoAbierto unEvento) {
		superficieM2
	}

	def capacidadMaxima(EventoAbierto abierto) {
		superficieM2 / distribucionM2PorPersona
	}
}
