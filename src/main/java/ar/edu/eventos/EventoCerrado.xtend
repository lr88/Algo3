package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.util.Set
import java.util.HashSet


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
		cantidadMaxima * 0.8 < this.cuantosVamos && estadoDelEvento

	}

	def boolean esUnFracaso() {
		cantidadMaxima * 0.5 > this.cuantosVamos

	}

	def invitarAUnUsuario(Usuario unUsuario, int unaCantidadDeAcompañantes) {
		if (cantidadMaxima > (unaCantidadDeAcompañantes + 1) &&
			cuantosVamos < unUsuario.tipoDeUsuario.maximoDePersonasPorEvento &&
			invitaciones.size < unUsuario.tipoDeUsuario.maximoDeInvitacionesPorEvento) {
			invitaciones.add(new Invitacion(unUsuario, unaCantidadDeAcompañantes, this))

		}

	}

	def pedirConfirmacionDeLasEntradas() {
		invitaciones.forEach[invitacion|invitacion.pedirConfirmacion()]
	}

	def int cuantosVamos() {
		var int sumaTotal = 0
		var int i
		for (i = 0; i < invitaciones.size; i++) {
			sumaTotal = sumaTotal + invitaciones.get(i).usuarioEnEstadoConfirmado.size
		}
		sumaTotal
	}

	override cancelarElEvento(Usuario unUsuario, Evento unEvento){
		invitaciones.forEach[inv | inv.usuarioEnEstadoPendientes.forEach[usuar |usuar.mensajes.add("se cancelo el evento")]]
		invitaciones.forEach[inv | inv.usuario.mensajes.add("se cancelo el evento")]
		invitaciones.clear
	}

	override postergarElEvento(Usuario unUsuario, Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento){
		invitaciones.forEach[inv | inv.usuarioEnEstadoPendientes.forEach[usuar |usuar.mensajes.add("se postergo el evento")]]
		invitaciones.forEach[inv | inv.usuario.mensajes.add("se postergo el evento")]
			
	}



	def cantidadDeInvitacionesPendientes() {
		var int sumaTotal = 0
		var int i
		for (i = 0; i < invitaciones.size; i++) {
			sumaTotal = sumaTotal + invitaciones.get(i).usuarioEnEstadoPendientes.size
		}
		sumaTotal
	}

	
	def int cantidadDeInvitacionesAceptadas() {
			invitaciones.filter[inv | inv.estado == true ].size
		}

	def cantidadDeInvitacionesRechazadas() {
		var int sumaTotal = 0
		var int i
		for (i = 0; i < invitaciones.size; i++) {
			sumaTotal = sumaTotal + invitaciones.get(i).usuarioEnEstadoRechazados.size
		}
		sumaTotal
	}

	def cantidadPosiblesDeAsistentes() {
		cantidadDeInvitacionesPendientes() + cantidadDeInvitacionesAceptadas()
	}

}
