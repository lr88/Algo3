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
	LocalDateTime fechaActual = LocalDateTime.now
	
	List <String> mensajes = newArrayList()
	Set<EventoAbierto> eventosAbiertos = new HashSet ()
	Set<EventoCerrado> eventosCerrados = new HashSet ()
	Set<Usuario> amigos = new HashSet()	
	Set <Invitacion> miListaDeInvitaciones = new HashSet ()
	Set<Entrada> ListaDeEntradas = new HashSet()	

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
		print("felicitaciones te Registraste Correctamente  "+nombreDeUsuario+"\n")
	}
//	SOLO PARA EL TEST ------------
	def aceptarTodasLasInvitaciones(int cantidadDeacompañantes){
		listaDeTodosMisInvitacionesPendientes.forEach[invitacion |aceptarInvitacion(invitacion,cantidadDeacompañantes)]
	}
	def rechazarTodasLasInvitaciones(){
		listaDeTodosMisInvitacionesPendientes.forEach[invitacion |rechazarInvitacion(invitacion)]
	}
// -------------------------------
	def comprarEntradaDeEventoAbierto(EventoAbierto unEvento) {
		unEvento.adquirirEntrada(this)
	}

	def entregarEntradaAlusuario(Entrada entrada) {
		ListaDeEntradas.add(entrada)
	}
	
	def cambiarTipoDeUsuario(TipoDeUsuario unTipoDeUsuario){
		tipoDeUsuario = unTipoDeUsuario
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

	def boolean soyMenorDeEdad(LocalDateTime fechaActual) {
		Duration.between(fechaDeNacimiento, fechaActual).toDays() / 360 < 18
	}

	def listaDeTodosMisEventos(){
		eventosCerrados+eventosAbiertos
	}

	def puedoOrganizarUnEventoEsteMes(LocalDateTime unInicioDelEvento,int unMaximoDeEventosMensuales){
		listaDeTodosMisEventos.filter[evento|evento.fechaDeInicioDelEvento.getMonth == unInicioDelEvento.getMonth && evento.fechaDeInicioDelEvento.getYear == unInicioDelEvento.getYear].size < unMaximoDeEventosMensuales
	}

	def EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(LocalDateTime unInicioDelEvento,int unaCantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		listaDeTodosMisEventos.filter[evento | evento.terminoElEvento == false].size < unaCantidadMaximaPermitidaDeSimultaneidadDeEventos
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
		if(fechaActual.dayOfYear < unEvento.fechaDeInicioDelEvento.dayOfYear){
			unaEntrada.devolverDinero(fechaActual,unEvento)
			unEvento.usuarioDevuelveEntrada(unaEntrada)
		}
	}
    
	def invitarAUnUsuario(Usuario unUsuario, int unaCantidadMaximaDeAcompañantes,EventoCerrado unEvento) { 
		if(unEvento.organizador == this){
			if (unEvento.cantidaDePosiblesAsistentes < unEvento.cantidadMaximaDeInvitados){
			unEvento.invitaciones.add(new Invitacion (unUsuario, unaCantidadMaximaDeAcompañantes,unEvento))
				unUsuario.mensajes.add("Fuiste Invitado al Evento "+ nombre)
				print("Fuiste Invitado al Evento "+ unUsuario.nombre+"\n")
			}
			else{
				print("No se puede crear invitacion, supera la cantidad maxima del evento\n")
				//throw new BusinessException("No se puede crear invitacion, supera la cantidad maxima del evento")
				
			}
		}
		else{
			print("No se puede crear invitacion, no el organizador del evento\n")
		//throw new BusinessException("No se puede crear invitacion, no el organizador del evento")
		}
	}
	

  	 def aceptarInvitacion(Invitacion unaInvitacion,int unaCantidadDeAcompañantes){
		if(unaCantidadDeAcompañantes < unaInvitacion.cantidadMaximaDeAcompañantes && fechaActual < unaInvitacion.evento.fechaMaximaDeConfirmacion){
				unaInvitacion.estadoPendiente = false
				unaInvitacion.estadoAceptado = true
				unaInvitacion.cantidadDeAcompañantes = unaCantidadDeAcompañantes
		}
		else{
			print("No se puede aceptar la invitacion, verifique de no superar la fecha maxima de confirmacion o la cantidad de acompañantes\n")
			mensajes.add("No se puede aceptar la invitacion, verifique de no superar la fecha maxima de confirmacion o la cantidad de acompañantes")
			//throw new BusinessException("No se puede aceptar la invitacion, verifique de no superar la fecha maxima de confirmacion o la cantidad de acompañantes")
		}
		
	}
	
	def rechazarInvitacion(Invitacion unaInvitacion){
				unaInvitacion.estadoPendiente = false
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
		this.miListaDeInvitaciones.filter[invi|invi.evento.nombre == (unaInvitacion.usuario.miListaDeInvitaciones.map[invita|invita.evento.nombre])].size()>cantidad
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
		miListaDeInvitaciones.filter[invitacion | asistenMasDeTantosAmigos(invitacion, 0) == true/* && meQuedaSerca(invitacion) == false */]
			.forEach[invitacion | this.rechazarInvitacion(invitacion)]
		}
	}

	def listaDeTodosMisInvitacionesRechazadas(){
		miListaDeInvitaciones.filter[ invitacion | invitacion.estadoRechazado == true]
	}
	def listaDeTodosMisInvitacionesAceptadas(){
		miListaDeInvitaciones.filter[ invitacion | invitacion.estadoAceptado == true]
	}
	def listaDeTodosMisInvitacionesPendientes(){
		miListaDeInvitaciones.filter[ invitacion | invitacion.estadoPendiente == true]
	}
		
	def indicarNuevaFechaDeEvento(Evento unEvento,LocalDateTime nuevaFecha){
		unEvento.cambiarFecha(nuevaFecha)
	}
	
	
	
}

