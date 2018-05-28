package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import org.uqbar.ccService.CCResponse
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.ccService.CreditCardService
import org.uqbar.ccService.CreditCard

@Accessors
class Tarjeta {
	
	CreditCardService TCCS
	CreditCard TCC = new CreditCard
	CCResponse TCCR = TCCS.pay(TCC,0)

	def pagarEntrada(Usuario unUsuario, Entrada entrada) {
		print("hola")
		validarDineroSuficiente(unUsuario, entrada)
		mensajeDeRespuesta()
		unUsuario.sumarDinero(-entrada.valorDeLaEntrada)
	}
	
	def CCResponse codigosDeLaTarjeta(){
		return TCCR
	}

	def codigoDeEstado(){
		codigosDeLaTarjeta().statusCode
	}
	
	def mensajeDeRespuesta() {
		if (codigoDeEstado === 0) {
			print(codigosDeLaTarjeta().statusCode + codigosDeLaTarjeta().statusMessage)
		}
		if (codigoDeEstado === 1) {
			throw new BusinessException(codigosDeLaTarjeta().statusCode + codigosDeLaTarjeta().statusMessage)
		}
		if (codigoDeEstado === 2) {
			throw new BusinessException(codigosDeLaTarjeta().statusCode + codigosDeLaTarjeta().statusMessage)
		}
	}

	def validarDineroSuficiente(Usuario unUsuario, Entrada entrada) {
		if (unUsuario.plataQueTengo < entrada.valorDeLaEntrada) {
			throw new BusinessException("El Dinero no es Suficiente para Pagar La Entrada ")
		}
	}
}
