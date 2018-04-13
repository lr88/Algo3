package ar.edu.eventos

import java.time.LocalDateTime

interface TipoDeUsuario {

	LocalDateTime fechaActual = LocalDateTime.now
	Integer infinito = 99

	def abstract void organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion,
		Integer cantidadMaximaDePersonas, Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion,
		LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento)

	def void organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, Integer unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento)

	def abstract void cancelarElEvento(Usuario unUsuario,Evento unEvento)

	def abstract void postergarElEvento(Usuario unUsuario,Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento)

	def abstract boolean cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		Integer cantidadMaximaPermitidaDeSimultaneidadDeEventos)

	def abstract boolean puedoOrganizarUnEventoEsteMes(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		Integer maximoDeEventosMensuales)

	def abstract Integer cantidadMaximaPermitidaDeSimultaneidadDeEventos()

	def abstract Integer maximoDePersonasPorEvento()

	def abstract Integer maximoDeEventosMensuales()

	def abstract Integer maximoDeInvitacionesPorEvento()

}

class Free implements TipoDeUsuario {
	Integer cantidadMaximaPermitidaDeSimultaneidadDeEventos = 1
	Integer maximoDePersonasPorEvento = 50
	Integer maximoDeEventosMensuales = 3

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, Integer cantidadMaximaDePersonas,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {

		if (cantidadMaximaDePersonas < maximoDePersonasPorEvento &&
			puedoOrganizarUnEventoEsteMes(unUsuario, unInicioDelEvento, maximoDeEventosMensuales) &&
			cantidadPermitidaDeEventosALaVez(unUsuario, unInicioDelEvento,
				cantidadMaximaPermitidaDeSimultaneidadDeEventos)) {
		
		
			unUsuario.eventosCerrados.add(
				new EventoCerrado(unNombre, unaLocacion, cantidadMaximaDePersonas, unOrganizador, unaFechaMaximaDeConfirmacion,
					unInicioDelEvento, unFinDelEvento))
		}
	}

	override organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, Integer unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		unUsuario.mensajes.add("NO PODES ORGANIZAR EVENTOS ABIERTOS")

	}

	override cancelarElEvento(Usuario unUsuario,Evento unEvento) {
		unUsuario.mensajes.add("NO PODES CANCELAR UN EVENTOS ")

	}

	override postergarElEvento (Usuario unUsuario,Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento) {
		unUsuario.mensajes.add("NO PODES POSTERGAR UN EVENTOS")
	}

	override cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		Integer cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		unUsuario.EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(unInicioDelEvento,
			cantidadMaximaPermitidaDeSimultaneidadDeEventos)
	}

	override puedoOrganizarUnEventoEsteMes(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		Integer maximoDeEventosMensuales) {
		unUsuario.puedoOrganizarUnEventoEsteMes(unInicioDelEvento, maximoDeEventosMensuales)
	}

	override cantidadMaximaPermitidaDeSimultaneidadDeEventos() {
		cantidadMaximaPermitidaDeSimultaneidadDeEventos
	}

	override maximoDePersonasPorEvento() {
		maximoDePersonasPorEvento
	}

	override maximoDeEventosMensuales() {
		maximoDeEventosMensuales
	}

	override maximoDeInvitacionesPorEvento() {
		infinito
	}

}

class Amateur implements TipoDeUsuario {
	Integer maximoDeInvitacionesPorEvento = 50
	Integer cantidadMaximaPermitidaDeSimultaneidadDeEventos = 5

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, Integer cantidadMaximaDePersonas,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {

		if (cantidadPermitidaDeEventosALaVez(unUsuario, unInicioDelEvento,
			cantidadMaximaPermitidaDeSimultaneidadDeEventos)&&
			cantidadMaximaDePersonas <= maximoDeInvitacionesPorEvento) {

						
				unUsuario.eventosCerrados.add(
	
					new EventoCerrado(unNombre, unaLocacion, cantidadMaximaDePersonas, unOrganizador,
						unaFechaMaximaDeConfirmacion, unInicioDelEvento, unFinDelEvento))
			
		}
	}

	override cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		Integer cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		unUsuario.EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(unInicioDelEvento,
			cantidadMaximaPermitidaDeSimultaneidadDeEventos)
	}

	override organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, Integer unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		unUsuario.eventosAbiertos.add(
			new EventoAbierto(unNombre, unaLocacion, unUsuario, unValorDeLaEntrada, unaFechaMaximaDeConfirmacion,
				unInicioDelEvento, unFinDelEvento))

	}

	override cancelarElEvento(Usuario unUsuario,Evento unEvento) {
		unEvento.cancelarElEvento(unEvento)
	}

	override postergarElEvento(Usuario unUsuario,Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento) {
		unEvento.postergarElEvento(unEvento, NuevaFechaDeInicioDelEvento)
	}

	override puedoOrganizarUnEventoEsteMes(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		Integer maximoDeEventosMensuales) {
		true
	}

	override cantidadMaximaPermitidaDeSimultaneidadDeEventos() {
		cantidadMaximaPermitidaDeSimultaneidadDeEventos
	}

	override maximoDeInvitacionesPorEvento() {
		maximoDeInvitacionesPorEvento
	}

	override maximoDePersonasPorEvento() {
		infinito
	}

	override maximoDeEventosMensuales() {
		infinito
	}

}

class Profesional implements TipoDeUsuario {

	Integer maximoDeEventosMensuales = 20

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, Integer cantidadMaximaDePersonas,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {
		if (puedoOrganizarUnEventoEsteMes(unUsuario, unInicioDelEvento, maximoDeEventosMensuales)) {

			unUsuario.eventosCerrados.add(
				new EventoCerrado(unNombre, unaLocacion, cantidadMaximaDePersonas, unOrganizador, unaFechaMaximaDeConfirmacion,
					unInicioDelEvento, unFinDelEvento))

		}
	}

	override organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, Integer unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		unUsuario.eventosAbiertos.add(
			new EventoAbierto(unNombre, unaLocacion, unUsuario, unValorDeLaEntrada, unaFechaMaximaDeConfirmacion,
				unInicioDelEvento, unFinDelEvento))

	}

	override cancelarElEvento(Usuario unUsuario,Evento unEvento) {
		unEvento.cancelarElEvento(unEvento)
	}

	override postergarElEvento(Usuario unUsuario,Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento) {
		unEvento.postergarElEvento(unEvento,NuevaFechaDeInicioDelEvento)
	}

	override cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		Integer cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		true
	}

	override puedoOrganizarUnEventoEsteMes(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		Integer maximoDeEventosMensuales) {
		true
	}

	override maximoDeEventosMensuales() {
		maximoDeEventosMensuales
	}

	override cantidadMaximaPermitidaDeSimultaneidadDeEventos() {
		infinito
	}

	override maximoDePersonasPorEvento() {
		infinito
	}

	override maximoDeInvitacionesPorEvento() {
		infinito
	}

}