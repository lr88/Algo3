package ar.edu.eventos.Mails

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.Usuario.Usuario

@Accessors
class MailInterno {
	
	var String mensaje
	var Usuario unUsuario
	
	new(String _mensaje,Usuario _unUsuario) {
		mensaje = _mensaje
		unUsuario = _unUsuario
		
	}
	

}