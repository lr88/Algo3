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

	def boolean coherenciaFechaDeConfirmacion() {
		if (fechaMaximaDeConfirmacion < fechaDeInicioDelEvento)
			true
		else
			throw new BusinessException("La fecha máxima de confirmación debe ser menor a la fecha de inicio")
	}

	def boolean coherenciaFechaDeEvento() {
		if (fechaDeFinDelEvento > fechaDeInicioDelEvento)
			true
		else
			throw new BusinessException(" La fecha/hora de fin debe ser mayor a la fecha/hora de inicio.")
	}
	
//	TODO: esta validación debe estar incluida en validar
	def boolean coherenciaDeFechas() {
		fechaMaximaDeConfirmacion < fechaDeInicioDelEvento && fechaDeFinDelEvento > fechaDeInicioDelEvento
	}

	def costoTotal() {
		servicios.fold(0.0, [acum, servicios|acum + servicios.costoDelServicio(this)])
	}

	def contratarServicio(Servicio unServicio) {
		servicios.add(unServicio)
	}

	def distanciaAmi(Point unaDirecion) {
		locacion.distancia(unaDirecion)
	}

	def tuOrganizadorEs(Usuario unUsuario) {
		organizador = unUsuario
	}

	def duracion() {
		Duration.between(fechaDeInicioDelEvento, fechaDeFinDelEvento).toHours()
	}

	def terminoElEvento() {
		Duration.between(fechaDeFinDelEvento, LocalDateTime.now).toMillis() < 0
	}

	def LocalDateTime fechaMáximaConfirmación() {
		fechaMaximaDeConfirmacion
	}

	def elEventoFuePostegadoOCancelado() {
		fueCancelado || fuePostergado
	}

	def void cambiarFecha(LocalDateTime nuevaFecha) {
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
