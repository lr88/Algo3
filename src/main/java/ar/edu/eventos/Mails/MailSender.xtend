package ar.edu.eventos.Mails

import ar.edu.eventos.Usuario.Usuario

interface MailSender {
	
	def void sendMail(Usuario unUsuario, MailInterno interno)
	

}