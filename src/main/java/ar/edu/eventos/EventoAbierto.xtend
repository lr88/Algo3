package ar.edu.eventos

import java.time.LocalDateTime
import java.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

/*Los eventos abiertos son aquellos a los cuales puede asistir cualquier persona. 
Para asistir se debe sacar una entrada, a través de esta misma aplicación. 
Si bien existen eventos abiertos gratuitos, 
a fines prácticos consideraremos que son eventos cuya entrada vale $0.*/


@Accessors
class EventoAbierto extends Evento {
	
	LocalDateTime fechaMaximaParaSacarEntradas
	
	new(String unNombre, Locacion unaLocacion) {
		super(unNombre,unaLocacion)
	}
	
	
	def asistir(Usuario _persona){
		_persona.comprarEntrada()
		usuario.add(_persona)
	}
   
   /*Capacidad máxima: La cantidad máxima de personas que pueden asistir. 
   En eventos abiertos la capacidad estará determinada por la superficie total de la locación.
   Se consideran necesarios 0.8m2 por persona..*/
   
   def capacidadMaxima(){
   	 locacion.superficie(this)
   }
   
     /*Fecha máxima confirmación: En el caso de eventos abiertos, es hasta cuando se puede sacar entradas.  */
  
   def fechaMaximaDeConfirmacion(){
   	this.fechaMaximaParaSacarEntradas
   }
   
   
   /*Los eventos abiertos son un éxito si se venden al menos el 90% de las entradas disponibles 
    y no fueron cancelados o postergados.  */
    
    
    def esExitoso(){
    	
    }
    
    /*Edad Mínima: (Aplicable solo a eventos abiertos). No podrán asistir 
     al evento usuarios menores a esa edad.  */
    
    
       /* En el caso de eventos abiertos, si se venden menos del 50% de las entradas.  */
    def esUnFracaso(){
    	
    }
}