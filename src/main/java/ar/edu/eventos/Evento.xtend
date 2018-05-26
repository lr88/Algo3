package ar.edu.eventos

import java.time.Duration
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Set
import java.util.HashSet
import org.uqbar.geodds.Point
import ar.edu.eventos.exceptions.BusinessException

@Accessors
abstract class Evento {

	protected LocalDateTime fechaMaximaDeConfirmacion
	protected LocalDateTime fechaDeInicioDelEvento
	protected LocalDateTime fechaDeFinDelEvento
	protected Set<Servicio> servicios = new HashSet()
	protected String nombre
	protected Locacion locacion
	protected Usuario organizador
	protected var Boolean fuePostergado = false
	protected var Boolean fueCancelado = false
	protected var Boolean enProceso = true

	private def void coherenciaFechaDeConfirmacion() {
		if (!(fechaMaximaDeConfirmacion < fechaDeInicioDelEvento)) {
			throw new BusinessException("La fecha máxima de confirmación debe ser menor a la fecha de inicio")
		}
	}
	private def void coherenciaFechaDeEvento() {
		if (!(fechaDeFinDelEvento > fechaDeInicioDelEvento)){
			throw new BusinessException(" La fecha/hora de fin debe ser mayor a la fecha/hora de inicio.")
	}}
	private def boolean coherenciaDeFechas() {
		fechaMaximaDeConfirmacion < fechaDeInicioDelEvento && fechaDeFinDelEvento > fechaDeInicioDelEvento
	}
	public def double costoTotal() {
		servicios.fold(0.0, [acum, servicios|acum + servicios.costoDelServicio(this)])
	}
	public def void contratarServicio(Servicio unServicio) {
		servicios.add(unServicio)
	}
	public def double distancia(Point unaDirecion) {
		locacion.distancia(unaDirecion)
	}
	public def double duracion() {
		Duration.between(fechaDeInicioDelEvento, fechaDeFinDelEvento).toHours()
	}
	public def boolean terminoElEvento() {
		Duration.between(fechaDeFinDelEvento, LocalDateTime.now).toMillis() < 0
	}
	public def boolean elEventoFuePostegadoOCancelado() {
		fueCancelado || fuePostergado
	}
	public def void cambiarFecha(LocalDateTime nuevaFecha) {
		var aux = Duration.between(fechaDeInicioDelEvento, nuevaFecha)
		cambiarFechaInicio(aux)
		cambiarFechaFin(aux)
		cambiarFechaConfirmacion(aux)
		fuePostergado = true
		tipoDeEventoPostergate()
	}
	private def void cambiarFechaInicio(Duration aux) {
		fechaDeInicioDelEvento = fechaDeInicioDelEvento.plus(aux)
	}
	private def void cambiarFechaFin(Duration aux) {
		fechaDeFinDelEvento = fechaDeFinDelEvento.plus(aux)
	}
	private def void cambiarFechaConfirmacion(Duration aux) {
		fechaMaximaDeConfirmacion = fechaMaximaDeConfirmacion.plus(aux)
	}
	public def void validar() {
		validarNombre()
		validarFechaDeInicio()
		validarFechaDeFin()
		validarFechaConfirmacion()
		validarLocacion()
		validarCoherenciaFechas()
	}
	private def void validarCoherenciaFechas(){
		coherenciaFechaDeConfirmacion()
		coherenciaFechaDeEvento()
		coherenciaDeFechas()
	}
	private def void validarFechaConfirmacion() {
		if (fechaMaximaDeConfirmacion === null) {
			throw new BusinessException("No podes crear una evento sin una fecha de confirmacion")
		}
	}
	private def void validarLocacion() {
		if (locacion === null) {
			throw new BusinessException("No podes crear una evento sin una Ubicacion")
		}
	}
	private def void validarFechaDeFin() {
		if (fechaDeInicioDelEvento === null) {
			throw new BusinessException("No podes crear una evento sin una fecha de inicio")
		}
	}
	private def void validarFechaDeInicio() {
		if (fechaDeFinDelEvento === null) {
			throw new BusinessException("No podes crear una evento sin fecha de fin")
		}
	}
	private def void validarNombre() {
		if (nombre === null || nombre.length == 0) {
			throw new BusinessException("No podes crear un evento sin un nombre")
		}
	}
	public def boolean esExitoso()
	public def boolean esUnFracaso()
	public def void cancelarElEvento()
	protected def void tipoDeEventoPostergate()
	public def double capacidadMaxima()
	public def double cantidadDePersonasQueAsisten()
}
