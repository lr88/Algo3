package ar.edu.eventos

import java.time.Duration
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Evento {

	LocalDateTime fechaMaximaDeConfirmacion
	LocalDateTime fechaDeInicioDelEvento
	LocalDateTime fechaDeFinDelEvento
	String nombre
	Locacion locacion
	Usuario organizador
	var Boolean fuePostergado = false
	var Boolean fueCancelado = false
	
	
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
		fechaDeInicioDelEvento = fechaDeInicioDelEvento.plus(aux)
		fechaDeFinDelEvento = fechaDeFinDelEvento.plus(aux)
		fechaMaximaDeConfirmacion = fechaMaximaDeConfirmacion.plus(aux)
	}
	def boolean esExitoso()
	def boolean esUnFracaso()
	def void cancelarElEvento()
	def void postergarElEvento(LocalDateTime NuevaFechaDeInicioDelEvento)
	
}
