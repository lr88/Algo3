package ar.edu.eventos.Observer

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.Usuario.Usuario
import org.uqbar.mailService.MailService
import org.uqbar.mailService.Mail
import ar.edu.eventos.Eventos.EventoAbierto
import ar.edu.eventos.Eventos.Evento
import ar.edu.eventos.Repositorios.RepoUsuario
import java.util.Set

@Accessors
abstract class ObserverCrearEvento {
	
	var RepoUsuario repoUsuario
	var Mail mail
	var MailService mailService
	
	new (MailService unMailService, Mail unMail){
		mailService = unMailService
		mail = unMail
	}
	
	
	def void ejecutar(Usuario unUsuario,Evento unEvento){
		listaDeContactosParaMandarMail(unUsuario,unEvento).forEach[mailService.sendMail(mail)]
		listaDeContactosParaMandarMensaje(unUsuario,unEvento).forEach[amigo|amigo.recibirMensaje(generarTexto(unUsuario,unEvento))]
	}
	
	def Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento)
	def Set <Usuario> listaDeContactosParaMandarMensaje(Usuario unUsuario,Evento unEvento)
	
	def String generarTexto(Usuario unUsuario,Evento unEvento) {
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unEvento.nombre
	}
}

class AmigoDelCreador extends ObserverCrearEvento {

	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}
	
	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
		unUsuario.amigos
	}
	
	override listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
	//
	}
	
}

class SuperAmigo extends ObserverCrearEvento {

	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}
	
	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
		repoUsuario.elementos.filter[elem | elem.amigos.contains(unUsuario)].toSet
	}
	
	override listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		//
	}
	
}

class ViveCerca extends ObserverCrearEvento {

	Evento unEvento
	
	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}

	

//Se entiende por contacto tanto a los amigos del  creador como a quienes lo tienen en su lista de amigos. 

	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
		//Enviar un mail a contactos que viven cerca del evento.
		 (unUsuario.amigos + repoUsuario.elementos.filter[elem | elem.amigos.contains(unUsuario)]).toSet
	}
	
	override listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		//Enviar una notificación a contactos que viven cerca del evento.
	}
	
}

class ViveCercaEventoAbierto extends ObserverCrearEvento {
    
    EventoAbierto unEvento
	
	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}
	
	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
		/*Notificar a todos los usuarios que viven cerca del evento. Solo aplicable a eventos abiertos.  */
	}
	
	override listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		//
	}
	
}

class FanDeUnArtista extends ObserverCrearEvento {
  
	EventoAbierto evento
	
	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}
	
	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
//	Enviar un mail a los Fans de un artista que participa del evento. 
//	repoUsuario.elementos.filter[elem | elem.artistas.exists[arti | arti.contains(evento.artistas)]].toSet
		
	}
	
	override listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		//
	}

}

