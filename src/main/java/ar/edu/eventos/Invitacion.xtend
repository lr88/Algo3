package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Invitacion {

	Usuario usuario
	EventoCerrado evento
	
	boolean EstadoAceptado = false
	boolean EstadoPendiente = true
	boolean EstadoRechazado = false
	
	Integer cantidadMaximaDeAcompañantes
	Integer cantidadDeAcompañantes
	
	
	new(Usuario unUsuario, Integer unaCantidadMaximaDeAcompañantes,EventoCerrado unEvento) {
		usuario = unUsuario
		cantidadMaximaDeAcompañantes = unaCantidadMaximaDeAcompañantes
		evento = unEvento
		unUsuario.miListaDeInvitaciones.add(this)
	}
	
	

}
