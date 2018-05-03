package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

import ar.edu.eventos.exceptions.BusinessException

@Accessors
class Servicio implements objetoT {
	var int id
	var String descripcion
	TipoDeTarifa tarifaDelServicio 
	Locacion ubicacion
	var double tarifaPorKilometro
    /*
    new (){
    	soyValido() 
    }
    * 
    */
	def costoDelServicio(Evento unEvento) {
		tarifaDelServicio.costo(unEvento) + this.costoDetraslado(unEvento)
	}

	def double costoDetraslado(Evento unEvento) {
		tarifaPorKilometro /* unEvento.distanciaAmi(ubicacion)*/
	}

	override soyValido() {
		validarDescripcion()
		validarTarifa()
		validarUbicacion
	}

	def validarUbicacion() {
		if (ubicacion === null) {
			throw new BusinessException("No podes crear un servicio sin una Ubicacion")
		}
		true
	}

	def validarTarifa() {
		if (tarifaDelServicio === null) {
			throw new BusinessException("No podes crear un servicio sin una Tarifa")
		}
		true
	}

	def validarDescripcion() {
		if (descripcion === null || descripcion.length == 0) {
			throw new BusinessException("No podes crear un servicio sin una descripcion")
		}
		true
	}

	override getId() {
		id
	}

	override setId(int unId) {
		id = unId
	}

	override modificarObjeto() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
