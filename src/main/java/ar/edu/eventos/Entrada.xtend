package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration

@Accessors
class Entrada {

	var double valorDeLAEntrada
	Usuario usuario
	val veintePorCiento = 0.2
	val diezPorCiento = 0.1
	val EventoAbierto EventoAbierto

	new(EventoAbierto unEventoAbierto) {
		EventoAbierto = unEventoAbierto
	}

	def elEventoFuePostegadoOCancelado() {
		EventoAbierto.elEventoFuePostegadoOCancelado
	}

	def diasFaltantes() {
		Duration.between(LocalDateTime.now, EventoAbierto.fechaDeInicioDelEvento).toDays()
	}

	def void devolverDinero() {
	print(elEventoFuePostegadoOCancelado)
		if (elEventoFuePostegadoOCancelado) {
			devolverEltotal
			} 
		else {
			print(diasFaltantes)
			if (0 < diasFaltantes && diasFaltantes < 8) {
			usuario.plataQueTengo = usuario.plataQueTengo + (diasFaltantes + 1) * diezPorCiento * valorDeLAEntrada
			}
			else {
			usuario.plataQueTengo = usuario.plataQueTengo + 8 * diezPorCiento * valorDeLAEntrada
			}
		}
	}

	def void devolverEltotal() {
		usuario.plataQueTengo = usuario.plataQueTengo + valorDeLAEntrada
	}
	
	def postergarEvento() {
		usuario.recibirMensaje("se postergo el evento\n")
	}
	
	def cancelarEvento() {
		usuario.recibirMensaje("se cancelo el evento\n")
	}

}
