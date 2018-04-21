package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Invitacion {

	Usuario usuario
	EventoCerrado evento
	
	boolean estadoAceptado = false
	boolean estadoRechazado = false
	
	int cantidadMaximaDeAcompañantes
	int cantidadDeAcompañantes

	new (Usuario unUsuario,int unaCantidadMaximaDeAcompañantes){
		cantidadMaximaDeAcompañantes = unaCantidadMaximaDeAcompañantes
		usuario = unUsuario
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
	


}
