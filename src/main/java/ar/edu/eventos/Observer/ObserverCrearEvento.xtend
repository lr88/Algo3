package ar.edu.eventos.Observer

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.Usuario.Usuario
import ar.edu.eventos.Mails.MailInterno
import org.uqbar.mailService.MailService
import org.uqbar.mailService.Mail
import ar.edu.eventos.Eventos.EventoAbierto
import ar.edu.eventos.Eventos.Evento

@Accessors
abstract class ObserverCrearEvento {

	String nombre

	new(String nom) {
		nombre = nom
	}
	
	def void ejecutar(Usuario unUsuario)
	
	override toString() {
		nombre
	}
	
}

class AmigoDelCreador extends ObserverCrearEvento {

	new(String nom) {
		super(nom)
	}

	override void ejecutar(Usuario unUsuario) {
		var String mensaje
		mensaje = this.generarTexto(unUsuario)
		val MailInterno mail = new MailInterno(mensaje, unUsuario)
		unUsuario.amigos.forEach[amigo|amigo.recibirMensajeDeMail(mail)]
	}

	def String generarTexto(Usuario unUsuario) {
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unUsuario.eventos.head.nombre
	}

}

class SuperAmigo extends ObserverCrearEvento {

	new(String nom) {
		super(nom)
	}

	override void ejecutar(Usuario unUsuario) {
		unUsuario.amigos.forEach [ amigo |
			if (amigo.amigos.contains(unUsuario)) {
				var String mensaje
				mensaje = this.generarTexto(unUsuario)
				val MailInterno mail = new MailInterno(mensaje, unUsuario)
				amigo.recibirMensajeDeMail(mail)
			}
		]
	}

	def String generarTexto(Usuario unUsuario) {
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unUsuario.eventos.head.nombre
	}

}

class ViveCerca extends ObserverCrearEvento {

	MailService mailService
	Mail email
	Evento unEvento

	new(String nom, MailService sender,Evento _unEvento) {
		super(nom)
		mailService = sender
		unEvento = _unEvento
		
	}

	override ejecutar(Usuario unUsuario) {
			
		/*Enviar un mail y una notificación a contactos que viven cerca del evento.
		 *  Se entiende por contacto tanto a los amigos del  creador como a quienes
		 *  lo tienen en su lista de amigos. 
		 */
		unUsuario.amigos.forEach [ amigo |
		  	    amigo.amigos.contains(unUsuario)
		  		amigo.viveCerca(unEvento)
		 		var String mensaje
		    	mensaje = this.generarTexto(unUsuario)
		  		val MailInterno mail = new MailInterno(mensaje,unUsuario) 
		  		amigo.recibirMensajeDeMail(mail)
		  		mailService.sendMail(email)	
		 ]	 
		
	}

	def String generarTexto(Usuario unUsuario) {
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unUsuario.eventos.head.nombre
	}

}

class ViveCercaEventoAbierto extends ObserverCrearEvento {
    
    EventoAbierto unEvento
	
	new(String nom,EventoAbierto _unEvento) {
		super(nom)
		unEvento = _unEvento
	}

	override ejecutar(Usuario unUsuario) {
			
		/*Notificar a todos los usuarios que viven cerca del evento. Solo aplicable a eventos abiertos.  */
		  		unUsuario.viveCerca(unEvento)
		 		var String mensaje
		    	mensaje = this.generarTexto(unUsuario)
		  		val MailInterno mail = new MailInterno(mensaje,unUsuario) 
		  		unUsuario.recibirMensajeDeMail(mail)		
	}

	def String generarTexto(Usuario unUsuario) {
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unUsuario.eventos.head.nombre
	}

}

class FanDeUnArtista extends ObserverCrearEvento {
  
    MailService mailService
	Mail email
	EventoAbierto unEvento
	
	new(String nom, MailService sender,EventoAbierto _unEvento) {
		super(nom)
		mailService = sender
		unEvento = _unEvento
	}

	override ejecutar(Usuario unUsuario) {
			
		/*Enviar un mail a Fans de un artista que participa del evento. 
		 * Para esto en los eventos abiertos se podrá definir el listado de artistas que participarán del mismo. 
		 * Además los usuarios indicarán de qué artistas son fans
		 */
		unUsuario.artistas.exists[artista|unEvento.artistas.contains(artista.nombre)]
		mailService.sendMail(email)
	}
	


}

