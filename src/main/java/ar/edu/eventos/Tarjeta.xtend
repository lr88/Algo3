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
		print("asdasd")
		validarDineroSuficiente(unUsuario, entrada)
		creditCardService()
		unUsuario.sumarDinero(-entrada.valorDeLaEntrada)
	}
	
	def setCCR (){
		CCR = card.pay(datos,50)
	}
	
	
	def code (){
		CCR
	}
	
	def creditCardService() {
		if (code.statusCode == 0) {
			print(code.statusCode + code.statusMessage)
		}
		if (code.statusCode == 1) {
			throw new BusinessException(code.statusCode + code.statusMessage)
		}
		if (code.statusCode == 2) {
			throw new BusinessException(code.statusCode + code.statusMessage)
		}
		1
	}

	def void validarDineroSuficiente(Usuario unUsuario, Entrada entrada) {
		if (unUsuario.plataQueTengo < entrada.valorDeLaEntrada) {
			throw new BusinessException("El Dinero no es Suficiente para Pagar La Entrada ")
		}
	}
}
