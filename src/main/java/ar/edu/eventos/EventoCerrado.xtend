package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.util.Set
import java.util.HashSet
import ar.edu.eventos.exceptions.BusinessException
import org.junit.experimental.theories.suppliers.TestedOn

@Accessors
class EventoCerrado extends Evento {

	int cantidadMaxima
	Set<Invitacion> invitaciones = new HashSet()
	
		new(String unNombre, Locacion unaLocacion, int unaCantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		super(unNombre, unaLocacion, unOrganizador, unInicioDelEvento, unFinDelEvento)
		fechaMaximaDeConfirmacion = unaFechaMaximaDeConfirmacion
	cantidadMaxima = unaCantidadMaxima
	}

	def boolean esExitoso() {
		cantidadMaxima * 0.8 < this.cuantosAvamos && estadoDelEvento

	}

	def boolean esUnFracaso() {
		cantidadMaxima * 0.5 > this.cuantosAvamos

	}

	def invitarAUnUsuario(Usuario unUsuario, int unaCantidadDeAcompañantes) {
		if (cantidadMaxima > (unaCantidadDeAcompañantes + 1)){// && cuantosAvamos < unUsuario.tipoDeUsuario.maximoDePersonasPorEvento && invitaciones.size > unUsuario.tipoDeUsuario.maximoDeInvitacionesPorEvento){
				invitaciones.add(new Invitacion(unUsuario, unaCantidadDeAcompañantes, this))
				
			}
		
	}

	def pedirConfirmacionDeLasEntradas() {
		invitaciones.forEach[invitacion|invitacion.queresVenir()]
	}

	def int cuantosAvamos() {
		var int sumaTotal
		var int i
		for (i=0;i<invitaciones.size;i++){
			sumaTotal= sumaTotal + invitaciones.get(i).cantidadConfirmada
		}
		sumaTotal
	}

	def cancelarEvento() {
		estadoDelEvento = false // que pasa cuando se cancela un evento
	}

	/*Las invitaciones pendientes de confirmación suman el total de sus invitados. */
	def cantidadDeInvitacionesPendientes() {
		invitaciones.fold(1.0, [acum, invitacion|acum + invitacion.cantidadDeAcompañantes])
	}

	/*Las invitaciones aceptadas suman uno + la cantidad de acompañantes confirmados. */
	def cantidadDeInvitacionesAceptadas() {
		1 /*+ cantidadDeAcompañantesConfirmados()*/
	}

	def cantidadDeInvitacionesRechazadas() {
		invitaciones.filter[invitacion|invitacion.estado == false]
	}

	/* La cantidad de posibles asistentes se calcula de la siguiente manera: 

	 * Las invitaciones pendientes de confirmación suman el total de sus invitados.
	 * Las invitaciones aceptadas suman uno + la cantidad de acompañantes confirmados.
	 *  Las invitaciones rechazadas no suman. 
	 */
	def cantidadPosiblesDeAsistentes() {
		cantidadDeInvitacionesPendientes() + cantidadDeInvitacionesAceptadas()
	}

}
