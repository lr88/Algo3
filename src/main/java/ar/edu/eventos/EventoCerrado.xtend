package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.util.Set
import java.util.HashSet
import java.time.Duration

@Accessors
class EventoCerrado extends Evento {

	int cantidadMaximaDelEvento
	Set<Invitacion> invitaciones = new HashSet()

	new(String unNombre, Locacion unaLocacion, int unaCantidadMaximaDeInvitados, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		super(unNombre, unaLocacion, unOrganizador, unInicioDelEvento, unFinDelEvento)
		fechaMaximaDeConfirmacion = unaFechaMaximaDeConfirmacion
		cantidadMaximaDelEvento = unaCantidadMaximaDeInvitados
	}
	

	def boolean esExitoso() {
		this.cantidadDeInvitacionesAceptadas > cantidadDeInvitaciones *0.8 && fueCancelado == false
	}
	
	def boolean esUnFracaso() {
		 cantidadMaximaDelEvento *0.5 > cantidadDeInvitadosAceptadosMasSusAsistentes
		}
    
    def cantidadDeInvitacionesAceptadas(){ 
    	invitacionesAceptadas.size()
    }
    
    def invitacionesAceptadas(){ 
    	invitaciones.filter[invitaciones|invitaciones.estadoAceptado]
    }
    
    def int cantidadDeInvitadosAceptadosMasSusAsistentes() {
    		invitacionesAceptadas.fold(0, [ acum, invitacion | acum + invitacion.cantidadDeAcompañantes + 1 ]) 
		}
    
    def int cantidadDeInvitadosPendientesMasSusAsistentes() {
    		invitacionesPendientes.fold(0, [ acum, invitacion | acum + invitacion.cantidadDeAcompañantes + 1 ]) 
		}
     
     def invitacionesPendientes(){ 
    	invitaciones.filter[invitaciones|invitaciones.estadoPendiente]
    }
    
    def cantidaDePosiblesAsistentes(){ 
	
		cantidadDeInvitadosPendientesMasSusAsistentes + cantidadDeInvitadosAceptadosMasSusAsistentes 
	}
	
	
     
   override cancelarElEvento(Evento unEvento){ 
	    fueCancelado = true
		invitaciones.filter[invitacion | !invitacion.estadoRechazado].forEach[invitacion| invitacion.usuario.mensajes.add("El evento fue cancelado")]
		invitaciones.clear
	}

	override postergarElEvento(Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento){
		fuePostergado = true
		organizador.indicarNuevaFechaDeEvento(this,NuevaFechaDeInicioDelEvento) 
		invitaciones.forEach[invitacion |invitacion.usuario.mensajes.add("se postergo el evento")]
		
	}

    def cantidadDeInvitaciones(){
    	invitaciones.size()
    }
	
	override void cambiarFecha(LocalDateTime nuevaFecha){
		var  aux =	Duration.between(inicioDelEvento,nuevaFecha)
		inicioDelEvento = inicioDelEvento.plus(aux)
		finDelEvento = finDelEvento.plus(aux)
		fechaMaximaDeConfirmacion = fechaMaximaDeConfirmacion.plus(aux)
	}

}
