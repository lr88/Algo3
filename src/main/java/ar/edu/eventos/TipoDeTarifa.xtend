package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

interface TipoDeTarifa {
	def double costo(Evento unEvento)

}

@Accessors
class TarifaFija implements TipoDeTarifa {
	var double valor
	override costo(Evento unEvento) {
		valor
	}
}
/* El costo se calcula en función de la
 *  duración del evento. Pueden tener un costo mínimo fijo. 
 */
@Accessors
class TarifaPorHora implements TipoDeTarifa {
	var double valor
	var int horasMinimas

	//TODO: El costo mínimo es un valor fijo
	override costo(Evento unEvento) {
		if (unEvento.duracion() > horasMinimas)
			valor * unEvento.duracion()
		else
			costoMinimoFijo()
	}

	def costoMinimoFijo() {
		valor * horasMinimas
	}
}

@Accessors
class TarifaPorPersona implements TipoDeTarifa {
	var double valor
	var int porcentajeMinimo

	//TODO: Está cobrando siempre el mínimo. Debería cobrar su tarifa por persona 
	//o el costo mínimo del servicio (el máximo de esoso dos valores) 
	override costo(Evento unEvento) {
		costoMinimo(unEvento) * valor
	}

	def costoMinimo(Evento unEvento) {
		unEvento.capacidadMaxima * (porcentajeMinimo / 100)
	}

}
