package ar.edu.eventos

import java.time.LocalDateTime

import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors

interface TipoDeUsuario {

	def void cancelarElEvento(Evento evento)

	def void postergarElEvento(Evento evento, LocalDateTime NuevaFechaDeInicioDelEvento)

	def void puedoOrganizarEventoAbierto(EventoAbierto unEvento, Usuario unUsuario)

	def void puedoOrganizarelEventoCerrado(EventoCerrado unEvento, Usuario unUsuario)

}

@Accessors
class Free implements TipoDeUsuario {
	int maximoDePersonasPorEvento = 50
	int maximoDeEventosMensuales = 3

	override cancelarElEvento(Evento evento) {
		throw new BusinessException("No podes Cancelar Eventos")
	}

	override postergarElEvento(Evento evento, LocalDateTime NuevaFechaDeInicioDelEvento) {
		throw new BusinessException("No podes postergar Eventos")
	}

	override puedoOrganizarEventoAbierto(EventoAbierto unEvento, Usuario unUsuario) {
		throw new BusinessException("No podes organizar Eventos Abiertos")
	}

	override puedoOrganizarelEventoCerrado(EventoCerrado unEvento, Usuario unUsuario) {
		validarEventosEsteMes(unEvento, unUsuario)
		validarEventosactivos(unEvento, unUsuario)
		validarcantidadDeInvitados(unEvento, unUsuario)
	}

	def validarEventosEsteMes(EventoCerrado unEvento, Usuario unUsuario) {
		if (unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales) {
		} else {
			throw new BusinessException("Superas la cantidad permitida por mes")
		}
	}
	def validarEventosactivos(EventoCerrado unEvento, Usuario unUsuario) {
		if (unUsuario.eventosActivos() < 1 ) {
		} else {
			throw new BusinessException("Superas la cantidad permitida a la vez")
		}
	}
	def validarcantidadDeInvitados(EventoCerrado unEvento, Usuario unUsuario) {
		if (unEvento.cantidadMaximaDeInvitados > maximoDePersonasPorEvento) {
		} else {
			throw new BusinessException("Superas la cantidad maxima de invitados")
		}
	}
	
	
	
}

class Amateur implements TipoDeUsuario {
	int maximoDeInvitacionesPorEvento = 50
	int cantidadMaximaPermitidaDeSimultaneidadDeEventos = 5

	override cancelarElEvento(Evento evento) {
		evento.cancelarElEvento()
	}

	override postergarElEvento(Evento evento, LocalDateTime NuevaFechaDeInicioDelEvento) {
		evento.cambiarFecha(NuevaFechaDeInicioDelEvento)
	}

	override puedoOrganizarEventoAbierto(EventoAbierto unEvento, Usuario unUsuario) {
		if (unUsuario.eventosActivos() < cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		} else {
			throw new BusinessException("Por Ser de tipo Amateur no podes organizar este Evento")
		}

	}

	override puedoOrganizarelEventoCerrado(EventoCerrado unEvento, Usuario unUsuario) {
		if (unUsuario.eventosActivos() < cantidadMaximaPermitidaDeSimultaneidadDeEventos &&
			unEvento.cantidadDeInvitaciones() < maximoDeInvitacionesPorEvento) {
		} else {
			throw new BusinessException("Por Ser de tipo Amateur no podes organizar este Evento")
		}
	}

	


}

class Profesional implements TipoDeUsuario {

	int maximoDeEventosMensuales = 20

	override cancelarElEvento(Evento evento) {
		evento.cancelarElEvento()
	}

	override postergarElEvento(Evento evento, LocalDateTime NuevaFechaDeInicioDelEvento) {
		evento.cambiarFecha(NuevaFechaDeInicioDelEvento)
	}

	override puedoOrganizarEventoAbierto(EventoAbierto unEvento, Usuario unUsuario) {
		if (unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales) {
		} else {
			throw new BusinessException("Por Ser de tipo Profesional no podes organizar este Evento")
		}
	}

	override puedoOrganizarelEventoCerrado(EventoCerrado unEvento, Usuario unUsuario) {
		if (unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales) {
		} else {
			throw new BusinessException("Por Ser de tipo Profesional no podes organizar este Evento")
		}
	}

}
