package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

import java.util.Set
import java.util.HashSet

@Accessors
class Invitacion {

	Usuario usuario
	boolean EstadoAceptado = false
	boolean EstadoPendiente = false
	boolean EstadoRechazado = false
	
	int cantidadMaximaDeAcompañantes
	int cantidadDeAcompañantes
	
	
	new(Usuario unUsuario, int unaCantidadMaximaDeAcompañantes) {
		usuario = unUsuario
		cantidadMaximaDeAcompañantes = unaCantidadMaximaDeAcompañantes
		
	}


}
