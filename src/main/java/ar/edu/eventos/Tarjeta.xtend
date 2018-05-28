package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import org.uqbar.ccService.CCResponse
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.ccService.CreditCardService
import org.uqbar.ccService.CreditCard

@Accessors
class Tarjeta {
	CreditCardService card
	CreditCard datos
	CCResponse CCR
	
	def void pagarEntrada(Usuario unUsuario, Entrada entrada) {
		validarDineroSuficiente(unUsuario, entrada)
		creditCardService(entrada)
		unUsuario.sumarDinero(-entrada.valorDeLaEntrada)
	}
	
	def code (Entrada entrada){
		card.pay(datos,entrada.valorDeLaEntrada)
	}
	
	def creditCardService(Entrada entrada) {
		if (code(entrada).statusCode == 0) {
			println(code(entrada).statusCode + code(entrada).statusMessage)
		}
		if (code(entrada).statusCode == 1 || code(entrada).statusCode == 2) {
			println(code(entrada).statusCode + code(entrada).statusMessage)
			throw new BusinessException(code(entrada).statusCode + code(entrada).statusMessage)
		}
	}

	def void validarDineroSuficiente(Usuario unUsuario, Entrada entrada) {
		if (unUsuario.plataQueTengo < entrada.valorDeLaEntrada) {
			throw new BusinessException("El Dinero no es Suficiente para Pagar La Entrada ")
		}
	}
}
