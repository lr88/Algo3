package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import java.util.HashSet
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EventoCerrado extends Evento {

	private var double cantidadMaximaDeInvitados
	Set<Invitacion> invitaciones = new HashSet()

	public override double capacidadMaxima() {
		cantidadMaximaDeInvitados
	}
	public override boolean esExitoso() {
		invitacionesAceptadasVSInvitaciones && fueCancelado == false
	}
	private def invitacionesAceptadasVSInvitaciones(){
		cantidadDeInvitacionesAceptadas > cantidadDeInvitaciones * 0.8
	}
	public override boolean esUnFracaso() {
		cantidadMaximaDeInvitados * 0.5 > cantidadDeInvitadosAceptadosMasSusAsistentes
	}
	private def int cantidadDeInvitadosAceptadosMasSusAsistentes() {
		listaDeInvitacionesAceptadas.fold(0, [acum, invitacion|acum + invitacion.cantidadDeAcompañantes + 1])
	}
	private def int cantidadDeInvitadosPendientesMasElMaximoDeAsistentes() {
		listaDeInvitacionesPendientes.fold(0, [acum, invitacion|acum + invitacion.cantidadDeAcompañantes + 1])
	}
	private def cantidadDeInvitaciones() {
		invitaciones.size()
	}
	public def int cantidadDeInvitacionesAceptadas() {
		listaDeInvitacionesAceptadas.size()
	}
	
	private def listaDeInvitacionesAceptadas() {
		invitaciones.filter[invitaciones|invitaciones.estadoAceptado]
	}
	private def listaDeInvitacionesPendientes() {
		invitaciones.filter[invitaciones|invitaciones.estadoPendiente]
	}
	private def int cantidaDePosiblesAsistentes() {
		cantidadDeInvitadosPendientesMasElMaximoDeAsistentes + cantidadDeInvitadosAceptadosMasSusAsistentes
	}
	public override void cancelarElEvento() {
		fueCancelado = true
		enProceso = false
		invitaciones.forEach[invitacion|invitacion.cancelarEvento]
		invitaciones.clear
	}
	public override void tipoDeEventoPostergate() {
		invitaciones.forEach[invitacion|invitacion.postergarEvento()]
	}
	public def invitarAUnUsuario(Usuario unUsuario, int unaCantidadMaximaDeAcompañantes) {
		validarAsistentesVSAcompañantesParaInvitarAAlguien(unaCantidadMaximaDeAcompañantes)
		var Invitacion unaInvitacion = new Invitacion(unUsuario, unaCantidadMaximaDeAcompañantes, this)
		unaInvitacion.invitarUsiario
		unUsuario.agregarInvitacion(unaInvitacion)
		invitaciones.add(unaInvitacion)
	}
	private def validarAsistentesVSAcompañantesParaInvitarAAlguien(int unaCantidadMaximaDeAcompañantes) {
		if (!(cantidaDePosiblesAsistentes+unaCantidadMaximaDeAcompañantes < cantidadMaximaDeInvitados)) {
		throw new BusinessException("No se puede crear invitacion, supera la cantidad maxima del evento")
		}
	}
	public override cantidadDePersonasQueAsisten() {
		cantidadDeInvitadosAceptadosMasSusAsistentes()
	}
	
}
