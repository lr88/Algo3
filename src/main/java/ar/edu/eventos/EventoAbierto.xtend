package ar.edu.eventos

/* mosjim@gmail.com */

import java.time.LocalDate
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.Duration

@Accessors
class EventoAbierto extends Evento {

	LocalDate fechaActual = LocalDate.now()
	LocalDate fechaMaximaDeConfirmacion
	List<Entrada> entradas = newArrayList
	int ValorDeLaEntrada
	new(String unNombre, Locacion unaLocacion, Usuario unOrganizador, int unValorDeLaEntrada,LocalDate unaFechaMaximaDeConfirmacion) {
		super(unNombre, unaLocacion, unOrganizador)
		ValorDeLaEntrada = unValorDeLaEntrada
	}

	def double capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	def double cantidadDeEntradasVendidas() {
		entradas.size()
	}
	
	def void adquirirEntrada(Usuario unUsuario) {
		if (this.capacidadMaxima() - this.cantidadDeEntradasVendidas > 0 
			&& unUsuario.soyMenorDeEdad(fechaActual)
			&& Duration.between(fechaActual, fechaMaximaDeConfirmacion).toMillis < 0.0) 
		 {
			entradas.add(new Entrada(unUsuario, ValorDeLaEntrada))
		}
	}

	def boolean esExitoso() {
		lasCapacidadesSonExitosas && !fueCancelado && !fuePostergado
	}

	def boolean lasCapacidadesSonExitosas() {
		(capacidadMaxima() * 0.9 < cantidadDeEntradasVendidas)
	}

	def boolean esUnFracaso() {
		capacidadMaxima() * 0.5 > cantidadDeEntradasVendidas
	}
}
