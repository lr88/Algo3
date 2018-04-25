package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.exceptions.BusinessException

@Accessors
class Servicio implements objetoT {
	var int id
	var String descripcion
	var int costo
	TipoDeTarifa tarifaDelServicio 
	Locacion ubicacion

	def costoDelServicio(Evento unEvento) {
		tarifaDelServicio.costo(unEvento)// + traslado
	}
	override soyValido() {
		 validarDescripcion()
		 validarTarifa()
		 validarUbicacion
	}
	def validarUbicacion(){
		if(ubicacion === null ){
			throw new BusinessException("No podes crear un servicio sin una Ubicacion")
		}
		true
	}
	def validarTarifa(){
		if(tarifaDelServicio === null){
			throw new BusinessException("No podes crear un servicio sin una Tarifa")
		}
		true
	}
	def validarDescripcion(){
		if(descripcion === null || descripcion == ""){
			throw new BusinessException("No podes crear un servicio sin una descripcion")
		}
		true
	}
	override getId() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override setId(int unId) {
		id = unId
	}
	
	override modificarObjeto(T object) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}

interface TipoDeTarifa {

	def double costo(Evento unEvento)

}

class TarifaFija implements TipoDeTarifa {
	//var tarifa 
	
		override costo(Evento unEvento) {
		1
	}

}

class TarifaPorHora implements TipoDeTarifa {

	override costo(Evento unEvento) {
	   1//unEvento.duracion
	}

}

class TarifaPorPersona implements TipoDeTarifa {

	override costo(Evento unEvento) {
		1
	}

}
