package ar.edu.eventos

import java.time.LocalDateTime

import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors

interface TipoDeUsuario {

	def void cancelarElEvento(Evento evento)

	def void postergarElEvento(Evento evento, LocalDateTime NuevaFechaDeInicioDelEvento)

	def void organizarEventoAbierto(EventoAbierto unEvento, Usuario unUsuario)

	def void organizarEventoCerrado(EventoCerrado unEvento, Usuario unUsuario)

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

	override organizarEventoAbierto(EventoAbierto unEvento, Usuario unUsuario) {
		throw new BusinessException("No podes organizar Eventos Abiertos")
	}

	override organizarEventoCerrado(EventoCerrado unEvento, Usuario unUsuario) {
		if (unUsuario.cantidadDeEventosEnEsteMes(unEvento) 
			> maximoDeEventosMensuales &&
			unUsuario.eventosActivos() < 0 
			&& unEvento.cantidadMaximaDeInvitados > 
			maximoDePersonasPorEvento)
			unUsuario.AgregarEventoCerrado(unEvento)
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

	override organizarEventoAbierto(EventoAbierto unEvento, Usuario unUsuario) {
		if (unUsuario.eventosActivos() < cantidadMaximaPermitidaDeSimultaneidadDeEventos)
			unUsuario.AgregarEventoAbierto(unEvento)
	}

	override organizarEventoCerrado(EventoCerrado unEvento, Usuario unUsuario) {
		if (unUsuario.eventosActivos() < cantidadMaximaPermitidaDeSimultaneidadDeEventos &&
			unEvento.cantidadDeInvitaciones() < maximoDeInvitacionesPorEvento)
			unUsuario.AgregarEventoCerrado(unEvento)
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

	override organizarEventoAbierto(EventoAbierto unEvento, Usuario unUsuario) {
		
		if (unUsuario.cantidadDeEventosEnEsteMes(unEvento) > maximoDeEventosMensuales)
			unUsuario.AgregarEventoAbierto(unEvento)
	}

	override organizarEventoCerrado(EventoCerrado unEvento, Usuario unUsuario) {
		if (unUsuario.cantidadDeEventosEnEsteMes(unEvento) > maximoDeEventosMensuales)
			unUsuario.AgregarEventoCerrado(unEvento)
	}

}
