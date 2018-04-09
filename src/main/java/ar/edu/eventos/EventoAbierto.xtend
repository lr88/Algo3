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
		lasCapacidadesSonExitosas && estadoDelEvento && !fuePostergado
	}

	def boolean esUnFracaso() {
		capacidadMaxima() * 0.5 > cantidadDeEntradasVendidas
	}

	def boolean lasCapacidadesSonExitosas() {
		capacidadMaxima() * 0.9 < cantidadDeEntradasVendidas
	}

	/*------------------------- */
	def boolean hayTiempoParaConfirmar() {
		(Duration.between(fechaActual, fechaMaximaDeConfirmacion).toHours()) > 0
	}

	/*------------------------- */
	def void adquirirEntrada(Usuario unUsuario) {
		if (this.capacidadMaxima() - this.cantidadDeEntradasVendidas > 0 && !unUsuario.soyMenorDeEdad(fechaActual) &&
			hayTiempoParaConfirmar) {
			entradas.add(new Entrada(unUsuario, ValorDeLaEntrada))

		}
	}

	def int cantidadDeEntradasVendidas() {
		entradas.size
	}

	def usuarioDevuelveEntrada(Usuario unUsuario) {
		entradas.remove(new Entrada(unUsuario, ValorDeLaEntrada))
	}
}
