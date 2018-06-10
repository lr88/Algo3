package ar.edu.eventos.Eventos

/* mosjim@gmail.com */
import org.eclipse.xtend.lib.annotations.Accessors

import java.time.Duration
import java.time.LocalDateTime
import java.util.Set
import java.util.HashSet
import ar.edu.eventos.exceptions.BusinessException
import ar.edu.eventos.Usuario.Usuario

@Accessors
class EventoAbierto extends Evento {
	
	private Set<Entrada> entradas = new HashSet()
	protected Set <String> artistas = new HashSet ()
	public int edadMinima

	public def void adquirirEntrada(Usuario unUsuario, Entrada unaEntrada) {
			validarLaAdquisicionDeUnaEntrada(unUsuario)
			agregarEntrada(unaEntrada)
	}
	private def void validarLaAdquisicionDeUnaEntrada(Usuario unUsuario){
			validarEntradasDisponibles
			validarLaEdad(unUsuario)
			validarTiempoParaConfirmar(unUsuario)
	}
	private def void validarEntradasDisponibles(){
		if (!(entradasDisponibles > 0)) {
			throw new BusinessException("No hay Entradas disponibles")
		}
	}
	private def void validarLaEdad(Usuario unUsuario){
		if (!(unUsuario.edad() > edadMinima)) {
			throw new BusinessException("No corresponde la Edad")
		}
	}
	public def void agregarEntrada(Entrada unaEntrada) {
		entradas.add(unaEntrada)
	}
	public def void validarDevolverLaEntrada() {
		if(!(Duration.between(LocalDateTime.now, fechaDeInicioDelEvento).toDays() >= 1)){
			throw new BusinessException("No hay tiempo para devolver la entrada")
		}
	}
	public override double capacidadMaxima() {
		locacion.capacidadMaxima()
	}
	public override soyDeTipoEventoAbierto(){
		true
	}
	public override boolean esExitoso() {
		validarCapacidadMaximaParaExitoso 
		&& validarPostergacion
		&& validarCancelacion
	}
	private def boolean validarCapacidadMaximaParaExitoso(){
		capacidadMaxima * 0.9 < cantidadDeEntradasVendidas
	}
	private def boolean validarPostergacion(){
		!fuePostergado
	}
	public def boolean validarCancelacion(){
		!fueCancelado
	}
	public override boolean esUnFracaso() {
		cantidadDeEntradasVendidas < capacidadMaxima * 0.5
	}
	private def validarTiempoParaConfirmar(Usuario unUsuario) {
	if (!(tiempoDeConfirmacion > 0)) {
		throw new BusinessException("Paso el tiempo de confirmacion")
		}	
	}
	private def tiempoDeConfirmacion(){
		Duration.between(LocalDateTime.now, fechaMaximaDeConfirmacion).toMillis()
	}
	private def int entradasDisponibles() {
		(capacidadMaxima - cantidadDeEntradasVendidas).intValue
	}
	public override cancelarElEvento() {
		fueCancelado = true
		enProceso = false
		entradas.forEach[entrada|entrada.cancelarEvento]
		entradas.forEach[entrada|entrada.devolverEltotal()]
		entradas.clear
	}
	public override void tipoDeEventoPostergate() {
		entradas.forEach[entrada | entrada.postergarEvento()]
	}
	private def int cantidadDeEntradasVendidas() {
		entradas.size
	}
	public def void usuarioDevuelveEntrada(Entrada unaEntrada) {
		entradas.remove(unaEntrada)
	}
	public override double cantidadDePersonasQueAsisten() {
		cantidadDeEntradasVendidas()
	} 
	public def void artistasQueParticipanDelEvento(String unArtista){
		artistas.add(unArtista)
	}
}
