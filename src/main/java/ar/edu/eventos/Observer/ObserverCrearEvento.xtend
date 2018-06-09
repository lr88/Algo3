package ar.edu.eventos.Observer

import ar.edu.eventos.Eventos.Evento
import ar.edu.eventos.Repositorios.RepoUsuario
import ar.edu.eventos.Usuario.Usuario
import java.util.HashSet
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.mailService.Mail
import org.uqbar.mailService.MailService

@Accessors
abstract class ObserverCrearEvento {
	var Set <Usuario> contactosMails = new HashSet
	var Set <Usuario> contactosMensajes = new HashSet
	var RepoUsuario repoUsuario
	var Mail mail
	var MailService mailService
	
	new (MailService unMailService, Mail unMail){
		mailService = unMailService
		mail = unMail
	}

	def void ejecutar(Usuario unUsuario,Evento unEvento){
		contactosMails = listaDeContactosParaMandarMail(unUsuario,unEvento)
		contactosMensajes = listaDeContactosParaMandarMensaje(unUsuario,unEvento)
		
		contactosMails.remove(unUsuario)
		contactosMensajes.remove(unUsuario)
		
		if(contactosMails.size > 0){
			contactosMails.forEach[returnMailServis]
		}
		if(contactosMensajes.size > 0){
			contactosMensajes.forEach[amigo| amigo.recibirMensaje(generarTexto(unUsuario,unEvento))]
		}
	}
	
	def returnMailServis(){
		mailService.sendMail(mail)
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
		contactosMails
	}
	
	override Set <Usuario>  listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		contactosMensajes = unUsuario.amigos
		contactosMensajes
	}
	
}

class SuperAmigo extends ObserverCrearEvento {

	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}
	
	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
		contactosMensajes
	}
	
	override  Set <Usuario> listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		repoUsuario.elementos.filter[elem | elem.amigos.contains(unUsuario)].toSet
	}
	
}

class ViveCerca extends ObserverCrearEvento {

	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}

//Se entiende por contacto tanto a los amigos del 
// creador como a quienes lo tienen en su lista de amigos. 

	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
		listaDeContactosAmigosYCercanos(unUsuario, unEvento).toSet
		}
	
	override  Set <Usuario> listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		listaDeContactosAmigosYCercanos(unUsuario, unEvento).toSet
	}
	
	def listaDeContactosAmigosYCercanos(Usuario unUsuario, Evento unEvento){
		(repoUsuario.elementos.filter[elem | elem.amigos.contains(unUsuario)&& elem.viveCerca(unEvento)]+ unUsuario.amigos).toSet
		
	}
	
}

class ViveCercaEventoAbierto extends ObserverCrearEvento {
    	
	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}
		
	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
		contactosMails
	}
	
	override Set <Usuario> listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		repoUsuario.elementos.filter[elem |  elem.viveCerca(unEvento)].toSet
	}
	
}

class FanDeUnArtista extends ObserverCrearEvento {
  
	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}
	
	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
		contactosMails
//	Enviar un mail a los Fans de un artista que participa del evento. 
//	repoUsuario.elementos.filter[elem | elem.artistas.exists[arti | arti.contains(evento.artistas)]].toSet
	}
	
	override Set <Usuario> listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		contactosMensajes
	}

}

