package ar.edu.eventos

import org.uqbar.geodds.Point
import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Locacion implements Entidad {
    
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
		if(ubicacion === null ){
			throw new BusinessException("No podes crear una locacion sin una Ubicacion")
		}
	}
	
	private def void validarDescripcion() {
		if(nombreDeLaLocacion === null || nombreDeLaLocacion.length == 0){
			throw new BusinessException("No podes crear una Locacion sin Descripcion")
		}
	}
	
}