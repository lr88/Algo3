package ar.edu.eventos

import java.time.LocalDateTime

import java.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

/*Los eventos cerrados son aquellos a los cuales solo pueden asistir sus invitados.
 Las invitaciones, al igual que las entradas, serán gestionadas por nuestro sistema. 
*/

@Accessors
class EventoCerrado extends Evento {

 	new(String unNombre, Locacion unaLocacion) {
		super(unNombre,unaLocacion)
	}

  def asistir(Usuario _persona){
  	_persona.esInvitado()
  	usuario.add(_persona)
  }
  
  
   /*Capacidad máxima: La cantidad máxima de personas que pueden asistir. 
   En los eventos cerrados, esta cantidad será definida por el organizador.*/
   
   def capacidadMaxima(){
   	organizador.cantidadMaxima
   }
   
   /*Fecha máxima confirmación:  En el caso de eventos cerrados, 
   es la fecha hasta la cual un invitado puede confirmar que asiste al evento. */
  
   def fechaMaxima(){
   	
   }
   
   
    /*Un evento cerrado fue exitoso si confirmaron al menos 
     * el 80% de las invitaciones y no fue cancelado.  */
    
    def esExitoso(){
    	
    }
    
    /*Es un fracaso: Se considera un fracaso a los eventos cerrados a los que asisten 
    menos del 50% de los invitados */
    def esUnFracaso(){
    	
    }
}