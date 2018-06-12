package ar.edu.eventos.Eventos

import ar.edu.eventos.Usuario.Usuario
import ar.edu.eventos.exceptions.BusinessException

abstract class Orden {
	protected val Invitacion invitacion
	protected var boolean estadoDeEjecucion = false
	protected val Usuario usuario 
	
	new (Invitacion unaInvitacion){
		invitacion = unaInvitacion
		usuario = invitacion.usuario
	}
	
	def void ejecutar() {}
	
	def validarEstadoPendienteDeEjecucion() {
		if(!estadoDeEjecucion){
			throw new BusinessException("la Orden ya fue anteriormente Ejecutada")
		}
	}
	
	def cambiarEstadoDeEjecucion(boolean bool){
		estadoDeEjecucion = bool
	}
	
	def void eliminarOrden(){
		invitacion.evento.eliminarOrden(this)
	}
	
}

class OrdenDeAceptacion extends Orden {
	
	protected val int cantidadDeAcompañantes
	
	new(Invitacion unaInvitacion,int unaCantidadDeAcompañantes ) {
		super(unaInvitacion)
		cantidadDeAcompañantes = unaCantidadDeAcompañantes
	}
	
	override void ejecutar() {
		validarEstadoPendienteDeEjecucion()
		usuario.aceptarInvitacion(invitacion,cantidadDeAcompañantes)
		cambiarEstadoDeEjecucion(true)
	}

//•	posibles escenarios a la hora de ejecutar una orden; aceptación exitosa, 
//•	Aceptación fallida (al momento de ejecutarla no se pueda aceptar la invitación porque se superaría la capacidad máxima). 
//En todos ellos se debe notificar al usuario invitado el resultado de su orden.
//unUsuario.recibirMensaje(String string)
}

class OrdenDeRechazo extends Orden {
	
	new(Invitacion unaInvitacion) {
		super(unaInvitacion)
	}
	
	override void ejecutar() {
		validarEstadoPendienteDeEjecucion()
		usuario.rechazarInvitacion(invitacion)
		cambiarEstadoDeEjecucion(true)
		usuario.recibirMensaje("Rechazo Exitoso")
	}

//    posibles escenarios a la hora de ejecutar una orden;  rechazo exitoso.
// En todos ellos se debe notificar al usuario invitado el resultado de su orden.
//    unUsuario.recibirMensaje(String string)
}
