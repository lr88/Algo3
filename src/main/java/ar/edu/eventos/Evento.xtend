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

	LocalDateTime fechaMaximaDeConfirmacion
	LocalDateTime fechaDeInicioDelEvento
	LocalDateTime fechaDeFinDelEvento
	Set<Servicio> servicios = new HashSet()
	String nombre
	Locacion locacion
	Usuario organizador
	var Boolean fuePostergado = false
	var Boolean fueCancelado = false
	var Boolean enProceso = true

	private def coherenciaFechaDeConfirmacion() {
		if (!(fechaMaximaDeConfirmacion < fechaDeInicioDelEvento)) {
			throw new BusinessException("La fecha máxima de confirmación debe ser menor a la fecha de inicio")
		}
	}

	private def boolean coherenciaFechaDeEvento() {
		if (fechaDeFinDelEvento > fechaDeInicioDelEvento)
			true
		else
			throw new BusinessException(" La fecha/hora de fin debe ser mayor a la fecha/hora de inicio.")
	}
	
//	TODO: esta validación debe estar incluida en validar
	private def boolean coherenciaDeFechas() {
		fechaMaximaDeConfirmacion < fechaDeInicioDelEvento && fechaDeFinDelEvento > fechaDeInicioDelEvento
	}

	public def costoTotal() {
		servicios.fold(0.0, [acum, servicios|acum + servicios.costoDelServicio(this)])
	}

	public def contratarServicio(Servicio unServicio) {
		servicios.add(unServicio)
	}

	public def distanciaAmi(Point unaDirecion) {
		locacion.distancia(unaDirecion)
	}

	public def tuOrganizadorEs(Usuario unUsuario) {
		organizador = unUsuario
	}

	public def duracion() {
		Duration.between(fechaDeInicioDelEvento, fechaDeFinDelEvento).toHours()
	}

	public def terminoElEvento() {
		Duration.between(fechaDeFinDelEvento, LocalDateTime.now).toMillis() < 0
	}

	public def elEventoFuePostegadoOCancelado() {
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

	def cambiarFechaInicio(Duration aux) {
		fechaDeInicioDelEvento = fechaDeInicioDelEvento.plus(aux)
	}

	def cambiarFechaFin(Duration aux) {
		fechaDeFinDelEvento = fechaDeFinDelEvento.plus(aux)
	}

	def cambiarFechaConfirmacion(Duration aux) {
		fechaMaximaDeConfirmacion = fechaMaximaDeConfirmacion.plus(aux)
	}

	def validar() {
		validarNombre()
		validarFechaDeInicio()
		validarFechaDeFin()
		validarFechaConfirmacion()
		validarLocacion()
		validarCoherenciaFechas()
	}
	
	def void validarCoherenciaFechas(){
		coherenciaFechaDeConfirmacion()
		coherenciaFechaDeEvento()
		coherenciaDeFechas()
	}

	def validarFechaConfirmacion() {
		if (fechaMaximaDeConfirmacion === null) {
			throw new BusinessException("No podes crear una evento sin una fecha de confirmacion")
		}
	}

	def validarLocacion() {
		if (locacion === null) {
			throw new BusinessException("No podes crear una evento sin una Ubicacion")
		}
	}

	def validarFechaDeFin() {
		if (fechaDeInicioDelEvento === null) {
			throw new BusinessException("No podes crear una evento sin una fecha de inicio")
		}
	}

	def validarFechaDeInicio() {
		if (fechaDeFinDelEvento === null) {
			throw new BusinessException("No podes crear una evento sin fecha de fin")
		}
	}

	def validarNombre() {
		if (nombre === null || nombre.length == 0) {
			throw new BusinessException("No podes crear un evento sin un nombre")
		}
	}

	def boolean esExitoso()
	def boolean esUnFracaso()
	def void cancelarElEvento()
	def void tipoDeEventoPostergate()
	def double capacidadMaxima()
	def double cantidadDePersonasQueAsisten()
}
