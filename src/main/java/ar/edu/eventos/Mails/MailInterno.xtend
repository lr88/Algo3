package ar.edu.eventos.Mails

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.Usuario.Usuario

@Accessors
class MailInterno {
	
	var String mensaje
	var Usuario emisor

	new(String _mensaje, Usuario _emisor) {
		mensaje = _mensaje
		emisor = _emisor
	}
	

}