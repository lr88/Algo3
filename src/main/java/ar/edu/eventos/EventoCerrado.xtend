package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import java.util.HashSet
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EventoCerrado extends Evento {

	int cantidadMaximaDeInvitados
	Set<Invitacion> invitaciones = new HashSet()

	def int capacidadMaxima() {
		cantidadMaximaDeInvitados
	}

	override boolean esExitoso() {
		cantidadDeInvitacionesAceptadas > cantidadDeInvitaciones * 0.8 && fueCancelado == false
	}

	override boolean esUnFracaso() {
		cantidadMaximaDeInvitados * 0.5 > cantidadDeInvitadosAceptadosMasSusAsistentes
	}

	def int cantidadDeInvitadosAceptadosMasSusAsistentes() {
		listaDeInvitacionesAceptadas.fold(0, [acum, invitacion|acum + invitacion.cantidadDeAcompañantes + 1])
	}

	def int cantidadDeInvitadosPendientesMasElMaximoDeAsistentes() {
		listaDeInvitacionesPendientes.fold(0, [acum, invitacion|acum + invitacion.cantidadDeAcompañantes + 1])
	}

	def cantidadDeInvitaciones() {
		invitaciones.size()
	}

	def int cantidadDeInvitacionesAceptadas() {
		listaDeInvitacionesAceptadas.size()
	}

	def listaDeInvitacionesAceptadas() {
		invitaciones.filter[invitaciones|invitaciones.estadoAceptado]
	}

	def listaDeInvitacionesPendientes() {
		invitaciones.filter[invitaciones|invitaciones.estadoPendiente]
	}

	def int cantidaDePosiblesAsistentes() {
		cantidadDeInvitadosPendientesMasElMaximoDeAsistentes + cantidadDeInvitadosAceptadosMasSusAsistentes
	}

	override void cancelarElEvento() {
		fueCancelado = true
		invitaciones.forEach[invitacion|invitacion.cancelarEvento]
		invitaciones.clear
	}

	override void tipoDeEventoPostergate() {
		invitaciones.forEach[invitacion|invitacion.postergarEvento()]
	}

	def invitarAUnUsiario(Usuario unUsuario, int unaCantidadMaximaDeAcompañantes) {
		validarAsistentesVSAcompañantes(unaCantidadMaximaDeAcompañantes)
		var Invitacion unaInvitacion = new Invitacion(unUsuario, unaCantidadMaximaDeAcompañantes, this)
		unaInvitacion.invitarUsiario
		invitaciones.add(unaInvitacion)

	}

	def validarAsistentesVSAcompañantes(int unaCantidadMaximaDeAcompañantes) {
		if (cantidaDePosiblesAsistentes < cantidadMaximaDeInvitados) {
		} else {
			throw new BusinessException("No se puede crear invitacion, supera la cantidad maxima del evento")
		}
	}
}
