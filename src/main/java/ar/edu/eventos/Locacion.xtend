package ar.edu.eventos

import org.uqbar.geodds.Point
import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Locacion implements Entidad {
    
	var int id
	Point ubicacion 
	var String nombreDeLaLocacion
	var double distribucionM2PorPersona = 0.8
	var double superficieM2
	var String calle 
	var int numero
	var String localidad
	var String provincia 
		
	def distancia(Point unaDirecion) {
		ubicacion.distance(unaDirecion)
	}

	def double capacidadMaxima() {
		superficieM2 / distribucionM2PorPersona
	}
	
	override validar() {
		validarDescripcion ()
		validarUbicacion()
	}
	
	def validarUbicacion() {
		if(ubicacion === null ){
			throw new BusinessException("No podes crear una locacion sin una Ubicacion")
		}
	}
	
	def validarDescripcion() {
		if(nombreDeLaLocacion === null || nombreDeLaLocacion.length == 0){
			throw new BusinessException("No podes crear una Locacion sin Descripcion")
		}
	}
	
}