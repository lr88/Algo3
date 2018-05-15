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
class Usuario implements Entidad {
	
	var int id
	List <String> mensajes = newArrayList()
	Set<EventoCerrado> eventosCerrados = new HashSet ()
	Set<EventoAbierto> eventosAbiertos = new HashSet ()
	Set<Usuario> amigos = new HashSet()	
	Set <Invitacion> invitaciones = new HashSet ()
	Set<Entrada> entradas = new HashSet()	
	String nombreDeUsuario
	String nombre
	String apellido
	String email
	Point direccion
	var Direccion descripcionDeLaDireccion
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
		entrada.usuario = this
		entradas.add(entrada)
	}
	
	def cambiarTipoDeUsuario(TipoDeUsuario unTipoDeUsuario){
		tipoDeUsuario = unTipoDeUsuario
	}
	
	def void agregarAmigo(Usuario unAmigo) {
		amigos.add(unAmigo)
	}
	
	def eventos(){
		eventosAbiertos + eventosCerrados
	}
	
	def eliminarAmigos(Usuario unUsuario) {
		amigos.remove(unUsuario)
	}

	def edad() {
		Duration.between(fechaDeNacimiento, LocalDateTime.now).toDays/360
	}

	def cantidadDeEventosEnEsteMes(Evento unEvento){
		eventos.filter[evento|evento.fechaDeInicioDelEvento.getMonth == unEvento.fechaDeInicioDelEvento.getMonth && evento.fechaDeInicioDelEvento.getYear == unEvento.fechaDeInicioDelEvento.getYear].size
	}
	
	def crearEventoCerrado(EventoCerrado unEvento) {
		tipoDeUsuario.puedoOrganizarelEventoCerrado(unEvento,this)
		agregarEventoCerrado(unEvento)
	}

	def crearEventoAbierto(EventoAbierto unEvento) {
		tipoDeUsuario.puedoOrganizarEventoAbierto(unEvento,this)
		agregarEventoAbierto(unEvento)
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
			throw new BusinessException("No se puede crear invitacion, no sos el organizador del evento")
		}
	}
	

  	 def aceptarInvitacion(Invitacion unaInvitacion,int unaCantidadDeAcompañantes){
		hayTiempoParaConfirmar(unaInvitacion)
		validarCantidadDeAcompañantes(unaInvitacion,unaCantidadDeAcompañantes)
		unaInvitacion.estadoAceptado = true
		unaInvitacion.cantidadDeAcompañantes = unaCantidadDeAcompañantes
		
		
	}
	def hayTiempoParaConfirmar(Invitacion unaInvitacion){
		if(LocalDateTime.now < unaInvitacion.evento.fechaMaximaDeConfirmacion){
			}
		else{
			throw new BusinessException("No se puede aceptar la invitacion, supera el tiempo de confirmacion")
		}
	}
	
	def validarCantidadDeAcompañantes(Invitacion unaInvitacion, int unaCantidadDeAcompañantes){
		if(unaCantidadDeAcompañantes < unaInvitacion.cantidadMaximaDeAcompañantes){
			}
		else{
			throw new BusinessException("No se puede aceptar la invitacion, supera la cantidad de acompañantes")
		}
	}

	def rechazarInvitacion(Invitacion unaInvitacion){
		unaInvitacion.estadoRechazado = true
		}

	def void cancelarEvento(Evento unEvento){
		tipoDeUsuario.puedoCancelarElEvento(unEvento)
		unEvento.cancelarElEvento()
		
	}
	def void postergarEvento(Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento){
		tipoDeUsuario.puedoPostergarElEvento(unEvento)
		unEvento.cambiarFecha(NuevaFechaDeInicioDelEvento)
	}
	
	def aceptacionMasiva(){
		listaDeTodosMisInvitacionesPendientes.
		forEach[inv | if(validarAceptacionMasiva(inv)){
				aceptarInvitacion(inv,inv.cantidadDeAcompañantes)}]
	}
	
	def validarAceptacionMasiva(Invitacion inv){
		esElOrganizadorMiAmigo(inv)  || asistenMasDeTantosAmigos(inv,4)  ||!meQuedaSerca(inv)
	}
	
	
	def boolean esElOrganizadorMiAmigo(Invitacion unaInvitacion){
		amigos.contains(unaInvitacion.elOrganizadorDelEvento)
	}
	
	def asistenMasDeTantosAmigos(Invitacion unaInvitacion,int cantidad){
		this.invitaciones.filter[invi|invi.evento.nombre == (unaInvitacion.usuario.invitaciones.map[invita|invita.evento.nombre])].size()>cantidad
	}
	
	
	def meQuedaSerca(Invitacion invitacion) {
		invitacion.distanciaAmiCasa(direccion) < radioDeCercanía 
	}
	
	def rechazoMasivo(){
		if(!esAntisocial){
		listaDeTodosMisInvitacionesPendientes.forEach[inv | if(validacionRechazoMasivo(inv)== true){
			aceptarInvitacion(inv,inv.cantidadDeAcompañantes)}]
		}
	else{
		invitaciones.filter[invitacion | asistenMasDeTantosAmigos(invitacion, 0) == true && !meQuedaSerca(invitacion) ]
			.forEach[invitacion | this.rechazarInvitacion(invitacion)]
		}
	}

	def validacionRechazoMasivo(Invitacion inv){
		(esElOrganizadorMiAmigo(inv) && asistenMasDeTantosAmigos(inv,1)) || !asistenMasDeTantosAmigos(inv,2) || !meQuedaSerca(inv)
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
	def cantidadDeAmigos(){
		amigos.size()
	}
	
	def eventosActivos(){
		eventos.filter[evento | evento.enProceso == true].size()
	}
	
	def agregarEventoAbierto(EventoAbierto evento) {
		evento.validar
		evento.tuOrganizadorEs(this)
		eventosAbiertos.add(evento)
	}
	
	def agregarEventoCerrado(EventoCerrado evento) {
		evento.validar()
		evento.tuOrganizadorEs(this)
		eventosCerrados.add(evento)
	}
	
	override validar() {
		this.validarNombreDeUsuario()
		this.validarNombre()
		this.validarApellido()
		this.validarEmail()
		//this.validarFechaDeNacimiento()
		this.validarDireccion()
	}
	
	//TODO: Usar este método para validar !null. Habría que sacarlo a otra clase. 
	def validarNoNulo(Object objeto, String nombrePropiedad) {
		if(objeto === null){
			throw new BusinessException("No podes crear un usuario sin " + nombrePropiedad)
		}
	}
	
	def validarEmail() {
		if(this.email === null || this.email.length==0){
			throw new BusinessException("No podes crear un usuario sin email")
		}
	}
	
	def validarDireccion() {
		validarNoNulo(direccion, "dirección")
	}
	
	def validarFechaDeNacimiento() {
		if(this.fechaDeNacimiento === null){
			throw new BusinessException("No podes crear un usuario sin Fecha de Nacimiento")
		}
	}
	
	def validarApellido() {
		if(this.apellido === null || this.apellido.length==0){
			throw new BusinessException("No podes crear un usuario sin apellido")
		}
	}
	
	def validarNombre() {
		if(this.nombre === null || this.nombre.length==0){
			throw new BusinessException("No podes crear un usuario sin Nombre")
		}
	}
	
	def validarNombreDeUsuario() {
		if(this.nombreDeUsuario === null || this.nombreDeUsuario.length==0){
			throw new BusinessException("No podes crear un usuario sin Nombre de Usuario")
		}
	}
	
	override getId() {
		id
	}
	
	override setId(int _id) {
		id = _id
	}
	
	def pagarEntrada(Entrada entrada) {
		agregarEntrada(entrada)
		plataQueTengo = plataQueTengo - entrada.valorDeLAEntrada
	}
	
	def agregarInvitacion(Invitacion invitacion) {
		invitaciones.add(invitacion)
	}	
}

