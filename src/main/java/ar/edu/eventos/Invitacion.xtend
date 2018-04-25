package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Invitacion {

	Usuario usuario
	EventoCerrado evento
	
	boolean estadoAceptado = false
	boolean estadoRechazado = false
	
	int cantidadMaximaDeAcompañantes
	int cantidadDeAcompañantes

	new (Usuario unUsuario,int unaCantidadMaximaDeAcompañantes,EventoCerrado unEvento){
		cantidadMaximaDeAcompañantes = unaCantidadMaximaDeAcompañantes
		usuario = unUsuario
		evento = unEvento
	}

	def estadoPendiente (){
		!estadoAceptado || !estadoRechazado
	}
	
	def cancelarEvento() {
		usuario.eliminarInvitacion(this)
		usuario.recibirMensaje("El evento fue cancelado")
	}
	
	def postergarEvento() {
		usuario.recibirMensaje("se postergo el evento\n")
	}
	
	def invitarUsiario() {
		usuario.recibirMensaje("Fuiste Invitado al Evento "+ evento)
	}
	
	def elOrganizadorDelEvento() {
		evento.organizador
	}
	 
	def distanciaAmiCasa(Point unaDirecion) {
		evento.distanciaAmi(unaDirecion)
	}
}
