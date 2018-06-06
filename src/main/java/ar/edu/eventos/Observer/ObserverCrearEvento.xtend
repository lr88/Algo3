package ar.edu.eventos.Observer

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.Usuario.Usuario
import org.uqbar.mailService.MailService
import org.uqbar.mailService.Mail
import ar.edu.eventos.Eventos.EventoAbierto
import ar.edu.eventos.Eventos.Evento
import ar.edu.eventos.Repositorios.RepoUsuario

@Accessors
abstract class ObserverCrearEvento {
	
	var RepoUsuario repoUsuario
	
	def void ejecutar(Usuario unUsuario,Evento unEvento)
}

class AmigoDelCreador extends ObserverCrearEvento {

	override void ejecutar(Usuario unUsuario,Evento unEvento) {
		unUsuario.amigos.forEach[amigo|amigo.recibirMensaje(generarTexto(unUsuario,unEvento))]
	}

	def String generarTexto(Usuario unUsuario,Evento unEvento) {
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unEvento.nombre
	
	}

}

class SuperAmigo extends ObserverCrearEvento {

	override void ejecutar(Usuario unUsuario,Evento unEvento) {
		repoUsuario.elementos.forEach[elem | 
			if(elem.amigos.contains(unUsuario)){
			elem.recibirMensaje(generarTexto(unUsuario,unEvento))}]
	}

	def String generarTexto(Usuario unUsuario,Evento unEvento) {
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unEvento.nombre
	}

}

class ViveCerca extends ObserverCrearEvento {

	MailService mailService
	Mail mail 
	Evento unEvento

	new(MailService sender,Evento _unEvento) {
		mailService = sender
		unEvento = _unEvento
		
	}

	override ejecutar(Usuario unUsuario,Evento unEvento) {
			var listaDeContactos = unUsuario.amigos + repoUsuario.elementos.filter[elem | elem.amigos.contains(unUsuario)]
		/*Enviar un mail y una notificación a contactos que viven cerca del evento.
		 *  Se entiende por contacto tanto a los amigos del  creador como a quienes
		 *  lo tienen en su lista de amigos. 
		 */
		listaDeContactos.filter[user | user.viveCerca(unEvento)].forEach[elem | elem.recibirMensaje(generarTexto(unUsuario,unEvento)) mailService.sendMail(mail)]
	}
	
	def String generarTexto(Usuario unUsuario,Evento unEvento) {
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unEvento.nombre
	}

}

class ViveCercaEventoAbierto extends ObserverCrearEvento {
    
    EventoAbierto unEvento
	
	new(EventoAbierto _unEvento) {

		unEvento = _unEvento
	}

	override ejecutar(Usuario unUsuario,Evento unEvento) {
			
		/*Notificar a todos los usuarios que viven cerca del evento. Solo aplicable a eventos abiertos.  */
		  			
	}

	def String generarTexto(Usuario unUsuario) {
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unUsuario.eventos.head.nombre
	}

}

class FanDeUnArtista extends ObserverCrearEvento {
  
    MailService mailService
	Mail email
	EventoAbierto evento
	
	new(MailService sender,EventoAbierto _unEvento) {
		mailService = sender
		evento = _unEvento
	}

	override ejecutar(Usuario unUsuario,Evento unEvento) {
			
		/*Enviar un mail a los Fans de un artista que participa del evento. 
		 */
		repoUsuario.elementos.filter[elem | elem.artistas.exits[arti | arti.contains(evento.artista)]]
		mailService.sendMail(email)
	}

}

