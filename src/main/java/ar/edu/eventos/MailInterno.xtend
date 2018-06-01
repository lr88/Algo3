package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class MailInterno {
	
	var String mensaje
	var Usuario emisor

	new(String _mensaje, Usuario _emisor) {
		mensaje = _mensaje
		emisor = _emisor
	}
	

}