package ar.edu.eventos

import java.time.Duration
import java.time.LocalDateTime
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import java.util.HashSet
import java.util.Set


@Accessors
class Usuario {
	
	Set <Invitacion> invitacionesPendientes = new HashSet()
	Set <Invitacion> invitacionesRechazadas = new HashSet()
	Set <Invitacion> invitacionesAceptadas = new HashSet()
	
	
	List <String> mensajes = newArrayList()
	Set<EventoAbierto> eventosAbiertos = new HashSet ()
	Set<EventoCerrado> eventosCerrados = new HashSet ()
	Set<Evento> eventos = new HashSet ()
	LocalDateTime fechaActual = LocalDateTime.now
	String nombreDeUsuario
	String nombre
	String apellido
	String email
	Point direccion
	LocalDateTime fechaDeNacimiento
	boolean esAntisocial
	Set<Usuario> amigos = new HashSet()
	var double plataQueTengo = 100
	var double radioDeCercanía
	TipoDeUsuario tipoDeUsuario
	Boolean aceptacion
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

	/* SOLO PARA SATISFACER EL TEST */
	def void agregarEvento(Evento unEvento) {
		eventos.add(unEvento)
	}
	/*------------------- */
	
	def cambiarTipoDeUsuario(TipoDeUsuario unTipoDeUsuario){
		tipoDeUsuario = unTipoDeUsuario
	}
	
	def recibirMensaje(String unMensaje){
		mensajes.add(unMensaje)
	}
	def void agregarAmigo(Usuario unAmigo) {
		amigos.add(unAmigo)
	}

	def int cantidadDeAmigos() {
		amigos.size
	}

	def eliminarAmigos(Usuario unUsuario) {
		amigos.remove(unUsuario)
	}

	def comprarEntradaDeEventoAbierto(EventoAbierto unEvento) {
		unEvento.adquirirEntrada(this)
	}

	def boolean soyMenorDeEdad(LocalDateTime fechaActual) {
		Duration.between(fechaDeNacimiento, fechaActual).toDays() / 360 < 18
	}

	def boolean queresVenir(Invitacion unaInvitacion) {
		if(Duration.between(fechaActual, unaInvitacion.eventoCerrado.fechaMaximaDeConfirmacion).toMillis > 0.0){
				this.responderInvitacion(true,unaInvitacion)
		}
	}

	def int cuantosSomos(Invitacion unaInvitacion) {
		amigos.filter[amigo|amigo.invitacionesAceptadas.contains(unaInvitacion)].size
	}

	def puedoOrganizarUnEventoEsteMes(LocalDateTime unInicioDelEvento,int unMaximoDeEventosMensuales){
		eventos.filter[evento|evento.inicioDelEvento.getMonth == unInicioDelEvento.getMonth && evento.inicioDelEvento.getYear == unInicioDelEvento.getYear].size < unMaximoDeEventosMensuales
	}

	def EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(LocalDateTime unInicioDelEvento,int unaCantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		eventos.filter[evento | evento.estadoDelEvento].size < unaCantidadMaximaPermitidaDeSimultaneidadDeEventos
	}

	def crearEventoCerrado(String unNombre, Locacion unaLocacion, int cantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion,LocalDateTime unInicioDelEvento,LocalDateTime unFinDelEvento) {
		
		tipoDeUsuario.organizarEventoCerrado(this,unNombre, unaLocacion, cantidadMaxima, this,
			unaFechaMaximaDeConfirmacion, unInicioDelEvento, unFinDelEvento)
	}


	def CrearEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion,LocalDateTime unInicioDelEvento,LocalDateTime unFinDelEvento) {
		tipoDeUsuario.organizarEventoAbierto( unNombre,unaLocacion, this,unValorDeLaEntrada,
		unaFechaMaximaDeConfirmacion, unInicioDelEvento, unFinDelEvento)
	}
	
	def devolverEntrada(Entrada unaEntrada,EventoAbierto unEvento){
		if(fechaActual < unEvento.inicioDelEvento){
			unaEntrada.devolverDinero(fechaActual,unEvento)
		unEvento.usuarioDevuelveEntrada(this)
		}
	}
	
	def invitar(EventoCerrado unEventoCerrado,int unaCantidadDeAcompañantes, Usuario unUsuario){
		new Invitacion (unUsuario, unaCantidadDeAcompañantes, unEventoCerrado)

	}
	
	def responderInvitacion(Boolean respuesta,Invitacion unaInvitacion){
			unaInvitacion.estado = respuesta
			if(respuesta){
				unaInvitacion.usuarioEnEstadoPendientes.remove(this)
				unaInvitacion.usuarioEnEstadoConfirmado.add(this)
				invitacionesPendientes.remove(unaInvitacion)
				invitacionesAceptadas.add(unaInvitacion)
				
			}
			else{
				unaInvitacion.usuarioEnEstadoPendientes.remove(this)
				unaInvitacion.usuarioEnEstadoRechazados.add(this)
				invitacionesPendientes.remove(unaInvitacion)
				invitacionesRechazadas.add(unaInvitacion)
			}
			
	}
	
	def cancelarEvento(Usuario unUsuario, Evento unEvento) {
		tipoDeUsuario.cancelarEvento( unUsuario, unEvento)
	}

	def postergarEvento(Usuario unUsuario, Evento unEvento) {
		tipoDeUsuario.postergarEvento(unUsuario, unEvento)
	}
	
}

