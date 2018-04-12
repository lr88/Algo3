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
	List <Invitacion> aceptadas = newArrayList()
	
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

	def listaDeTodosMisEventos(){// NO TOCAR
		eventosCerrados+eventosAbiertos
	}

	def puedoOrganizarUnEventoEsteMes(LocalDateTime unInicioDelEvento,int unMaximoDeEventosMensuales){// NO TOCAR
		listaDeTodosMisEventos.filter[evento|evento.inicioDelEvento.getMonth == unInicioDelEvento.getMonth && evento.inicioDelEvento.getYear == unInicioDelEvento.getYear].size < unMaximoDeEventosMensuales
	}

	def EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(LocalDateTime unInicioDelEvento,int unaCantidadMaximaPermitidaDeSimultaneidadDeEventos) {// NO TOCAR
		listaDeTodosMisEventos.filter[evento | evento.terminoElEvento == false].size < unaCantidadMaximaPermitidaDeSimultaneidadDeEventos
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
    
	def invitarAUnUsuario(Usuario unUsuario, int unaCantidadMaximaDeAcompañantes,EventoCerrado unEvento) {// NO TOCAR 
		if (unEvento.cantidaDePosiblesAsistentes < unEvento.cantidadMaximaDelEvento){
			unEvento.invitaciones.add(new Invitacion (unUsuario, unaCantidadMaximaDeAcompañantes,unEvento))
				unUsuario.mensajes.add("Fuiste Invitado al Evento "+ nombre)
		}
		else{
		throw new BusinessException("No se puede crear invitacion, supera la cantidad maxima del evento")
			}
	}
	

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
	
	
	
	def listaDeInvitacionesPendientes(){
		miListaDeInvitaciones.filter[invitacion| invitacion.estadoPendiente == true]
	}
	def aceptacionMasiva(){
		(listaDeInvitacionesPendientes.filter[invitacion | esElOrganizadorMiAmigo(invitacion) == true]
		+ listaDeInvitacionesPendientes.filter[invitacion | asistenMasDeTantosAmigos(invitacion, 4) == true]
		+listaDeInvitacionesPendientes.filter[invitacion | meQuedaSerca( invitacion) == true])
		.forEach[inv | this.aceptarInvitacion(inv,inv.cantidadDeAcompañantes,inv.evento)]
		}
	
	def boolean esElOrganizadorMiAmigo(Invitacion unaInvitacion){
		amigos.contains(unaInvitacion.evento.organizador)
	}
	
	def  asistenMasDeTantosAmigos(Invitacion unaInvitacion,int cantidad){
		this.miListaDeInvitaciones.filter[invi|invi.evento.nombre == (unaInvitacion.usuario.miListaDeInvitaciones.map[invita|invita.evento.nombre])].size()>cantidad
	}
	
	def boolean meQuedaSerca(Invitacion invitacion) {
		invitacion.evento.locacion.distancia(direccion) < radioDeCercanía 
	}
	def rechazoMasivo(){
	if(esAntisocial){
		(miListaDeInvitaciones.filter[invitacion | esElOrganizadorMiAmigo(invitacion) == true &&
			asistenMasDeTantosAmigos(invitacion, 1)]
			+ miListaDeInvitaciones.filter[invitacion | !asistenMasDeTantosAmigos(invitacion, 2) == true]
			+ miListaDeInvitaciones.filter[invitacion | meQuedaSerca( invitacion) == false])
			.forEach[inv | this.rechazarInvitacion(inv,inv.cantidadDeAcompañantes,inv.evento)]
			}
	else{
		miListaDeInvitaciones.filter[invitacion | asistenMasDeTantosAmigos(invitacion, 0) == true && meQuedaSerca(invitacion) == false]
			.forEach[inv | this.rechazarInvitacion(inv,inv.cantidadDeAcompañantes,inv.evento)]
		}
	}

	def listaDeTodosMisInvitacionesRechazadas(){// NO TOCAR
		miListaDeInvitaciones.filter[ invitacion | invitacion.estadoRechazado == true]
	}
	def listaDeTodosMisInvitacionesAceptadas(){// NO TOCAR
		miListaDeInvitaciones.filter[ invitacion | invitacion.estadoAceptado == true]
	}
	def listaDeTodosMisInvitacionesPendientes(){// NO TOCAR
		miListaDeInvitaciones.filter[ invitacion | invitacion.estadoPendiente == true]
	}
		
	def indicarNuevaFechaDeEvento(Evento unEvento,LocalDateTime nuevaFecha){
		unEvento.cambiarFecha(nuevaFecha)
	}
}

