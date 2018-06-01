package ar.edu.eventos.Usuario

import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.ccService.CreditCardService
import org.uqbar.ccService.CreditCard
import ar.edu.eventos.Eventos.Entrada

@Accessors
class Tarjeta {
	@Accessors CreditCardService card
	@Accessors CreditCard datos
	
	def void pagarEntrada(Entrada entrada){
		var respons = card.pay(datos,entrada.valorDeLaEntrada)
		if (respons.statusCode == 1 || respons.statusCode == 2) {
			throw new BusinessException(respons.statusCode + respons.statusMessage)
		}
	}

}
