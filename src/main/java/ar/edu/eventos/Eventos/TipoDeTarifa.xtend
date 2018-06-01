package ar.edu.eventos.Eventos

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.Eventos.Evento

interface TipoDeTarifa {

	public def double costo(Evento unEvento)
}

@Accessors
class TarifaFija implements TipoDeTarifa {

	var double valor

	public override double costo(Evento unEvento) {
		valor
	}
}

@Accessors
class TarifaPorHora implements TipoDeTarifa {

	var double valor
	var double costoMínimoFijo

	public override double costo(Evento unEvento) {
		return Math.max(valor * unEvento.duracion().intValue, costoMínimoFijo)
	}
}

@Accessors
class TarifaPorPersona implements TipoDeTarifa {

	var double valor
	var double porcentajeMinimo

	public override double costo(Evento unEvento) {
		return Math.max(unEvento.cantidadDePersonasQueAsisten() * valor,
			costoMinimo(unEvento)* valor)
	}
	
	def costoMinimo(Evento unEvento) {
		unEvento.capacidadMaxima * (porcentajeMinimo * 0.01)
	}
	
}
