package ar.edu.eventos

/* mosjim@gmail.com */
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.Duration
import java.time.LocalDateTime
import java.util.Set
import java.util.HashSet

@Accessors
class EventoAbierto extends Evento {

	int ValorDeLaEntrada
	Set<Entrada> entradas = new HashSet()
	int edadMinima

	def void adquirirEntrada(Usuario unUsuario, Entrada unaEntrada) {
		if (entradasDisponibles > 0 && unUsuario.edad() > edadMinima && hayTiempoParaConfirmar(unUsuario))
			agregarEntrada(unaEntrada)
		unUsuario.agregarEntrada(unaEntrada)
	}

	def void agregarEntrada(Entrada unaEntrada) {
		entradas.add(unaEntrada)
	}

	def sePuedeDevolverLaEntrada() {
		Duration.between(LocalDateTime.now, fechaDeInicioDelEvento).toDays() > 1
	}

	def double capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	override boolean esExitoso() {
		capacidadMaxima * 0.9 < cantidadDeEntradasVendidas && !fuePostergado && !fueCancelado
	}

	override boolean esUnFracaso() {
		cantidadDeEntradasVendidas < capacidadMaxima * 0.5
	}

	def boolean hayTiempoParaConfirmar(Usuario unUsuario) {
		if ((Duration.between(LocalDateTime.now, fechaMaximaDeConfirmacion).toMillis()) > 0) {
			true
		} else {
			unUsuario.recibirMensaje("Paso el tiempo de compra de entradas\n")
			false
		}
	}

	def int entradasDisponibles() {
		(capacidadMaxima - cantidadDeEntradasVendidas).intValue
	}

	override cancelarElEvento() {
		fueCancelado = true
		entradas.forEach[entrada|entrada.cancelarEvento]
		entradas.forEach[entrada|entrada.devolverEltotal()]
		entradas.clear
	}

	override void tipoDeEventoPostergate() {
		entradas.forEach[entrada|entrada.postergarEvento]
	}

	def int cantidadDeEntradasVendidas() {
		entradas.size
	}

	def void usuarioDevuelveEntrada(Entrada unaEntrada) {
		entradas.remove(unaEntrada)
	}

}
