package ar.edu.eventos

import java.time.LocalDateTime

interface TipoDeUsuario {

	int infinito = 99
	
	def void cancelarElEvento(Usuario usuario, Evento evento)
	
	def void postergarElEvento(Usuario usuario, Evento evento, java.time.LocalDateTime time)
	
	def void organizarEventoAbierto(EventoAbierto unEvento)
	
	def void organizarEventoCerrado(EventoCerrado unEvento)

}

class Free implements TipoDeUsuario {
	int cantidadMaximaPermitidaDeSimultaneidadDeEventos = 1
	int maximoDePersonasPorEvento = 50
	int maximoDeEventosMensuales = 3
	
	override cancelarElEvento(Usuario usuario, Evento evento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override postergarElEvento(Usuario usuario, Evento evento, LocalDateTime time) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override organizarEventoAbierto(EventoAbierto unEvento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override organizarEventoCerrado(EventoCerrado unEvento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}

class Amateur implements TipoDeUsuario {
	int maximoDeInvitacionesPorEvento = 50
	int cantidadMaximaPermitidaDeSimultaneidadDeEventos = 5
	
	override cancelarElEvento(Usuario usuario, Evento evento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override postergarElEvento(Usuario usuario, Evento evento, LocalDateTime time) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override organizarEventoAbierto(EventoAbierto unEvento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override organizarEventoCerrado(EventoCerrado unEvento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}

class Profesional implements TipoDeUsuario {

	int maximoDeEventosMensuales = 20
	
	override cancelarElEvento(Usuario usuario, Evento evento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override postergarElEvento(Usuario usuario, Evento evento, LocalDateTime time) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override organizarEventoAbierto(EventoAbierto unEvento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override organizarEventoCerrado(EventoCerrado unEvento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
