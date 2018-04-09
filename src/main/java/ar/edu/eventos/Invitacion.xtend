package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Invitacion {

	Usuario usuario
	EventoCerrado eventoCerrado
	boolean estado = false
	int cantidadDeAcompañantes

	new(Usuario unUsuario, int unaCantidadDeAcompañantes, EventoCerrado unEventoCerrado) {
		usuario = unUsuario
		cantidadDeAcompañantes = unaCantidadDeAcompañantes
		eventoCerrado = unEventoCerrado
	}

	def queresVenir() {
		if (usuario.queresVenir(this) == true) {
			estado = true

		}
	}

/*Los invitados podrán aceptar o rechazar la invitación. En caso de aceptarla
 *  deberán indicar cuantos acompañantes efectivamente asistirán, 
 *  no pudiendo superar la cantidad definida en la invitación. 
 *  El sistema no debe permitir aceptar invitaciones una vez pasada la fecha máxima de confirmación. 

 *    Al momento de realizar una invitación se debe tener en cuenta que la cantidad de posibles asistentes
 *  no supere la capacidad máxima del evento. En caso contrario no se debe permitir efectuar la invitación.
 *   La cantidad de posibles asistentes se calcula de la siguiente manera: 

 *   Las invitaciones pendientes de confirmación suman el total de sus invitados.
 *   Las invitaciones aceptadas suman uno + la cantidad de acompañantes confirmados.
 *   Las invitaciones rechazadas no suman.  

 *   Cuando un usuario es invitado a un evento debe recibir una notificación. 
 */
}
