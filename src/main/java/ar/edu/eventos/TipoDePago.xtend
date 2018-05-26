package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException

interface TipoDePago {
	def void pagarEntrada(Usuario unUsuario,Entrada entrada)
	def void methodForUser(Usuario unUsuario,Entrada entrada){
		validarDineroSuficiente(unUsuario,entrada)
		unUsuario.sumarDinero(-entrada.valorDeLaEntrada)
	}
	def void validarDineroSuficiente(Usuario unUsuario,Entrada entrada)
}
  
class Tarjeta implements TipoDePago{
	Usuario nombreDelUsuario

	override pagarEntrada(Usuario unUsuario,Entrada entrada){
		validarDatosDeLaTarjeta(unUsuario)
		methodForUser(unUsuario,entrada)
		estadoDeLaTransaccion()
	}
	def validarDatosDeLaTarjeta(Usuario unUsuario) {
		if(unUsuario.nombre != nombreDelUsuario){
			throw new BusinessException ("No sos el Propietario De la tarjeta ")
		}
	// servicio externo devuelve el los datos del Usuario y los corrobora MOCKEAR EN LOS TEST
	}
	def importeDeLaTransferencia(Usuario usuario) {
		1// servicio externo devuelve el impoerte MOCKEAR EN LOS TEST
	}
	def estadoDeLaTransaccion() {
		// servicio externo devuelve el estado de la transaccion MOCKEAR EN LOS TEST
	}
	override validarDineroSuficiente(Usuario unUsuario,Entrada entrada) {
		if(importeDeLaTransferencia(unUsuario) < entrada.valorDeLaEntrada){
			throw new BusinessException ("El Dinero no es Suficiente para Pagar La Entrada ")
		}
	}
}

class Efectivo implements TipoDePago{
	
	override pagarEntrada(Usuario unUsuario,Entrada entrada){
		methodForUser(unUsuario,entrada)
	}
	
	override validarDineroSuficiente(Usuario usuario, Entrada entrada) {
		if(usuario.plataQueTengo < entrada.valorDeLaEntrada){
			throw new BusinessException ("El Dinero no es Suficiente para Pagar La Entrada ")
		}
	}
	
}