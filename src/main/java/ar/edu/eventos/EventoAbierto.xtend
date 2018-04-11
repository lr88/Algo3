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

	}

	def double capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	def boolean esExitoso() {
		lasCapacidadesSonExitosas && !fuePostergado && !fueCancelado
	}

	def boolean lasCapacidadesSonExitosas() {
		capacidadMaxima * 0.9 < cantidadDeEntradasVendidas
	}

	def boolean esUnFracaso() {
		capacidadMaxima * 0.5 > cantidadDeEntradasVendidas
	}

	def boolean hayTiempoParaConfirmar() {
		(Duration.between(fechaMaximaDeConfirmacion,fechaActual).toHours()) > 0
	}

	def void adquirirEntrada(Usuario unUsuario) {
		
	}

	override cancelarElEvento(Evento unEvento) {

	}

	override postergarElEvento(Evento unEvento, LocalDateTime NuevaFechaDeInicioDelEvento) {
		
	}

	def int cantidadDeEntradasVendidas() {
		entradas.size
	}

	def usuarioDevuelveEntrada(Entrada unaEntrada) {
		entradas.remove(unaEntrada)
	}

	override void cambiarFecha(LocalDateTime nuevaFecha) {

		var aux = Duration.between(inicioDelEvento, nuevaFecha)
		print(aux)
		inicioDelEvento = inicioDelEvento.plus(aux)
		finDelEvento = finDelEvento.plus(aux)
		fechaMaximaDeConfirmacion = fechaMaximaDeConfirmacion.plus(aux)
	}
}
