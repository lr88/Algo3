package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Entrada {

	var int valorDeLAEntrada
	Usuario un_Usuario

	new(Usuario unUsuario, int unValorDeLaEntrada) {
		un_Usuario = unUsuario
		valorDeLAEntrada = unValorDeLaEntrada
	}

	def devolverEntrada() {
		/*debuelve el dinero al dueño */
	}

}
