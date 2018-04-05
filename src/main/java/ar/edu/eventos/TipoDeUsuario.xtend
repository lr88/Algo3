package ar.edu.eventos

import java.util.List
import java.time.LocalDateTime

interface TipoDeUsuario {
	List<Evento> eventos = newArrayList
	LocalDateTime fechaActual = LocalDateTime.now

	def abstract void organizarEventoCerrado(String unNombre, Locacion unaLocacion, int cantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion)

	def void organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unOrganizador,
		int unValorDeLaEntrada, LocalDateTime unaFechaMaximaDeConfirmacion)

}

class Free implements TipoDeUsuario {

	int maximoDePersonasPorEvento = 50

	override organizarEventoCerrado(String unNombre, Locacion unaLocacion, int cantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion) {
		
	if(cantidadMaxima>maximoDePersonasPorEvento /*&& lo de los meses*/){	
		
		/*Free: Solo pueden organizar 
 * un evento a la vez, con un 
 * máximo de 3 eventos mensuales.
 * 
 *  No puede cancelar 
 * ni postergar eventos.
 */
		new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion)
	}}

	override organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unOrganizador,
		int unValorDeLaEntrada, LocalDateTime unaFechaMaximaDeConfirmacion) {
	
		print("NO PODES ORGANIZAR EVENTOS ABIERTOS")
	}


}

class Amateur implements TipoDeUsuario {

	override organizarEventoCerrado(String unNombre, Locacion unaLocacion, int cantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion) {
	
	new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion)
		
	}

	override organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unOrganizador,
		int unValorDeLaEntrada, LocalDateTime unaFechaMaximaDeConfirmacion) {
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

	override organizarEventoCerrado(String unNombre, Locacion unaLocacion, int cantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion) {
	
	new EventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador, unaFechaMaximaDeConfirmacion)
	
	}

	override organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unOrganizador,
		int unValorDeLaEntrada, LocalDateTime unaFechaMaximaDeConfirmacion) {
	}

/*Pueden organizar hasta 20
 *  eventos al mes. No 
 * tienen límite de organizaciones
 *  simultáneas ni de invitados. 
 */
}

