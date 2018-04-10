package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

import java.util.Set
import java.util.HashSet

@Accessors
class Invitacion {

	Usuario usuario
	EventoCerrado eventoCerrado
	boolean estado = false
	int cantidadMaximaDeAcompañantes
	Set<Usuario> UsuarioEnEstadoConfirmado = new HashSet()
	Set<Usuario> UsuarioEnEstadoPendientes = new HashSet()
	Set<Usuario> UsuarioEnEstadoRechazados = new HashSet()
	
	
	
	new(Usuario unUsuario, int unaCantidadMaximaDeAcompañantes, EventoCerrado unEventoCerrado) {
		usuario = unUsuario
		cantidadMaximaDeAcompañantes = unaCantidadMaximaDeAcompañantes
		eventoCerrado = unEventoCerrado
		procesoDecreacionDeLaInvitacion(unUsuario)

	}

	def procesoDecreacionDeLaInvitacion(Usuario unUsuario) {
		UsuarioEnEstadoPendientes.add(unUsuario)
		unUsuario.invitacionesPendientes.add(this)
		unUsuario.amigos.forEach[amigo|UsuarioEnEstadoPendientes.add(amigo)]
		unUsuario.amigos.forEach[amigo| amigo.invitacionesPendientes.add(this)]
		
	}
	def pedirConfirmacion() {
		queresVenir()
		cuantosSomos()
		
	}

	def cuantosSomos() {
		if (estado) {
			UsuarioEnEstadoPendientes.forEach[amigo|amigo.queresVenir(this)]
			
		}
	}

	def queresVenir() {
		if (usuario.queresVenir(this)) {
			UsuarioEnEstadoPendientes.remove(usuario)
			UsuarioEnEstadoConfirmado.add(usuario)
			estado = true
		}
		else{
			UsuarioEnEstadoPendientes.remove(usuario)
			UsuarioEnEstadoRechazados.add(usuario)
			estado = false
		}
	
	
	}

}
