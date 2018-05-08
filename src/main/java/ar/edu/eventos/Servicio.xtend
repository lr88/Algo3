package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

import ar.edu.eventos.exceptions.BusinessException

@Accessors
class Servicio implements Entidad {
	
	var int id
	var String descripcion
	TipoDeTarifa tarifaDelServicio 
	Locacion ubicacion
	var double tarifaPorKilometro

	def costoDelServicio(Evento unEvento) {
		tarifaDelServicio.costo(unEvento) + this.costoDetraslado(unEvento)
	}

	def double costoDetraslado(Evento unEvento) {
		tarifaPorKilometro * unEvento.distanciaAmi(ubicacion.ubicacion)
	}

	override validar() {
		validarDescripcion()
		validarTarifa()
		validarUbicacion()
	}

	def validarUbicacion() {
		if (ubicacion === null) {
			throw new BusinessException("No podes crear un servicio sin una Ubicacion")
		}
	}

	def validarTarifa() {
		if (tarifaDelServicio === null) {
			throw new BusinessException("No podes crear un servicio sin una Tarifa")
		}
	}

	def validarDescripcion() {
		if (descripcion === null || descripcion.length == 0) {
			throw new BusinessException("No podes crear un servicio sin una descripcion")
		}
	}

	override getId() {
		id
	}

	override setId(int unId) {
		id = unId
	}

}
