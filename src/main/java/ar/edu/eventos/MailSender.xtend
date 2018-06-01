package ar.edu.eventos

interface MailSender {
	
	def void sendMail(Usuario unUsuario, MailInterno interno)
	

}