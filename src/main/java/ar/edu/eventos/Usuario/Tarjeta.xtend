package ar.edu.eventos.Usuario

import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.ccService.CreditCardService
import org.uqbar.ccService.CreditCard
import ar.edu.eventos.Eventos.Entrada

@Accessors
class Tarjeta {
	@Accessors CreditCardService ccService
	@Accessors CreditCard datos
	
	def void pagarEntrada(Entrada entrada){
		var response = ccService.pay(datos,entrada.valorDeLaEntrada)
		if (response.statusCode == 1 || response.statusCode == 2) {
			throw new BusinessException(response.statusCode + response.statusMessage)
		}
	}

}
