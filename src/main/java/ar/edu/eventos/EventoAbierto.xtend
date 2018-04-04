package ar.edu.eventos

/* mosjim@gmail.com */
import java.time.LocalDateTime
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate

@Accessors
class EventoAbierto extends Evento {

	LocalDate fechaActual = LocalDate.now()
	LocalDateTime fechaMaximaDeConfirmacion
	
	List<Entrada> entradas = newArrayList
	
	var int valorDeLAEntrada
	

	new(String unNombre, Locacion unaLocacion, Usuario unOrganizador, int unValorDeLaEntrada) {
		super(unNombre, unaLocacion, unOrganizador)
		valorDeLAEntrada = unValorDeLaEntrada
	}

	def double capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	def double cantidadDeEntradasVendidas() {
		entradas.size()
	}

	def void adquirirEntrada(Usuario unUsuario) {
		if (this.capacidadMaxima() - this.cantidadDeEntradasVendidas > 0 && unUsuario.edad(fechaActual) < 18) {
			entradas.add(new Entrada(unUsuario))
		}
	}

	def fechaMaximaDeConfirmacion() {
		this.fechaMaximaDeConfirmacion
	}

	def boolean esExitoso() {
		lasCapacidadesSonExitosas && !fueCancelado && !fuePostergado
	}

	def boolean lasCapacidadesSonExitosas(){
		(capacidadMaxima() * 0.9 < cantidadDeEntradasVendidas)
	}

	def boolean esUnFracaso() {
		capacidadMaxima() * 0.5 > cantidadDeEntradasVendidas
	}
}
