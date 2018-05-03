package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

interface TipoDeTarifa {
   
	def double costo(Evento unEvento)

}

/*El costo de un servicio con tarifa fija será siempre el mismo para cualquier evento.  */

@Accessors
class TarifaFija implements TipoDeTarifa {
	 var double valor
	override costo(Evento unEvento) {
		valor
	}

}

/* El costo se calcula en función de la duración del evento. Pueden tener un costo mínimo fijo. 
 */
@Accessors
class TarifaPorHora implements TipoDeTarifa {
    var double valor
    var int horasMinimas 
    
	override costo(Evento unEvento) {
		if (unEvento.duracion() > horasMinimas )
		valor * unEvento.duracion()
		else
		costoMinimoFijo()
	}
	
	def costoMinimoFijo(){
		valor * horasMinimas
	}

}

@Accessors
class TarifaPorPersona implements TipoDeTarifa {
    var double valor
    var int porcentajeMinimo
    
	override costo(Evento unEvento) {
		costoMinimo(unEvento) * valor
	}
	 def costoMinimo(Evento unEvento){
	 	unEvento.capacidadMaxima * (porcentajeMinimo / 100)
	 }

}
