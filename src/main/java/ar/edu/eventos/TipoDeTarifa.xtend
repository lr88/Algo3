package ar.edu.eventos

interface TipoDeTarifa {

	def double costo(Evento unEvento)

}

class TarifaFija implements TipoDeTarifa {
	//var tarifa 
	
		override costo(Evento unEvento) {
		1
	}

}

class TarifaPorHora implements TipoDeTarifa {

	override costo(Evento unEvento) {
	   1//unEvento.duracion
	}

}

class TarifaPorPersona implements TipoDeTarifa {

	override costo(Evento unEvento) {
		1
	}

}