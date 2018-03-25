package ar.edu.eventos


import java.time.LocalDateTime
import java.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Evento {
	
	LocalDateTime inicioDelEvento 
	LocalDateTime finDelEvento
	String nombre
	Float locacionX
	Float locacionY
	
	
	new(String unNombre){
		
		nombre=unNombre
	}

  	def ubicacion (float X,float Y){
  		locacionX = X
  		locacionY = Y
  	}
  
  
   def long duracion(){
   	
   	Duration.between(inicioDelEvento,finDelEvento).getSeconds()
   	
   }
		
	
}