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
	var Set <Usuario> contactos = new HashSet ()
	var RepoUsuario repoUsuario
	var Mail mail
	var MailService mailService
	
	new (MailService unMailService, Mail unMail){
		mailService = unMailService
		mail = unMail
	}

	def void ejecutar(Usuario unUsuario,Evento unEvento){
		print(listaDeContactosParaMandarMail(unUsuario,unEvento))
		print(listaDeContactosParaMandarMensaje(unUsuario,unEvento))
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
	
	override Set <Usuario>  listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		contactos
	}
	
}

class SuperAmigo extends ObserverCrearEvento {

	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}
	
	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
		repoUsuario.elementos.filter[elem | elem.amigos.contains(unUsuario)].toSet
	}
	
	override  Set <Usuario> listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		contactos
	}
	
}

class ViveCerca extends ObserverCrearEvento {

	Evento unEvento
	
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
		repoUsuario.elementos.filter[elem | elem.amigos.contains(unUsuario)&& elem.viveCerca(unEvento)].toSet
		+ unUsuario.amigos
	}
	
}

class ViveCercaEventoAbierto extends ObserverCrearEvento {
    	
	new(MailService unMailService, Mail unMail) {
		super(unMailService, unMail)
	}
		
	override Set <Usuario> listaDeContactosParaMandarMail(Usuario unUsuario,Evento unEvento) {
		contactos
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
//	Enviar un mail a los Fans de un artista que participa del evento. 
//	repoUsuario.elementos.filter[elem | elem.artistas.exists[arti | arti.contains(evento.artistas)]].toSet
	
	}
	
	override Set <Usuario> listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		contactos
	}

}

