package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

import ar.edu.eventos.exceptions.BusinessException

@Accessors
class Servicio implements Entidad {
	
	private var int id
	private var String descripcion
	private TipoDeTarifa tarifaDelServicio 
	private Locacion ubicacion
	private var double tarifaPorKilometro

	public def double costoDelServicio(Evento unEvento) {
		
		tarifaDelServicio.costo(unEvento) + this.costoDetraslado(unEvento)
	}

 	private def double costoDetraslado(Evento unEvento) {
		tarifaPorKilometro * unEvento.distancia(ubicacion.ubicacion)
	}

	override validar() {
		validarDescripcion()
		validarTarifa()
		validarUbicacion()
	}

	private def void validarUbicacion() {
		if (ubicacion === null) {
			throw new BusinessException("No podes crear un servicio sin una Ubicacion")
		}
	}

	private def void validarTarifa() {
		if (tarifaDelServicio === null) {
			throw new BusinessException("No podes crear un servicio sin una Tarifa")
		}
	}

	private def void validarDescripcion() {
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
