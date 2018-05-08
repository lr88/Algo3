package ar.edu.eventos


import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors

interface TipoDeUsuario {
	def boolean puedoCancelarElEvento(Evento evento)

	def boolean puedoPostergarElEvento(Evento evento)

	def boolean puedoOrganizarEventoAbierto(EventoAbierto unEvento, Usuario unUsuario)

	def boolean puedoOrganizarelEventoCerrado(EventoCerrado unEvento, Usuario unUsuario)
}

@Accessors
class Free implements TipoDeUsuario {
	int maximoDePersonasPorEvento = 50
	int maximoDeEventosMensuales = 3

	override puedoCancelarElEvento(ar.edu.eventos.Evento evento) {
		throw new BusinessException("No podes Cancelar Eventos")
	}

	override puedoPostergarElEvento(ar.edu.eventos.Evento evento) {
		throw new BusinessException("No podes postergar Eventos")
	}

	override puedoOrganizarEventoAbierto(ar.edu.eventos.EventoAbierto unEvento, ar.edu.eventos.Usuario unUsuario) {
		throw new BusinessException("No podes organizar Eventos Abiertos")
	}

	override puedoOrganizarelEventoCerrado(ar.edu.eventos.EventoCerrado unEvento, ar.edu.eventos.Usuario unUsuario) {
		validarEventosEsteMes(unEvento, unUsuario)
		validarEventosactivos(unEvento, unUsuario)
		validarcantidadDeInvitados(unEvento, unUsuario)
	}

	def validarEventosEsteMes(ar.edu.eventos.EventoCerrado unEvento, ar.edu.eventos.Usuario unUsuario) {
		if (unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales) {
		} else {
			throw new BusinessException("Superas la cantidad permitida por mes")
		}
	}

	def validarEventosactivos(ar.edu.eventos.EventoCerrado unEvento, ar.edu.eventos.Usuario unUsuario) {
		if (unUsuario.eventosActivos() < 1) {
		} else {
			throw new BusinessException("Superas la cantidad permitida a la vez")
		}
	}

	def validarcantidadDeInvitados(ar.edu.eventos.EventoCerrado unEvento, ar.edu.eventos.Usuario unUsuario) {
		if (unEvento.cantidadMaximaDeInvitados > maximoDePersonasPorEvento) {
			true
		} else {
			throw new BusinessException("Superas la cantidad maxima de invitados")
		}
	}
}

class Amateur implements TipoDeUsuario {
	int maximoDeInvitacionesPorEvento = 50
	int cantidadMaximaPermitidaDeSimultaneidadDeEventos = 5

	override puedoCancelarElEvento(ar.edu.eventos.Evento evento) {
		true
	}

	override puedoPostergarElEvento(ar.edu.eventos.Evento evento) {
		true
	}

	override puedoOrganizarEventoAbierto(ar.edu.eventos.EventoAbierto unEvento, ar.edu.eventos.Usuario unUsuario) {
		if (unUsuario.eventosActivos() < cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
			true
		} else {
			throw new BusinessException("Por Ser de tipo Amateur no podes organizar este Evento")
		}
	}

	override puedoOrganizarelEventoCerrado(ar.edu.eventos.EventoCerrado unEvento, ar.edu.eventos.Usuario unUsuario) {
		if (unUsuario.eventosActivos() < cantidadMaximaPermitidaDeSimultaneidadDeEventos &&
			unEvento.cantidadDeInvitaciones() < maximoDeInvitacionesPorEvento) {
			true
		} else {
			throw new BusinessException("Por Ser de tipo Amateur no podes organizar este Evento")
		}
	}
	
}

class Profesional implements TipoDeUsuario {

	int maximoDeEventosMensuales = 20

	override puedoCancelarElEvento(ar.edu.eventos.Evento evento) {
		true
	}

	override puedoPostergarElEvento(ar.edu.eventos.Evento evento) {
		true
	}

	override puedoOrganizarEventoAbierto(ar.edu.eventos.EventoAbierto unEvento, ar.edu.eventos.Usuario unUsuario) {
		if (unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales) {
			true
		} else {
			throw new BusinessException("Por Ser de tipo Profesional no podes organizar este Evento")
		}
	}

	override puedoOrganizarelEventoCerrado(ar.edu.eventos.EventoCerrado unEvento, ar.edu.eventos.Usuario unUsuario) {
		if (unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales) {
			true
		} else {
			throw new BusinessException("Por Ser de tipo Profesional no podes organizar este Evento")
		}
	}
	
}
