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

}

class Free implements TipoDeUsuario {

	int maximoDePersonasPorEvento = 50

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, int cantidadMaxima,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {

		if (cantidadMaxima > maximoDePersonasPorEvento && unUsuario.puedoOrganizarUnEventoEsteMes(unInicioDelEvento) &&
			unUsuario.EstoyOrganizandoDosEventosALaVez(unInicioDelEvento)) {
			new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion,
				unInicioDelEvento, unFinDelEvento)
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

}

class Amateur implements TipoDeUsuario {

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, int cantidadMaxima,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {

		new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion,
			unInicioDelEvento, unFinDelEvento)

	}

	override organizarEventoAbierto(Usuario unUsuario, String unNombre, Locacion unaLocacion, Usuario unOrganizador,
		int unValorDeLaEntrada, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {
		
	}

	override cancelarEvento() {
		//throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override postergarEvento() {
		//throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

/*Pueden organizar hasta 5 eventos
 *  eventos en simultáneo, sin límite 
 * mensual. Pueden entregar un máximo
 *  de 50 invitaciones por evento, pero
 *  las invitaciones no tienen máximo
 *  de acompañantes, por lo que 
 * la cantidad total de invitados
 *  no tiene límite.
 */
}

class Profesional implements TipoDeUsuario {

	override organizarEventoCerrado(Usuario unUsuario, String unNombre, Locacion unaLocacion, int cantidadMaxima,
		Usuario unOrganizador, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {

		new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion,
			unInicioDelEvento, unFinDelEvento)

	}

	override organizarEventoAbierto(Usuario unUsuario, String unNombre, Locacion unaLocacion, Usuario unOrganizador,
		int unValorDeLaEntrada, LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento,
		LocalDateTime unFinDelEvento) {
	}

	override cancelarEvento() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override postergarEvento() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

/*Pueden organizar hasta 20
 *  eventos al mes. No 
 * tienen límite de organizaciones
 *  simultáneas ni de invitados. 
 */
}
