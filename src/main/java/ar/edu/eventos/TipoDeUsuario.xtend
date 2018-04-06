package ar.edu.eventos

import java.time.LocalDateTime

interface TipoDeUsuario {

	LocalDateTime fechaActual = LocalDateTime.now

	def abstract void organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion,
		int cantidadMaxima, Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion,
		LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento)

	def void organizarEventoAbierto(Usuario unUsuario, String unNombre, Locacion unaLocacion, Usuario unOrganizador,
		int unValorDeLaEntrada, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento)

	def abstract void cancelarEvento()

	def abstract void postergarEvento()

	def abstract boolean cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int cantidadMaximaPermitidaDeSimultaneidadDeEventos)

	def abstract boolean puedoOrganizarUnEventoEsteMes(Usuario unUsuario,LocalDateTime unInicioDelEvento, int maximoDeEventosMensuales)

}

class Free implements TipoDeUsuario {
	int cantidadMaximaPermitidaDeSimultaneidadDeEventos = 1
	int maximoDePersonasPorEvento = 50
	int maximoDeEventosMensuales = 3

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, int cantidadMaxima,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {

		if (cantidadMaxima < maximoDePersonasPorEvento &&	puedoOrganizarUnEventoEsteMes( unUsuario,unInicioDelEvento, maximoDeEventosMensuales) &&	cantidadPermitidaDeEventosALaVez(unUsuario, unInicioDelEvento, cantidadMaximaPermitidaDeSimultaneidadDeEventos)) {
			new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion,unInicioDelEvento, unFinDelEvento)
		}
	}

	override organizarEventoAbierto(Usuario unUsuario, String unNombre, Locacion unaLocacion, Usuario unOrganizador,
		int unValorDeLaEntrada, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {
		print("NO PODES ORGANIZAR EVENTOS ABIERTOS")
	}

	override cancelarEvento() {
		print("NO PODES CANCELAR UN EVENTOS ")
	}

	override postergarEvento() {
		print("NO PODES POSTERGAR UN EVENTOS")
	}

	override cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		unUsuario.EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(unInicioDelEvento,
			cantidadMaximaPermitidaDeSimultaneidadDeEventos)
	}
	
	override puedoOrganizarUnEventoEsteMes(Usuario unUsuario,LocalDateTime unInicioDelEvento, int maximoDeEventosMensuales) {
		unUsuario.puedoOrganizarUnEventoEsteMes(unInicioDelEvento, maximoDeEventosMensuales)
	}

}

class Amateur implements TipoDeUsuario {
	int maximoDeInvitacionesPorEvento = 50 // Pueden entregar un máximo de 50 invitaciones por evento, pero las invitaciones no tienen máximo de acompañantes, por lo que la cantidad total de invitados no tiene límite.
	int cantidadMaximaPermitidaDeSimultaneidadDeEventos = 5

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, int cantidadMaxima,	Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,	LocalDateTime unFinDelEvento) {
		if (cantidadPermitidaDeEventosALaVez(unUsuario, unInicioDelEvento,cantidadMaximaPermitidaDeSimultaneidadDeEventos)) {
			if(cantidadMaxima<=maximoDeInvitacionesPorEvento){
			new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion,
				unInicioDelEvento, unFinDelEvento)
			}
		}
	}

	override cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,int cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		unUsuario.EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(unInicioDelEvento,	cantidadMaximaPermitidaDeSimultaneidadDeEventos)
	}

	override organizarEventoAbierto(Usuario unUsuario, String unNombre, Locacion unaLocacion, Usuario unOrganizador,
		int unValorDeLaEntrada, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {
	}

	override cancelarEvento() {
	}

	override postergarEvento() {
	}
	
	override puedoOrganizarUnEventoEsteMes(Usuario unUsuario, LocalDateTime unInicioDelEvento, int maximoDeEventosMensuales) {
		true
	}

}

class Profesional implements TipoDeUsuario {

	int maximoDeEventosMensuales = 20


	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, int cantidadMaxima,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {
		if (puedoOrganizarUnEventoEsteMes( unUsuario, unInicioDelEvento, maximoDeEventosMensuales)) {

		new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion,
			unInicioDelEvento, unFinDelEvento)

	}}

	override organizarEventoAbierto(Usuario unUsuario, String unNombre, Locacion unaLocacion, Usuario unOrganizador,
		int unValorDeLaEntrada, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {
			
			
	}

	override cancelarEvento() {
	}

	override postergarEvento() {
	}

	override cantidadPermitidaDeEventosALaVez(Usuario unUsuario, LocalDateTime unInicioDelEvento,
		int cantidadMaximaPermitidaDeSimultaneidadDeEventos) {
			true
	}
	
	override puedoOrganizarUnEventoEsteMes(Usuario unUsuario, LocalDateTime unInicioDelEvento, int maximoDeEventosMensuales) {
	true
	}

}
