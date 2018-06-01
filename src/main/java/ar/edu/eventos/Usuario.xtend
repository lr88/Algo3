package ar.edu.eventos
import ar.edu.eventos.exceptions.BusinessException

import java.time.Duration
import java.time.LocalDateTime
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.exceptions.Validar
import java.util.ArrayList

@Accessors
class Usuario implements Entidad {
	protected Validar validarcion = new Validar
	protected var int id
	protected List <String> mensajes = newArrayList()
	protected Set<Evento> eventos = new HashSet ()
	protected Set<Usuario> amigos = new HashSet()	
	protected Set <Invitacion> invitaciones = new HashSet ()
	protected Set<Entrada> entradas = new HashSet()	
	protected String nombreDeUsuario
	protected String nombre
	protected String apellido
	protected String email
	protected Locacion direccion
	protected LocalDateTime fechaDeNacimiento
	protected boolean esAntisocial
	protected var double plataQueTengo = 100
	protected var double radioDeCercanía
	protected TipoDeUsuario tipoDeUsuario
	protected int cantidadDeAcompañantes
	protected Tarjeta tarjeta 
	protected var List<MailInterno> mailsRecibidos = new ArrayList<MailInterno>
	protected var List<ObserverCrearEvento> listaAccionesAlCrearUnEvento = new ArrayList<ObserverCrearEvento>
	
	public def void comprarEntradaDeEventoAbierto(EventoAbierto unEvento,Entrada unaEntrada) {
		pagarEntrada(unaEntrada)
		agregarEntrada(unaEntrada)
		unEvento.adquirirEntrada(this,unaEntrada)
	}

	private def void agregarEntrada(Entrada entrada) {
		entrada.usuario = this
		entradas.add(entrada)
	}
	
	public def void cambiarTipoDeUsuario(TipoDeUsuario unTipoDeUsuario){
		tipoDeUsuario = unTipoDeUsuario
	}
	
	public def void agregarAmigo(Usuario unAmigo) {
		amigos.add(unAmigo)
	}
	
	public def void eliminarAmigos(Usuario unUsuario) {
		amigos.remove(unUsuario)
	}

	public def long edad() {
		Duration.between(fechaDeNacimiento, LocalDateTime.now).toDays/360
	}

	public def int cantidadDeEventosEnEsteMes(Evento unEvento){
		eventos.filter[evento|evento.fechaDeInicioDelEvento.getMonth == unEvento.fechaDeInicioDelEvento.getMonth && evento.fechaDeInicioDelEvento.getYear == unEvento.fechaDeInicioDelEvento.getYear].size
	}
	
	public def void crearEventoCerrado(Evento unEvento) {
		tipoDeUsuario.puedoOrganizarelEventoCerrado(unEvento,this)
		agregarEvento(unEvento)
		listaAccionesAlCrearUnEvento.forEach[observer|observer.ejecutar(this)]
	}

	public def void crearEventoAbierto(EventoAbierto unEvento) {
		tipoDeUsuario.puedoOrganizarEventoAbierto(unEvento,this)
		agregarEvento(unEvento)
		listaAccionesAlCrearUnEvento.forEach[observer|observer.ejecutar(this)]
	}
	
	public def void devolverEntrada(Entrada unaEntrada,EventoAbierto unEvento){
		unEvento.validarDevolverLaEntrada
		unaEntrada.devolverDinero()
		unEvento.usuarioDevuelveEntrada(unaEntrada)
		entradas.remove(unaEntrada)
	}
    
	public def void invitarAUnUsuario(Usuario unUsuario, int unaCantidadMaximaDeAcompañantes,EventoCerrado unEvento) { 
		if(!(unEvento.organizador == this)){
			throw new BusinessException("No se puede crear invitacion, no sos el organizador del evento")
			}
		unEvento.invitarAUnUsuario(unUsuario,unaCantidadMaximaDeAcompañantes)
	}
	
  	public def void aceptarInvitacion(Invitacion unaInvitacion,int unaCantidadDeAcompañantes){
		validarTiempoParaConfirmar(unaInvitacion)
		validarCantidadDeAcompañantes(unaInvitacion,unaCantidadDeAcompañantes)
		unaInvitacion.estadoAceptado = true
		unaInvitacion.cantidadDeAcompañantes = unaCantidadDeAcompañantes
		
		
	}
	
	private def void validarTiempoParaConfirmar(Invitacion unaInvitacion){
		if(!(LocalDateTime.now < unaInvitacion.evento.fechaMaximaDeConfirmacion)){
			throw new BusinessException("No se puede aceptar la invitacion, supera el tiempo de confirmacion")
		}
	}
	
	private def void validarCantidadDeAcompañantes(Invitacion unaInvitacion, int unaCantidadDeAcompañantes){
		if(!(unaCantidadDeAcompañantes < unaInvitacion.cantidadMaximaDeAcompañantes)){
		throw new BusinessException("No se puede aceptar la invitacion, supera la cantidad de acompañantes")
		}
	}

	public def void rechazarInvitacion(Invitacion unaInvitacion){
		unaInvitacion.estadoRechazado = true
		}

	public def void cancelarEvento(Evento unEvento){
		tipoDeUsuario.puedoCancelarElEvento(unEvento)
		unEvento.cancelarElEvento()
		
	}
	public def void postergarEvento(Evento unEvento,LocalDateTime NuevaFechaDeInicioDelEvento){
		tipoDeUsuario.puedoPostergarElEvento(unEvento)
		unEvento.cambiarFecha(NuevaFechaDeInicioDelEvento)
	}
	
	public def void aceptacionMasiva(){
		listaDeTodosMisInvitacionesPendientes.
		forEach[inv | if(validarAceptacionMasiva(inv)){aceptarInvitacion(inv,inv.cantidadDeAcompañantes)}]
	}
	
	private def boolean validarAceptacionMasiva(Invitacion inv){
		esElOrganizadorMiAmigo(inv)  || asistenMasDeTantosAmigos(inv,4)  ||!meQuedaSerca(inv)
	}
	
	private def boolean esElOrganizadorMiAmigo(Invitacion unaInvitacion){
		amigos.contains(unaInvitacion.elOrganizadorDelEvento)
	}
	
	private def boolean asistenMasDeTantosAmigos(Invitacion unaInvitacion,int cantidad){
		this.invitaciones.filter[invi|invi.evento.nombre == (unaInvitacion.usuario.invitaciones.map[invita|invita.evento.nombre])].size()>cantidad
	}
	
	public def boolean meQuedaSerca(Invitacion invitacion) {
		invitacion.distanciaAmiCasa(direccion.ubicacion) < radioDeCercanía 
	}
	
	public def void rechazoMasivo(){
		if(!esAntisocial){
		listaDeTodosMisInvitacionesPendientes.forEach[inv | if(validacionRechazoMasivo(inv)== true){
			aceptarInvitacion(inv,inv.cantidadDeAcompañantes)}]
		}
	else{
		invitaciones.filter[invitacion | asistenMasDeTantosAmigos(invitacion, 0) == true && !meQuedaSerca(invitacion) ]
			.forEach[invitacion | this.rechazarInvitacion(invitacion)]
		}
	}

	private def boolean validacionRechazoMasivo(Invitacion inv){
		(esElOrganizadorMiAmigo(inv) && asistenMasDeTantosAmigos(inv,1)) || !asistenMasDeTantosAmigos(inv,2) || !meQuedaSerca(inv)
	}

	public def Iterable<Invitacion> listaDeTodosMisInvitacionesRechazadas(){
		invitaciones.filter[ invitacion | invitacion.estadoRechazado == true]
	}
	
	public def Iterable<Invitacion> listaDeTodosMisInvitacionesAceptadas(){
		invitaciones.filter[ invitacion | invitacion.estadoAceptado == true]
	}
	
	public def Iterable<Invitacion> listaDeTodosMisInvitacionesPendientes(){
		invitaciones.filter[ invitacion | invitacion.estadoPendiente == true]
	}
	
	public def void eliminarInvitacion(Invitacion invitacion) {
		invitaciones.remove(invitacion)
	}
	
	public def void recibirMensaje(String string) {
		mensajes.add(string)
	}
	
	public def int cantidadDeAmigos(){
		amigos.size()
	}
	
	public def double eventosActivos(){
		eventos.filter[evento | evento.enProceso == true].size()
	}
	
	private def void agregarEvento(Evento evento) {
		evento.validar
		evento.organizador = this
		eventos.add(evento)
	}
	
	public override void validar() {
		this.validarNombreDeUsuario()
		this.validarNombre()
		this.validarApellido()
		this.validarEmail()
		this.validarFechaDeNacimiento()
		this.validarDireccion()
	}
	
	private def void validarNombreDeUsuario() {
		validarcion.validarStringNoNulo(nombreDeUsuario,"Nombre De Usuario")
	}
	
	private def void validarNombre() {
		validarcion.validarStringNoNulo(nombre,"nombre")
	}
	
	private def void validarApellido() {
		validarcion.validarStringNoNulo(apellido,"Apellido")
	}
	
	private def void validarEmail() {
		validarcion.validarStringNoNulo(email,"email")
	}
	
	private def void validarFechaDeNacimiento() {
		validarcion.validarObjetoNoNulo(fechaDeNacimiento, "Fecha de Nacimiento")
	}
	
	private def void validarDireccion() {
		validarcion.validarStringYObjetoNoNulo(direccion,direccion.nombreDeLaLocacion, "dirección")
	}

	public def void pagarEntrada(Entrada entrada) {
		tarjeta.pagarEntrada(entrada)
	}
	
	public def void agregarInvitacion(Invitacion invitacion) {
		invitaciones.add(invitacion)
	}
	
	public def void sumarDinero(double dinero) {
		plataQueTengo = plataQueTengo + dinero
	}
	
	override getId() {
		id
	}

	override setId(int unId) {
		id = unId
	}
	
	def recibirMensajeDeMail(MailInterno mail) {
		mailsRecibidos.add(mail)
	}
	
	def agregarAccion(ObserverCrearEvento observer) {
		listaAccionesAlCrearUnEvento.add(observer)
	}

	def eliminarAccion(ObserverCrearEvento observer) {
		listaAccionesAlCrearUnEvento.remove(observer)
	}
}

