package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.util.Set
import java.util.HashSet
import java.time.Duration

@Accessors
class EventoCerrado extends Evento {

	int cantidadMaxima
	Set<Invitacion> invitaciones = new HashSet()

	new(String unNombre, Locacion unaLocacion, int unaCantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		super(unNombre, unaLocacion, unOrganizador, unInicioDelEvento, unFinDelEvento)
		fechaMaximaDeConfirmacion = unaFechaMaximaDeConfirmacion
		cantidadMaxima = unaCantidadMaxima
	}

	def boolean esExitoso() {
		this.invitacionesAceptadasMasDelOchentaPorciento() && estadoDelEvento == true

	}

	def boolean esUnFracaso() {
		 cantidadDeInvitacionAceptadas() > cantidadDeInvitados()*0.5
	}
    
    
    def invitacionesAceptadasMasDelOchentaPorciento(){
    	invitaciones.filter[invitaciones|invitaciones.estadoAceptado].size()> cantidadDeInvitados()*0.8
    }
    
    def cantidadDeInvitacionAceptadas(){
    	invitaciones.filter[invitaciones|invitaciones.estadoAceptado].size()
    }
	/*def invitarAUnUsuario(Usuario unUsuario, int unaCantidadDeAcompañantes) {
		if (cantidadMaxima > (unaCantidadDeAcompañantes + 1) &&
			cuantosVamos < unUsuario.tipoDeUsuario.maximoDePersonasPorEvento &&
			invitaciones.size < unUsuario.tipoDeUsuario.maximoDeInvitacionesPorEvento) {
			invitaciones.add(new Invitacion(unUsuario, unaCantidadDeAcompañantes, this))

		}

	}*/
     
    def agregarInvitaciones(Invitacion unaInvitacion){
    	invitaciones.add(unaInvitacion)
    }
    
	/*def pedirConfirmacionDeLasEntradas() {
		invitaciones.forEach[invitacion|invitacion.pedirConfirmacion()]
	}*/



	override cancelarElEvento(Evento unEvento){
	    estadoDelEvento = true
		invitaciones.filter[invitacion | !invitacion.estadoRechazado].forEach[invitacion| invitacion.usuario.mensajes.add("El evento fue cancelado")]
		invitaciones.clear
	}

	override postergarElEvento(Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento){
		fuePostergado = true
		organizador.indicarNuevaFechaDeEvento(this,NuevaFechaDeInicioDelEvento) 
		invitaciones.forEach[invitacion |invitacion.usuario.mensajes.add("El evento se postergo")]
		
	}


     /*Las invitaciones pendientes de confirmación suman el total de sus invitados */
	def cantidadDeInvitacionesPendientes() {
		invitaciones.filter[invitacion|invitacion.estadoPendiente].size() + this.cantidadDeInvitados()
	}
    
    
    def cantidadDeInvitados(){
    	invitaciones.size()
    }
	
	/*Las invitaciones aceptadas suman uno + la cantidad de acompañantes confirmados. */
	def int cantidadDeInvitacionesAceptadas() {
			invitaciones.fold(0, [ acum, invitacion | acum + invitacion.cantidadDeAcompañantes ]) + 1
		}

	def cantidadDeInvitacionesRechazadas() {
	        0
	}

	def cantidadPosiblesDeAsistentes() {
		cantidadDeInvitacionesPendientes() + cantidadDeInvitacionesAceptadas()
	}
	
	override void cambiarFecha(LocalDateTime nuevaFecha){
		var  aux =	Duration.between(inicioDelEvento,nuevaFecha)
		inicioDelEvento = inicioDelEvento.plus(aux)
		finDelEvento = finDelEvento.plus(aux)
		fechaMaximaDeConfirmacion = fechaMaximaDeConfirmacion.plus(aux)
	}

}
