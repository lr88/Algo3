package ar.edu.eventos

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Locacion {

	Point ubicacion
	String nombreDeLaLocacion
	var double distribucionM2PorPersona = 0.8
	var double superficieM2
	
	def distancia(Point punto) {
		ubicacion.distance(punto)
	}

	def double capacidadMaxima() {
		superficieM2 / distribucionM2PorPersona
	}

}
