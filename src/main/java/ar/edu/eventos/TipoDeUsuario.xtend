package ar.edu.eventos

import java.time.LocalDateTime

interface TipoDeUsuario {

	LocalDateTime fechaActual = LocalDateTime.now
	int infinito = 99

	def abstract void organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion,
		int cantidadMaxima, Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion,
		LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento)

	def void organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento)

	def abstract void cancelarEventoAbierto(Usuario unUsuario, Evento unEvento)

	def abstract void cancelarEventoCerrado(Usuario unUsuario, Evento unEvento)

	def abstract void postergarEvento(Usuario unUsuario, Evento unEvento)

	def abstract boolean cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int cantidadMaximaPermitidaDeSimultaneidadDeEventos)

	def abstract boolean puedoOrganizarUnEventoEsteMes(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int maximoDeEventosMensuales)

	def abstract int cantidadMaximaPermitidaDeSimultaneidadDeEventos()

	def abstract int maximoDePersonasPorEvento()

	def abstract int maximoDeEventosMensuales()

	def abstract int maximoDeInvitacionesPorEvento()

}

class Free implements TipoDeUsuario {
	int cantidadMaximaPermitidaDeSimultaneidadDeEventos = 1
	int maximoDePersonasPorEvento = 50
	int maximoDeEventosMensuales = 3

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, int cantidadMaxima,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {

		if (cantidadMaxima < maximoDePersonasPorEvento &&
			puedoOrganizarUnEventoEsteMes(unUsuario, unInicioDelEvento, maximoDeEventosMensuales) &&
			cantidadPermitidaDeEventosALaVez(unUsuario, unInicioDelEvento,
				cantidadMaximaPermitidaDeSimultaneidadDeEventos)) {
			unUsuario.eventosCerrados.add(
				new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion,
					unInicioDelEvento, unFinDelEvento))
		}
	}

	override organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		unUsuario.recibirMensaje("NO PODES ORGANIZAR EVENTOS ABIERTOS")

	}

	override cancelarEventoAbierto(Usuario unUsuario, Evento unEvento) {
		unUsuario.recibirMensaje("NO PODES CANCELAR UN EVENTOS ")

	}

	override cancelarEventoCerrado(Usuario unUsuario, Evento unEvento) {
		unUsuario.recibirMensaje("NO PODES CANCELAR UN EVENTOS ")

	}

	override postergarEvento(Usuario unUsuario, Evento unEvento) {
		unUsuario.recibirMensaje("NO PODES POSTERGAR UN EVENTOS")
	}

	override cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		unUsuario.EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(unInicioDelEvento,
			cantidadMaximaPermitidaDeSimultaneidadDeEventos)
	}

	override puedoOrganizarUnEventoEsteMes(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int maximoDeEventosMensuales) {
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
	int maximoDeInvitacionesPorEvento = 50
	int cantidadMaximaPermitidaDeSimultaneidadDeEventos = 5

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, int cantidadMaxima,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {
		if (cantidadPermitidaDeEventosALaVez(unUsuario, unInicioDelEvento,
			cantidadMaximaPermitidaDeSimultaneidadDeEventos)) {
			if (cantidadMaxima <= maximoDeInvitacionesPorEvento) {
				unUsuario.eventosCerrados.add(
					new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador,
						unaFechaMaximaDeConfirmacion, unInicioDelEvento, unFinDelEvento))
			}
		}
	}

	override cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		unUsuario.EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(unInicioDelEvento,
			cantidadMaximaPermitidaDeSimultaneidadDeEventos)
	}

	override organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		unUsuario.eventosAbiertos.add(
			new EventoAbierto(unNombre, unaLocacion, unUsuario, unValorDeLaEntrada, unaFechaMaximaDeConfirmacion,
				unInicioDelEvento, unFinDelEvento))

	}

	override cancelarEventoAbierto(Usuario unUsuario, Evento unEvento) {
	}

	override cancelarEventoCerrado(Usuario unUsuario, Evento unEvento) {
	}

	override postergarEvento(Usuario unUsuario, Evento unEvento) {
	}

	override puedoOrganizarUnEventoEsteMes(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int maximoDeEventosMensuales) {
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

	int maximoDeEventosMensuales = 20

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, int cantidadMaxima,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {
		if (puedoOrganizarUnEventoEsteMes(unUsuario, unInicioDelEvento, maximoDeEventosMensuales)) {

			unUsuario.eventosCerrados.add(
				new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion,
					unInicioDelEvento, unFinDelEvento))

		}
	}

	override organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		unUsuario.eventosAbiertos.add(
			new EventoAbierto(unNombre, unaLocacion, unUsuario, unValorDeLaEntrada, unaFechaMaximaDeConfirmacion,
				unInicioDelEvento, unFinDelEvento))

	}

	override cancelarEventoAbierto(Usuario unUsuario, Evento unEvento) {
	}

	override cancelarEventoCerrado(Usuario unUsuario, Evento unEvento) {
	}

	override postergarEvento(Usuario unUsuario, Evento unEvento) {
	}

	override cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		true
	}

	override puedoOrganizarUnEventoEsteMes(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int maximoDeEventosMensuales) {
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
