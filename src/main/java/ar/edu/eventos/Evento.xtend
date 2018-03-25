package ar.edu.eventos


import java.time.LocalDateTime
import java.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Evento {
	
	LocalDateTime inicioDelEvento 
	LocalDateTime finDelEvento
	String nombre
	
	new(String unNombre){
		
		nombre=unNombre
	}

  
   def long duracion(){
   	
   	Duration.between(inicioDelEvento,finDelEvento).getSeconds()
   	
   }
		
	
}