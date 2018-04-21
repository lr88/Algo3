package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import java.time.Duration
import java.time.LocalDateTime
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Usuario {
	List <String> mensajes = newArrayList()
	Set<Evento> eventos = new HashSet ()
	Set<Usuario> amigos = new HashSet()	
	Set <Invitacion> invitaciones = new HashSet ()
	Set<Entrada> entradas = new HashSet()	

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
	

	def comprarEntradaDeEventoAbierto(EventoAbierto unEvento,Entrada unaEntrada) {
		unEvento.adquirirEntrada(this,unaEntrada)
	}

	def agregarEntrada(Entrada entrada) {
		entradas.add(entrada)
	}
	
	def cambiarTipoDeUsuario(TipoDeUsuario unTipoDeUsuario){
		tipoDeUsuario = unTipoDeUsuario
	}
	
	def void agregarAmigo(Usuario unAmigo) {
		amigos.add(unAmigo)
	}
	
	def eliminarAmigos(Usuario unUsuario) {
		amigos.remove(unUsuario)
	}

	def edad(LocalDateTime fechaActual) {
		Duration.between(fechaDeNacimiento, fechaActual).toDays() / 360
	}

	def puedoOrganizarUnEventoEsteMes(LocalDateTime unInicioDelEvento,int unMaximoDeEventosMensuales){
		eventos.filter[evento|evento.fechaDeInicioDelEvento.getMonth == unInicioDelEvento.getMonth && evento.fechaDeInicioDelEvento.getYear == unInicioDelEvento.getYear].size < unMaximoDeEventosMensuales
	}

	def EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(LocalDateTime unInicioDelEvento,int unaCantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		eventos.filter[evento | evento.terminoElEvento == false].size < unaCantidadMaximaPermitidaDeSimultaneidadDeEventos
	}

	def crearEventoCerrado(EventoCerrado unEvento) {
		tipoDeUsuario.organizarEventoCerrado(unEvento)
	}

	def CrearEventoAbierto(EventoAbierto unEvento) {
		tipoDeUsuario.organizarEventoAbierto(unEvento)
	}
	
	def devolverEntrada(Entrada unaEntrada,EventoAbierto unEvento){
		if(unEvento.sePuedeDevolverLaEntrada){
			unaEntrada.devolverDinero()
			unEvento.usuarioDevuelveEntrada(unaEntrada)
			entradas.remove(unaEntrada)
		}
	}
    
	def invitarAUnUsuario(Usuario unUsuario, int unaCantidadMaximaDeAcompañantes,EventoCerrado unEvento) { 
		if(unEvento.organizador == this){
			unEvento.invitarAUnUsiario(unUsuario,unaCantidadMaximaDeAcompañantes)
			}
			else{
			//throw new BusinessException("No se puede crear invitacion, no el organizador del evento")
		}
	}
	

  	 def aceptarInvitacion(Invitacion unaInvitacion,int unaCantidadDeAcompañantes){
		if(unaCantidadDeAcompañantes < unaInvitacion.cantidadMaximaDeAcompañantes && LocalDateTime.now < unaInvitacion.evento.fechaMaximaDeConfirmacion){
				unaInvitacion.estadoAceptado = true
				unaInvitacion.cantidadDeAcompañantes = unaCantidadDeAcompañantes
		}
		else{
			//throw new BusinessException("No se puede aceptar la invitacion, verifique de no superar la fecha maxima de confirmacion o la cantidad de acompañantes")
		}
		
	}
	
	def rechazarInvitacion(Invitacion unaInvitacion){
				unaInvitacion.estadoRechazado = true
		}
	
	def void cancelarEvento(Evento unEvento){
		tipoDeUsuario.cancelarElEvento(this, unEvento)
	}
	
	def void postergarEvento(Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento){
		tipoDeUsuario.postergarElEvento(this,unEvento,NuevaFechaDeInicioDelEvento)
	}
	
	def aceptacionMasiva(){
		listaDeTodosMisInvitacionesPendientes.forEach[inv | if(esElOrganizadorMiAmigo(inv)  || asistenMasDeTantosAmigos(inv,4)  /*||!meQuedaSerca(inv)*/)
				aceptarInvitacion(inv,inv.cantidadDeAcompañantes)]
	
	}
	
	def boolean esElOrganizadorMiAmigo(Invitacion unaInvitacion){
		amigos.contains(unaInvitacion.evento.organizador)
	}
	
	def asistenMasDeTantosAmigos(Invitacion unaInvitacion,int cantidad){
		this.invitaciones.filter[invi|invi.evento.nombre == (unaInvitacion.usuario.invitaciones.map[invita|invita.evento.nombre])].size()>cantidad
	}
	
	def meQuedaSerca(Invitacion invitacion) {
		invitacion.evento.locacion.distancia(direccion) < radioDeCercanía 
	}
	
	def rechazoMasivo(){
		if(esAntisocial){
		listaDeTodosMisInvitacionesPendientes.forEach[inv | if((esElOrganizadorMiAmigo(inv) && asistenMasDeTantosAmigos(inv,1)) || !asistenMasDeTantosAmigos(inv,2)  /*||!meQuedaSerca(inv)*/)
				aceptarInvitacion(inv,inv.cantidadDeAcompañantes)]
	}
	else{
		invitaciones.filter[invitacion | asistenMasDeTantosAmigos(invitacion, 0) == true/* && meQuedaSerca(invitacion) == false */]
			.forEach[invitacion | this.rechazarInvitacion(invitacion)]
		}
	}

	def listaDeTodosMisInvitacionesRechazadas(){
		invitaciones.filter[ invitacion | invitacion.estadoRechazado == true]
	}
	def listaDeTodosMisInvitacionesAceptadas(){
		invitaciones.filter[ invitacion | invitacion.estadoAceptado == true]
	}
	def listaDeTodosMisInvitacionesPendientes(){
		invitaciones.filter[ invitacion | invitacion.estadoPendiente == true]
	}
	
	def eliminarInvitacion(Invitacion invitacion) {
		invitaciones.remove(invitacion)
	}
	
	def recibirMensaje(String string) {
		mensajes.add(string)
	}
			
}

