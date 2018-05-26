package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Invitacion {

	protected Usuario usuario
	protected EventoCerrado evento
	protected boolean estadoAceptado = false
	protected boolean estadoRechazado = false
	protected int cantidadMaximaDeAcompañantes
	protected int cantidadDeAcompañantes

	new (Usuario unUsuario,int unaCantidadMaximaDeAcompañantes,EventoCerrado unEvento){
		cantidadMaximaDeAcompañantes = unaCantidadMaximaDeAcompañantes
		usuario = unUsuario
		evento = unEvento
	}

	public def boolean estadoPendiente (){
		!estadoAceptado || !estadoRechazado
	}
	
	public def void cancelarEvento() {
		usuario.eliminarInvitacion(this)
		usuario.recibirMensaje("El evento fue cancelado")
	}
	
	public def void postergarEvento() {
		usuario.recibirMensaje("se postergo el evento\n")
	}
	
	public def void invitarUsiario() {
		usuario.recibirMensaje("Fuiste Invitado al Evento "+ evento)
	}
	
	public def  elOrganizadorDelEvento() {
		evento.organizador
	}
	 
	public def double distanciaAmiCasa(Point unaDirecion) {
		evento.distancia(unaDirecion)
	}
}
