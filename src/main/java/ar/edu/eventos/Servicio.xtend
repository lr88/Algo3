package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.eventos.exceptions.Validar

@Accessors
class Servicio implements Entidad {
	protected Validar validarcion = new Validar
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

	override void validar() {
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
		validarcion.validarObjetoNoNulo(tarifaDelServicio, "una Tarifa")
	}

	private def void validarDescripcion() {
		validarcion.validarStringNoNulo(descripcion, "una descripcion")
	}

	override getId() {
		id
	}

	override setId(int unId) {
		id = unId
	}

}
