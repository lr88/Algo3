package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

interface TipoDeTarifa {
	
	public def double costo(Evento unEvento)

}

@Accessors
class TarifaFija implements TipoDeTarifa {
	
	private var double valor
	
	override costo(Evento unEvento) {
		valor
	}
}

@Accessors
class TarifaPorHora implements TipoDeTarifa {
	
	private var double valor
	private var double costoMínimoFijo

	
	override costo(Evento unEvento) {
		return Math.max(valor*unEvento.duracion().intValue,costoMínimoFijo)
		}
}

@Accessors
class TarifaPorPersona implements TipoDeTarifa {
	
	private  var double valor
	private var double porcentajeMinimo


	override costo(Evento unEvento) {
		return Math.max(unEvento.cantidadDePersonasQueAsisten() * valor, unEvento.capacidadMaxima() * porcentajeMinimo*valor)
	}
}
