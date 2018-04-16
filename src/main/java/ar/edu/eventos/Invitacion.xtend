package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Invitacion {

	Usuario usuario
	EventoCerrado evento
	
	boolean EstadoAceptado = false
	boolean EstadoPendiente = true
	boolean EstadoRechazado = false
	
	int cantidadMaximaDeAcompañantes
	int cantidadDeAcompañantes
	
	
	new(Usuario unUsuario, int unaCantidadMaximaDeAcompañantes,EventoCerrado unEvento) {
		usuario = unUsuario
		cantidadMaximaDeAcompañantes = unaCantidadMaximaDeAcompañantes
		evento = unEvento
		unUsuario.miListaDeInvitaciones.add(this)
		print("la invitacion Fue Realizada\n")
	}
	
	

}
