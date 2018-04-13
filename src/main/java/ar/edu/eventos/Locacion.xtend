package ar.edu.eventos

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Locacion {

	Point ubicacion
	String nombreDeLaLocacion
	val double distribucionM2PorPersona = 0.8
	val double superficieM2

	new(Point lugar, String unNombre, double unaSuperficieM2) {
		nombreDeLaLocacion = unNombre
		ubicacion = lugar
		superficieM2 = unaSuperficieM2

	}

	def distancia(Point punto) {
		ubicacion.distance(punto)
	}

	def double capacidadMaxima() {
		superficieM2 / distribucionM2PorPersona
	}

}
