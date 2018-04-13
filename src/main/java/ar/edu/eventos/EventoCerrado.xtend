package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.util.Set
import java.util.HashSet
import java.time.Duration

@Accessors
class EventoCerrado extends Evento {

	Integer cantidadMaximaDeInvitados
	Set<Invitacion> invitaciones = new HashSet()

	new(String unNombre, Locacion unaLocacion, Integer unaCantidadMaximaDeInvitados, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		super(unNombre, unaLocacion, unOrganizador, unInicioDelEvento, unFinDelEvento)
		fechaMaximaDeConfirmacion = unaFechaMaximaDeConfirmacion
		cantidadMaximaDeInvitados = unaCantidadMaximaDeInvitados
	}
	
	def Integer capacidadMaxima() {
		cantidadMaximaDeInvitados
	}

	def LocalDateTime fechaMáximaConfirmación(){
		fechaMaximaDeConfirmacion
	}

	def boolean esExitoso() {
		cantidadDeInvitacionesAceptadas > cantidadDeInvitaciones *0.8 && fueCancelado == false
	}
	
	def boolean esUnFracaso() {
		 cantidadMaximaDeInvitados * 0.5 > cantidadDeInvitadosAceptadosMasSusAsistentes
		}
    
    def Integer cantidadDeInvitacionesAceptadas(){ 
    	listaDeInvitacionesAceptadas.size()
    }
    
    def  listaDeInvitacionesAceptadas(){ 
    	invitaciones.filter[invitaciones|invitaciones.estadoAceptado]
    }
    
    def Integer cantidadDeInvitadosAceptadosMasSusAsistentes() {
    		listaDeInvitacionesAceptadas.fold(0, [ acum, invitacion | acum + invitacion.cantidadDeAcompañantes + 1 ]) 
		}
    
    def Integer cantidadDeInvitadosPendientesMasSusAsistentes() {
    		listaDeInvitacionesPendientes.fold(0, [ acum, invitacion | acum + invitacion.cantidadDeAcompañantes + 1 ]) 
		}
     
     def  listaDeInvitacionesPendientes(){ 
    	invitaciones.filter[invitaciones|invitaciones.estadoPendiente]
    }
    
    def Integer cantidaDePosiblesAsistentes(){ 
		cantidadDeInvitadosPendientesMasSusAsistentes + cantidadDeInvitadosAceptadosMasSusAsistentes 
	}
	
   override void cancelarElEvento(Evento unEvento){ 
	    fueCancelado = true
		invitaciones.filter[invitacion | !invitacion.estadoRechazado].forEach[invitacion| invitacion.usuario.mensajes.add("El evento fue cancelado")]
		invitaciones.clear
	}

	override void postergarElEvento(Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento){
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
