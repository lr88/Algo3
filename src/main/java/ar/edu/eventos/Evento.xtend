package ar.edu.eventos

import java.time.Duration
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Set
import java.util.HashSet
import org.uqbar.geodds.Point

@Accessors
abstract class Evento {

	LocalDateTime fechaMaximaDeConfirmacion
	LocalDateTime fechaDeInicioDelEvento
	LocalDateTime fechaDeFinDelEvento
	Set <Servicio> servicios = new HashSet()
	String nombre
	Locacion locacion 
	Usuario organizador
	var Boolean fuePostergado = false
	var Boolean fueCancelado = false
	
	def costoTotal(){
		1//servicios.fold(0, [acum, servicios|acum + servicios.costoDelServicio(this)])
	}
	def contratarServicio(Servicio unServicio){
		servicios.add(unServicio)
	}
	
	def distanciaAmi(Point unaDirecion) {
		locacion.distancia(unaDirecion)
	}
	
	def duracion() {
		Duration.between(fechaDeInicioDelEvento, fechaDeFinDelEvento).toHours()
	}

	def terminoElEvento() {
		Duration.between(fechaDeFinDelEvento, LocalDateTime.now).toMillis() < 0
	}
	
	def LocalDateTime fechaMáximaConfirmación(){
		fechaMaximaDeConfirmacion
	}
	
	def elEventoFuePostegadoOCancelado() {
		fueCancelado || fuePostergado
	}
	
	def void cambiarFecha(LocalDateTime nuevaFecha){
		var  aux = Duration.between(fechaDeInicioDelEvento,nuevaFecha)
		cambiarFechaInicio(aux)
		cambiarFechaFin(aux)
		cambiarFechaConfirmacion(aux)
		fuePostergado = true
		tipoDeEventoPostergate()
	}
	
	def cambiarFechaInicio(Duration aux){
		fechaDeInicioDelEvento = fechaDeInicioDelEvento.plus(aux)
	}
	def cambiarFechaFin(Duration aux){
		fechaDeFinDelEvento = fechaDeFinDelEvento.plus(aux)
	}
	def cambiarFechaConfirmacion(Duration aux){
		fechaMaximaDeConfirmacion = fechaMaximaDeConfirmacion.plus(aux)
	}

	def boolean esExitoso()
	def boolean esUnFracaso()
	def void cancelarElEvento()
	def void tipoDeEventoPostergate()
	
}
