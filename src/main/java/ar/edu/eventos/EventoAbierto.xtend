package ar.edu.eventos

/* mosjim@gmail.com */

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.Duration
import java.time.LocalDateTime

@Accessors
class EventoAbierto extends Evento {
	
	int ValorDeLaEntrada
	List<Entrada> entradas = newArrayList
	

	new(String unNombre, Locacion unaLocacion, Usuario unOrganizador, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion) {
		super(unNombre, unaLocacion, unOrganizador)
		ValorDeLaEntrada = unValorDeLaEntrada
		fechaMaximaDeConfirmacion = unaFechaMaximaDeConfirmacion
		
	}

	def double capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	def boolean esExitoso() {
		lasCapacidadesSonExitosas && !estadoDelEvento && !fuePostergado
	}

	def boolean esUnFracaso() {
		capacidadMaxima() * 0.5 > cantidadDeEntradasVendidas
	}

	def boolean lasCapacidadesSonExitosas() {
		(capacidadMaxima() * 0.9 < cantidadDeEntradasVendidas)
	}
/*------------------------- */
	def boolean hayTiempoParaConfirmar(){
		(Duration.between(fechaActual,fechaMaximaDeConfirmacion).toHours()) > 0
	}
	
/*------------------------- */
	def void adquirirEntrada(Usuario unUsuario) {
		if (this.capacidadMaxima() - this.cantidadDeEntradasVendidas > 0 && unUsuario.soyMenorDeEdad(fechaActual)
			&& hayTiempoParaConfirmar) {
			entradas.add(new Entrada(unUsuario, ValorDeLaEntrada))
		}
	}

	def double cantidadDeEntradasVendidas() {
		entradas.size()
	}

}
