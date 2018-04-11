package ar.edu.eventos

import java.time.Duration

import java.time.LocalDateTime
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import java.util.HashSet
import java.util.Set
import ar.edu.eventos.exceptions.BusinessException

@Accessors
class Usuario {
	LocalDateTime fechaActual = LocalDateTime.now
	
	List <String> mensajes = newArrayList()
	Set<EventoAbierto> eventosAbiertos = new HashSet ()
	Set<EventoCerrado> eventosCerrados = new HashSet ()
	Set<Usuario> amigos = new HashSet()	
	Set <Invitacion> miListaDeInvitaciones = new HashSet ()
	
	
	String nombreDeUsuario
	String nombre
	String apellido
	String email
	Point direccion
	LocalDateTime fechaDeNacimiento
	boolean esAntisocial
	
	var double plataQueTengo = 100
	var double radioDeCercanía
	TipoDeUsuario tipoDeUsuario
	int cantidadDeAcompañantes
	

	new(String unNombreDeUsuario, String unNombre, String unApellido, String unEmail, Point unLugar,
		boolean es_Antisocial, LocalDateTime unaFecha, double unRadioDeCercanía,TipoDeUsuario unTipoDeUsuario) {
		nombreDeUsuario = unNombreDeUsuario
		nombre = unNombre
		apellido = unApellido
		email = unEmail
		direccion = unLugar
		esAntisocial = es_Antisocial
		fechaDeNacimiento = unaFecha
		radioDeCercanía = unRadioDeCercanía
		tipoDeUsuario = unTipoDeUsuario
	}

	def cambiarTipoDeUsuario(TipoDeUsuario unTipoDeUsuario){// NO TOCAR
		tipoDeUsuario = unTipoDeUsuario
	}
	
	def void agregarAmigo(Usuario unAmigo) {// NO TOCAR
		amigos.add(unAmigo)
	}
	def int cantidadDeAmigos() {// NO TOCAR
		amigos.size
	}
	def eliminarAmigos(Usuario unUsuario) {// NO TOCAR
		amigos.remove(unUsuario)
	}
	def comprarEntradaDeEventoAbierto(EventoAbierto unEvento) {// NO TOCAR
		unEvento.adquirirEntrada(this)
	}

	def boolean soyMenorDeEdad(LocalDateTime fechaActual) {// NO TOCAR
		Duration.between(fechaDeNacimiento, fechaActual).toDays() / 360 < 18
	}

	def todosMisEventos(){// NO TOCAR
		eventosCerrados+eventosAbiertos
	}


	def puedoOrganizarUnEventoEsteMes(LocalDateTime unInicioDelEvento,int unMaximoDeEventosMensuales){// NO TOCAR
		todosMisEventos.filter[evento|evento.inicioDelEvento.getMonth == unInicioDelEvento.getMonth && evento.inicioDelEvento.getYear == unInicioDelEvento.getYear].size < unMaximoDeEventosMensuales
	}

	def EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(LocalDateTime unInicioDelEvento,int unaCantidadMaximaPermitidaDeSimultaneidadDeEventos) {// NO TOCAR
		todosMisEventos.filter[evento | evento.terminoElEvento == false].size < unaCantidadMaximaPermitidaDeSimultaneidadDeEventos
	}

	def crearEventoCerrado(String unNombre, Locacion unaLocacion, int cantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion,LocalDateTime unInicioDelEvento,LocalDateTime unFinDelEvento) {// NO TOCAR
		tipoDeUsuario.organizarEventoCerrado(this,unNombre, unaLocacion, cantidadMaxima, this,
			unaFechaMaximaDeConfirmacion, unInicioDelEvento, unFinDelEvento)
	}

	def CrearEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion,LocalDateTime unInicioDelEvento,LocalDateTime unFinDelEvento) {// NO TOCAR
		tipoDeUsuario.organizarEventoAbierto( unNombre,unaLocacion, this,unValorDeLaEntrada,
		unaFechaMaximaDeConfirmacion, unInicioDelEvento, unFinDelEvento)
	}
	
	def devolverEntrada(Entrada unaEntrada,EventoAbierto unEvento){
		if(fechaActual < unEvento.inicioDelEvento){
			unaEntrada.devolverDinero(fechaActual,unEvento)
			unEvento.usuarioDevuelveEntrada(unaEntrada)
		}
	}
    
    /*El organizador de un evento es quién tiene la facultad de invitar a otros usuarios. 
     Al realizar una invitación deberá indicar quién es el invitado y la cantidad de acompañantes. */
     /*Al momento de realizar una invitación se debe tener en cuenta que la cantidad 
     de posibles asistentes no supere la capacidad máxima del evento
      */
	def invitarAUnUsuario(Usuario unUsuario, int unaCantidadMaximaDeAcompañantes,EventoCerrado unEvento) {// NO TOCAR 

		/* Cuando un usuario es invitado a un evento debe recibir una notificación.  */
		
		if (unEvento.cantidaDePosiblesAsistentes < unEvento.cantidadMaximaDelEvento){
			unEvento.invitaciones.add(new Invitacion (unUsuario, unaCantidadMaximaDeAcompañantes,unEvento))
				unUsuario.mensajes.add("Fuiste Invitado al Evento "+ nombre)
		}
		else{
		throw new BusinessException("No se puede crear invitacion, supera la cantidad maxima del evento")
			}
	}
	
	/*Los invitados podrán aceptar o rechazar la invitación. 
	 En caso de aceptarla deberán indicar cuantos acompañantes efectivamente asistirán,
	 no pudiendo superar la cantidad definida en la invitación. 
   El sistema no debe permitir aceptar invitaciones una vez pasada la fecha máxima de confirmación.  */
   def aceptarInvitacion(Invitacion unaInvitacion,int unaCantidadDeAcompañantes,EventoCerrado unEvento){// NO TOCAR
		if(unaCantidadDeAcompañantes < unaInvitacion.cantidadMaximaDeAcompañantes && fechaActual<unEvento.fechaMaximaDeConfirmacion){
				unaInvitacion.estadoPendiente = false
				unaInvitacion.estadoAceptado = true
			unaInvitacion.cantidadDeAcompañantes = unaCantidadDeAcompañantes
			}
		else{
				rechazarInvitacion( unaInvitacion, unaCantidadDeAcompañantes, unEvento)
			}
	}
	def rechazarInvitacion(Invitacion unaInvitacion,int unaCantidad,EventoCerrado unEvento){
				unaInvitacion.estadoPendiente = false
				unaInvitacion.estadoRechazado = true
			
		}
	
	def void cancelarEvento(Evento unEvento){
		tipoDeUsuario.cancelarElEvento(this, unEvento)
	}
	
	def void postergarEvento(Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento){
		tipoDeUsuario.postergarElEvento(this,unEvento,NuevaFechaDeInicioDelEvento)
	}
	/*Aceptación masiva

Los usuarios podrán correr un proceso mediante el cual se aceptarán todas sus invitaciones pendientes cuyos 
* eventos cumplan con alguna de las siguientes condiciones:

●	El organizador es su amigo.
●	Asisten más de cuatro amigos.
●	Se encuentra dentro de su radio de cercanía.

Las invitaciones aceptadas por este proceso se confirmarán con la cantidad de acompañantes que figuren en la invitación. 
	 */
	def aceptacionMasiva(){
		(listaDeInvitacionesPendientes.filter[invitacion | esElOrganizadorMiAmigo(invitacion) == true] 
		+ listaDeInvitacionesPendientes.filter[invitacion | asistenMasDeTantosAmigos(invitacion, 2) == true]
		+listaDeInvitacionesPendientes.filter[invitacion | meQuedaSerca( invitacion) == true])
		.forEach[inv | this.aceptarInvitacion(inv,inv.cantidadDeAcompañantes,inv.evento)]
	}
	
	def listaDeInvitacionesPendientes(){
		miListaDeInvitaciones.filter[invitacion| invitacion.estadoPendiente == true]
	}
	
	
	def boolean esElOrganizadorMiAmigo(Invitacion unaInvitacion){
		amigos.contains(unaInvitacion.evento.organizador)
	}
	
	def boolean asistenMasDeTantosAmigos(Invitacion unaInvitacion,int cantidad){
		/*NO ME SALE EL FILTRO */	
		true
	}
	
	def boolean meQuedaSerca(Invitacion invitacion) {
		invitacion.evento.locacion.distancia(direccion) < radioDeCercanía 
	}
	/*Rechazo masivo

De forma similar a la aceptación masiva, este proceso 
* rechazará invitaciones con los siguientes criterios: 

●	Si el usuario es antisocial: Rechazará todas las
*  invitaciones a eventos que se encuentran fuera de 
* su radio de cercanía. También las de aquellos eventos
*  a los que no asistan al menos dos de sus amigos (incluyendo organizador).

●	Si no es antisocial: Si el evento está fuera de
*  su radio de cercanía y no asiste ningún amigo. 
	 */
	def rechazoMasivo(){// hay que analizarlo bien ********************************************
		if(esAntisocial){
		(listaDeInvitacionesPendientes.filter[invitacion | esElOrganizadorMiAmigo(invitacion) == true] 
		+ listaDeInvitacionesPendientes.filter[invitacion | asistenMasDeTantosAmigos(invitacion, 2) == true]
		+ listaDeInvitacionesPendientes.filter[invitacion | meQuedaSerca( invitacion) == false])
		.forEach[inv | this.rechazarInvitacion(inv,inv.cantidadDeAcompañantes,inv.evento)]
		}
	}
	
	def indicarNuevaFechaDeEvento(Evento unEvento,LocalDateTime nuevaFecha){
		unEvento.cambiarFecha(nuevaFecha)
			
	}
	

}

