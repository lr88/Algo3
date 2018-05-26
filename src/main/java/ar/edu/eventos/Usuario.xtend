package ar.edu.eventos
import ar.edu.eventos.exceptions.BusinessException

import java.time.Duration
import java.time.LocalDateTime
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.exceptions.Validar

@Accessors
class Usuario implements Entidad {
	Validar validarcion = new Validar
	var int id
	List <String> mensajes = newArrayList()
	Set<Evento> eventos = new HashSet ()
	Set<Usuario> amigos = new HashSet()	
	Set <Invitacion> invitaciones = new HashSet ()
	Set<Entrada> entradas = new HashSet()	
	String nombreDeUsuario
	String nombre
	String apellido
	String email
	Locacion direccion
	LocalDateTime fechaDeNacimiento
	boolean esAntisocial
	var double plataQueTengo = 100
	var double radioDeCercanía
	TipoDeUsuario tipoDeUsuario
	int cantidadDeAcompañantes
	
	def comprarEntradaDeEventoAbierto(EventoAbierto unEvento,Entrada unaEntrada,TipoDePago moneda) {
		unEvento.adquirirEntrada(this,unaEntrada,moneda)
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
	
	def eliminarAmigos(Usuario unUsuario) {
		amigos.remove(unUsuario)
	}

	def edad() {
		Duration.between(fechaDeNacimiento, LocalDateTime.now).toDays/360
	}

	def cantidadDeEventosEnEsteMes(Evento unEvento){
		eventos.filter[evento|evento.fechaDeInicioDelEvento.getMonth == unEvento.fechaDeInicioDelEvento.getMonth && evento.fechaDeInicioDelEvento.getYear == unEvento.fechaDeInicioDelEvento.getYear].size
	}
	
	def crearEventoCerrado(Evento unEvento) {
		tipoDeUsuario.puedoOrganizarelEventoCerrado(unEvento,this)
		agregarEvento(unEvento)
	}

	def crearEventoAbierto(EventoAbierto unEvento) {
		tipoDeUsuario.puedoOrganizarEventoAbierto(unEvento,this)
		agregarEvento(unEvento)
	}
	
	def devolverEntrada(Entrada unaEntrada,EventoAbierto unEvento){
		unEvento.validarDevolverLaEntrada
		unaEntrada.devolverDinero()
		unEvento.usuarioDevuelveEntrada(unaEntrada)
		entradas.remove(unaEntrada)
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
		validarTiempoParaConfirmar(unaInvitacion)
		validarCantidadDeAcompañantes(unaInvitacion,unaCantidadDeAcompañantes)
		unaInvitacion.estadoAceptado = true
		unaInvitacion.cantidadDeAcompañantes = unaCantidadDeAcompañantes
		
		
	}
	def validarTiempoParaConfirmar(Invitacion unaInvitacion){
		if(!(LocalDateTime.now < unaInvitacion.evento.fechaMaximaDeConfirmacion)){
			throw new BusinessException("No se puede aceptar la invitacion, supera el tiempo de confirmacion")
		}
	}
	
	def validarCantidadDeAcompañantes(Invitacion unaInvitacion, int unaCantidadDeAcompañantes){
		if(!(unaCantidadDeAcompañantes < unaInvitacion.cantidadMaximaDeAcompañantes)){
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
		forEach[inv | if(validarAceptacionMasiva(inv)){aceptarInvitacion(inv,inv.cantidadDeAcompañantes)}]
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
		invitacion.distanciaAmiCasa(direccion.ubicacion) < radioDeCercanía 
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
	
	def agregarEvento(Evento evento) {
		evento.validar
		evento.organizador = this
		eventos.add(evento)
	}
	
	override validar() {
		this.validarNombreDeUsuario()
		this.validarNombre()
		this.validarApellido()
		this.validarEmail()
		this.validarFechaDeNacimiento()
		this.validarDireccion()
	}
	
	def validarNombreDeUsuario() {
		validarcion.validarStringNoNulo(nombreDeUsuario,"Nombre De Usuario")
	}
	def validarNombre() {
		validarcion.validarStringNoNulo(nombre,"nombre")
	}
	def validarApellido() {
		validarcion.validarStringNoNulo(apellido,"Apellido")
	}
	def validarEmail() {
		validarcion.validarStringNoNulo(email,"email")
	}
	def validarFechaDeNacimiento() {
		validarcion.validarObjetoNoNulo(fechaDeNacimiento, "Fecha de Nacimiento")
	}
	def validarDireccion() {
		validarcion.validarStringYObjetoNoNulo(direccion,direccion.nombreDeLaLocacion, "dirección")
	}

	public def pagarEntrada(Entrada entrada,TipoDePago moneda) {
		moneda.pagarEntrada(this,entrada)
		agregarEntrada(entrada)
		
	}
	
	def agregarInvitacion(Invitacion invitacion) {
		invitaciones.add(invitacion)
	}
	
	def sumarDinero(double dinero) {
		plataQueTengo = plataQueTengo + dinero
	}
	
}

