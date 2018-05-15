package ar.edu.eventos

/* mosjim@gmail.com */
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.Duration
import java.time.LocalDateTime
import java.util.Set
import java.util.HashSet
import ar.edu.eventos.exceptions.BusinessException

@Accessors
class EventoAbierto extends Evento {

	int ValorDeLaEntrada
	Set<Entrada> entradas = new HashSet()
	int edadMinima

	def void adquirirEntrada(Usuario unUsuario, Entrada unaEntrada) {
			validarLaAdquisicionDeUnaEntrada(unUsuario)
			unUsuario.pagarEntrada(unaEntrada)
			agregarEntrada(unaEntrada)
	}

	def validarLaAdquisicionDeUnaEntrada(Usuario unUsuario){
			hayEntradasDisponibles
			correspondeLaEdad(unUsuario)
			hayTiempoParaConfirmar(unUsuario)
	}


	def hayEntradasDisponibles(){
		if (entradasDisponibles > 0) {
		} else {
			throw new BusinessException("No hay Entradas disponibles")
		}
	}

	def correspondeLaEdad(Usuario unUsuario){
		if (unUsuario.edad() > edadMinima) {
		} else {
			throw new BusinessException("No corresponde la Edad")
		}
	}

	def void agregarEntrada(Entrada unaEntrada) {
		entradas.add(unaEntrada)///exception
	}

	def sePuedeDevolverLaEntrada() {
		Duration.between(LocalDateTime.now, fechaDeInicioDelEvento).
		toDays() >= 1///exception
	}

	override double capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	override boolean esExitoso() {
		validarCapacidadMaximaParaExitoso 
		&& validarPostergacion
		&& validarCancelacion
	}

	def validarCapacidadMaximaParaExitoso(){
		capacidadMaxima * 0.9 < cantidadDeEntradasVendidas
	}

	def validarPostergacion(){
		!fuePostergado
	}
	
	def validarCancelacion(){
		!fueCancelado
	}

	override boolean esUnFracaso() {
		cantidadDeEntradasVendidas < capacidadMaxima * 0.5
	}

	def hayTiempoParaConfirmar(Usuario unUsuario) {
	if (cuantoFaltaParaElEvento > 0) {
		} else {
			throw new BusinessException("Paso el tiempo de confirmacion")
		}	
	}

	def cuantoFaltaParaElEvento(){
		Duration.between(LocalDateTime.now, fechaMaximaDeConfirmacion).toMillis()
	}

	def int entradasDisponibles() {
		(capacidadMaxima - cantidadDeEntradasVendidas).intValue
	}

	override cancelarElEvento() {
		fueCancelado = true
		enProceso = false
		entradas.forEach[entrada|entrada.cancelarEvento]
		entradas.forEach[entrada|entrada.devolverEltotal()]
		entradas.clear
	}

	override void tipoDeEventoPostergate() {
		entradas.forEach[entrada | entrada.postergarEvento()]
	}

	def int cantidadDeEntradasVendidas() {
		entradas.size
	}

	def void usuarioDevuelveEntrada(Entrada unaEntrada) {
		entradas.remove(unaEntrada)
	}
	
	override cantidadDePersonasQueAsisten() {
		cantidadDeEntradasVendidas()
	}
	
}
