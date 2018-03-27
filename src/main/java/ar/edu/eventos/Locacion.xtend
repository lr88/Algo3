package ar.edu.eventos

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Locacion {
	Point ubicacion
	String nombreDeLaLocacion

	new(Point lugar, String unNombre) {
		nombreDeLaLocacion = unNombre
		ubicacion = lugar
	}

	def distancia(Point punto) {
		return this.ubicacion.distance(punto)
	}

}
