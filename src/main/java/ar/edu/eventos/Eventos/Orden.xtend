package ar.edu.eventos.Eventos

abstract class Orden {
	val Invitacion invitacion
	
	new (Invitacion unaInvitacion){
		invitacion = unaInvitacion
	}
	
	def ejecutar() {}
}

class OrdenDeAceptacion extends Orden {

	new(Invitacion unaInvitacion) {
		super(unaInvitacion)
	}
	
	override ejecutar() {}

//•	posibles escenarios a la hora de ejecutar una orden; aceptación exitosa, 
//•	Aceptación fallida (al momento de ejecutarla no se pueda aceptar la invitación porque se superaría la capacidad máxima). 
//En todos ellos se debe notificar al usuario invitado el resultado de su orden.
//unUsuario.recibirMensaje(String string)
}

class OrdenDeRechazo extends Orden {

	new(Invitacion unaInvitacion) {
		super(unaInvitacion)
	}
	
	override ejecutar() {}

//    posibles escenarios a la hora de ejecutar una orden;  rechazo exitoso.
// En todos ellos se debe notificar al usuario invitado el resultado de su orden.
//    unUsuario.recibirMensaje(String string)
}
