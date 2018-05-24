package ar.edu.eventos


import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors

interface TipoDeUsuario {
	
	def void puedoCancelarElEvento(Evento evento)

	def void puedoPostergarElEvento(Evento evento)

	def void puedoOrganizarEventoAbierto(Evento unEvento, Usuario unUsuario)

	def void puedoOrganizarelEventoCerrado(Evento unEvento, Usuario unUsuario)
}

@Accessors
class Free implements TipoDeUsuario {
	int maximoDePersonasPorEvento = 50
	int maximoDeEventosMensuales = 3

	override puedoCancelarElEvento(Evento evento) {
		throw new BusinessException("No podes Cancelar Eventos")
	}

	override puedoPostergarElEvento(Evento evento) {
		throw new BusinessException("No podes postergar Eventos")
	}

	override puedoOrganizarEventoAbierto(Evento unEvento, Usuario unUsuario) {
		throw new BusinessException("No podes organizar Eventos Abiertos")
	}

	override puedoOrganizarelEventoCerrado(Evento unEvento, Usuario unUsuario) {
		validarEventosEsteMes(unEvento, unUsuario)
		validarEventosactivos(unEvento, unUsuario)
		validarcantidadDeInvitados(unEvento, unUsuario)
	}

	def validarEventosEsteMes(Evento unEvento, Usuario unUsuario) {
		if (!(unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales)){
		throw new BusinessException("Superas la cantidad permitida por mes")
		}
	}

	def validarEventosactivos(Evento unEvento, Usuario unUsuario) {
		if (!(unUsuario.eventosActivos() < 1)) {
			throw new BusinessException("Superas la cantidad permitida a la vez")
	}}

	def validarcantidadDeInvitados(Evento unEvento, Usuario unUsuario) {
		if (!(unEvento.cantidadDePersonasQueAsisten < maximoDePersonasPorEvento)) {
			throw new BusinessException("Superas la cantidad maxima de invitados")
		}
	}
}

class Amateur implements TipoDeUsuario {
	int maximoDeInvitacionesPorEvento = 50
	int cantidadMaximaPermitidaDeSimultaneidadDeEventos = 5

	override puedoCancelarElEvento(ar.edu.eventos.Evento evento) {
	}

	override puedoPostergarElEvento(ar.edu.eventos.Evento evento) {
	}

	override puedoOrganizarEventoAbierto(Evento unEvento, Usuario unUsuario) {
		if (!(unUsuario.eventosActivos() < cantidadMaximaPermitidaDeSimultaneidadDeEventos)) {
			throw new BusinessException("Por Ser de tipo Amateur no podes organizar este Evento")
		}
	}

	override puedoOrganizarelEventoCerrado(Evento unEvento, Usuario unUsuario) {
		if (!(unUsuario.eventosActivos() < cantidadMaximaPermitidaDeSimultaneidadDeEventos &&
			unEvento.cantidadDePersonasQueAsisten() < maximoDeInvitacionesPorEvento)) {
			throw new BusinessException("Por Ser de tipo Amateur no podes organizar este Evento")
		}
	}
	
}

class Profesional implements TipoDeUsuario {

	int maximoDeEventosMensuales = 20

	override puedoCancelarElEvento(Evento evento) {
	}

	override puedoPostergarElEvento(Evento evento) {
	}

	override puedoOrganizarEventoAbierto(Evento unEvento,Usuario unUsuario) {
		if (!(unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales)) {
			throw new BusinessException("Por Ser de tipo Profesional no podes organizar este Evento")
		}
	}

	override puedoOrganizarelEventoCerrado(Evento unEvento, Usuario unUsuario) {
		if (!(unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales)) {
			throw new BusinessException("Por Ser de tipo Profesional no podes organizar este Evento")
		}
	}
	
}
