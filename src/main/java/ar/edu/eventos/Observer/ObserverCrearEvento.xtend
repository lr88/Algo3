package ar.edu.eventos.Observer

import ar.edu.eventos.Eventos.Evento
import ar.edu.eventos.Eventos.EventoAbierto
import ar.edu.eventos.Repositorios.RepoUsuario
import ar.edu.eventos.Usuario.Usuario
import java.util.HashSet
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.mailService.Mail
import org.uqbar.mailService.MailService

@Accessors
abstract class ObserverCrearEvento {
	var Set<Usuario> contactos = new HashSet
	var RepoUsuario repoUsuario
	

	def void ejecutar(Usuario unUsuario, Evento unEvento)

	def String generarTexto(Usuario unUsuario, Evento unEvento) {
		"el usuario " + unUsuario.nombre + " ha creado el evento " + unEvento.nombre
	}
}

@Accessors
class AmigoDelCreador extends ObserverCrearEvento {

	override void ejecutar(Usuario unUsuario, Evento unEvento) {
		contactos = listaDeContactosParaMandarMensaje(unUsuario, unEvento)
		contactos.remove(unUsuario)
		if (contactos.size > 0) {
			contactos.forEach[amigo|amigo.recibirMensaje(generarTexto(unUsuario, unEvento))]
		}
	}

	def Set<Usuario> listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		unUsuario.amigos
	}

}

@Accessors
class MiAmigoEsElCreador extends ObserverCrearEvento {

	override void ejecutar(Usuario unUsuario, Evento unEvento) {
		contactos = listaDeContactosParaMandarMensaje(unUsuario, unEvento)
		contactos.remove(unUsuario)
		if (contactos.size > 0) {
			contactos.forEach[amigo|amigo.recibirMensaje(generarTexto(unUsuario, unEvento))]
		}
	}

	def Set<Usuario> listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		repoUsuario.elementos.filter[elem|elem.amigos.contains(unUsuario)].toSet
	}

}

@Accessors
class ViveCerca extends ObserverCrearEvento {

	var Mail mail
	var MailService mailService
	
	new (MailService unMailService, Mail unMail){
		mailService = unMailService
		mail = unMail
	}

	override void ejecutar(Usuario unUsuario, Evento unEvento) {
		contactos = listaDeContactosAmigosYCercanos(unUsuario, unEvento)
		contactos.remove(unUsuario)

		if (contactos.size > 0) {
			contactos.forEach[amigo|amigo.recibirMensaje(generarTexto(unUsuario, unEvento))]
			contactos.forEach[returnMailServis]
		}
	}

	def returnMailServis(){
		mailService.sendMail(mail)
	}

	def listaDeContactosAmigosYCercanos(Usuario unUsuario, Evento unEvento) {
		(repoUsuario.elementos.filter[elem|elem.amigos.contains(unUsuario) && elem.viveCerca(unEvento)] +
			unUsuario.amigos).toSet
	}
}

@Accessors
class ViveCercaEventoAbierto extends ObserverCrearEvento {

	override void ejecutar(Usuario unUsuario, Evento unEvento) {
		if(unEvento.soyDeTipoEventoAbierto){
		contactos = listaDeContactosParaMandarMensaje(unUsuario, unEvento)
		contactos.remove(unUsuario)

		if (contactos.size > 0) {
			contactos.forEach[amigo|amigo.recibirMensaje(generarTexto(unUsuario, unEvento))]
		}
	}}

	def Set<Usuario> listaDeContactosParaMandarMensaje(Usuario unUsuario, Evento unEvento) {
		repoUsuario.elementos.filter[elem|elem.viveCerca(unEvento)].toSet
	}
}

@Accessors
class FanDeUnArtista extends ObserverCrearEvento {

	var int i
	var Mail mail
	var MailService mailService

	new (MailService unMailService, Mail unMail){
		mailService = unMailService
		mail = unMail
	}

	override void ejecutar(Usuario unUsuario, Evento unEvento) {
		if(unEvento.soyDeTipoEventoAbierto){
		contactos = listaDeContactosParaMandarMail(unUsuario, unEvento as EventoAbierto)
		contactos.remove(unUsuario)

		if (contactos.size > 0) {
			contactos.forEach[returnMailServis]
		}
	}}
	
	def returnMailServis(){
		mailService.sendMail(mail)
	}

	def Set<Usuario> listaDeContactosParaMandarMail(Usuario unUsuario, EventoAbierto unEvento) {
		var Set <Usuario> listaDeContactos = new HashSet
		contactos = repoUsuario.elementos.toSet
		for (i=0 ; i < unEvento.artistas.size ; i++){
			listaDeContactos = contactos.filter[cont | cont.soyFanDeEsteArtista(unEvento.artistas.get(i)) == true].toSet
			contactos = (contactos + listaDeContactos).toSet
		}
		contactos
	}

}














