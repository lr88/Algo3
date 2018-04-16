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

	new(String unNombre, Locacion unaLocacion, Usuario unOrganizador, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		super(unNombre, unaLocacion, unOrganizador, unInicioDelEvento, unFinDelEvento)

		ValorDeLaEntrada = unValorDeLaEntrada
		fechaMaximaDeConfirmacion = unaFechaMaximaDeConfirmacion
		print("se creo un evento Abierto\n")
	}

	def void adquirirEntrada(Usuario unUsuario) {
		if (entradasDisponibles > 0 && !unUsuario.soyMenorDeEdad(fechaActual) && hayTiempoParaConfirmar)
			agregarEntrada(new Entrada(unUsuario, ValorDeLaEntrada))
			
	}

	def void agregarEntrada(Entrada unaEntrada) {
		entradas.add(unaEntrada)
	}

	def LocalDateTime fechaMáximaConfirmación(){
		fechaMaximaDeConfirmacion
	}

	def double capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	def cantidadTotalDeEntradasDisponibles(){
		capacidadMaxima
	}

	def boolean esExitoso() {
		cantidadTotalDeEntradasDisponibles * 0.9 < cantidadDeEntradasVendidas && !fuePostergado && !fueCancelado
	}

	def boolean esUnFracaso() {
		cantidadDeEntradasVendidas > cantidadTotalDeEntradasDisponibles * 0.5
	}

	def boolean hayTiempoParaConfirmar() {
		(Duration.between(fechaActual, fechaMaximaDeConfirmacion).toHours()) > 0
	}

	def int entradasDisponibles() {
		(cantidadTotalDeEntradasDisponibles - cantidadDeEntradasVendidas).intValue
	}

	override cancelarElEvento(Evento unEvento) {
		fueCancelado = true
		entradas.forEach[entrada|entrada.usuario.mensajes.add("se cancelo el evento\n")]
		entradas.forEach[entrada|entrada.devolverEltotal()]
		entradas.clear
	}

	override void postergarElEvento(Evento unEvento, LocalDateTime NuevaFechaDeInicioDelEvento) {
		fuePostergado = true
		entradas.forEach[entrada|entrada.usuario.mensajes.add("se postergo el evento\n")]
		organizador.indicarNuevaFechaDeEvento(this, NuevaFechaDeInicioDelEvento)
	}

	def int cantidadDeEntradasVendidas() {
		entradas.size
	}

	def void usuarioDevuelveEntrada(Entrada unaEntrada) {
		entradas.remove(unaEntrada)
	}

	override void cambiarFecha(LocalDateTime nuevaFecha) {
		var aux = Duration.between(inicioDelEvento, nuevaFecha)
		inicioDelEvento = inicioDelEvento.plus(aux)
		finDelEvento = finDelEvento.plus(aux)
		fechaMaximaDeConfirmacion = fechaMaximaDeConfirmacion.plus(aux)
	}
}
