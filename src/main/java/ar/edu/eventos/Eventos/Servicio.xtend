package ar.edu.eventos.Eventos

import org.eclipse.xtend.lib.annotations.Accessors

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.eventos.exceptions.Validar
import ar.edu.eventos.Eventos.Locacion
import ar.edu.eventos.Eventos.Evento
import ar.edu.eventos.Json.Entidad
import java.util.List

@Accessors
class Servicio implements Entidad {

	protected Validar validarcion = new Validar
	private var int id
	private var String descripcion
	private TipoDeTarifa tarifaDelServicio
	private Locacion ubicacion
	private var double tarifaPorKilometro

	public def double costoDelServicio(Evento unEvento) {
		tarifa(unEvento) + this.costoDetraslado(unEvento)
	}

	public def double costoDetraslado(Evento unEvento) {
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

	def tarifa(Evento evento) {
		tarifaDelServicio.costo(evento)
	}

}

@Accessors
class ServicioMultiple extends Servicio {

	List<Servicio> servicios = newArrayList
	Double porcentajeDeDescuento

	public override double costoDelServicio(Evento unEvento) {
		costoBruto(unEvento) * porcentajeACobrar() / 100 + costoDetraslado(unEvento)
	}

	def costoBruto(Evento unEvento) {
		servicios.fold(0.0, [acum, servicios|acum + servicios.tarifa(unEvento)])
	}

	def porcentajeACobrar() {
		100 - porcentajeDeDescuento
	}

	override public def double costoDetraslado(Evento unEvento) {
		servicios.map[ser|ser.costoDetraslado(unEvento)].max
	}

}
