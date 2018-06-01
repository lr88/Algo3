package ar.edu.eventos


import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Observable
//import org.uqbar.commons.model.annotations.Observable;

@Accessors
//@Observable
abstract class ObserverCrearEvento {
	
	String nombre

	def void ejecutar(Usuario unUsuario)

	new(String nom) {
		nombre = nom
	}

	override toString() {
		nombre
	}
}

class AmigosDelCreador extends ObserverCrearEvento {
	
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
		
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unUsuario.eventos
	}

}

class MeTienenDeAmigo extends ObserverCrearEvento{
	
	new(String nom) {
		super(nom)
	}
	
	override void ejecutar(Usuario unUsuario) {
			unUsuario.amigos.forEach [ amigo |
			if (amigo.amigos.contains(unUsuario)) {
				var String mensaje
				mensaje = this.generarTexto(unUsuario)
				val MailInterno mail = new MailInterno(mensaje,unUsuario) 
				amigo.recibirMensajeDeMail(mail)
			
			}
		]
			
	}

	def String generarTexto(Usuario unUsuario) {
		
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unUsuario.eventos
	}
	
}

class AmigosCercanos extends ObserverCrearEvento{
	
	MailSender mailSender
	
	new(String nom, MailSender sender) {
		super(nom)
		mailSender = sender
	}
	
	override ejecutar(Usuario unUsuario) {
		
		/*Enviar un mail y una notificación a contactos que viven cerca del evento.
		 *  Se entiende por contacto tanto a los amigos del  creador como a quienes
		 *  lo tienen en su lista de amigos. 
		 * unUsuario.amigos.forEach [ amigo |
			if (amigo.amigos.contains(unUsuario) ) {
				var String mensaje
				mensaje = this.generarTexto(unUsuario)
				val MailInterno mail = new MailInterno(mensaje,unUsuario) 
				amigo.recibirMensajeDeMail(mail)	
				mailSender.sendMail(amigo, mail)	
			}
		]*/
	}
	
	def String generarTexto(Usuario unUsuario) {
		
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unUsuario.eventos
	}
	
}