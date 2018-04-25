package ar.edu.eventos

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Locacion {

	Point ubicacion =  new Point(1.0, 2.0)
	String nombreDeLaLocacion
	var double distribucionM2PorPersona = 0.8
	var double superficieM2
	
	def distancia(Point unaDirecion) {
		ubicacion.distance(unaDirecion)
	}

	def double capacidadMaxima() {
		superficieM2 / distribucionM2PorPersona
	}

}
