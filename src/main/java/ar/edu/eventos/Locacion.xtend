package ar.edu.eventos

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.exceptions.Validar

@Accessors
class Locacion implements Entidad {
     protected Validar validarcion = new Validar
	protected var int id
	protected Point ubicacion 
	protected var String nombreDeLaLocacion
	protected var double distribucionM2PorPersona = 0.8
	protected var double superficieM2
	protected var String calle 
	protected var int numero
	protected var String localidad
	protected var String provincia 
		
	public def double distancia(Point unaDirecion) {
		ubicacion.distance(unaDirecion)
	}

	public def double capacidadMaxima() {
		superficieM2 / distribucionM2PorPersona
	}
	
	override validar() {
		validarDescripcion ()
		validarUbicacion()
	}

	private def void validarUbicacion() {
		validarcion.validarObjetoNoNulo(ubicacion, "ubicacion")
	}
	
	private def void validarDescripcion() {
		validarcion.validarStringNoNulo(nombreDeLaLocacion, "Nombre de la locacion")
	}
	
}