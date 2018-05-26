package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException

/* */
//public 
// private
//prctected
interface TipoDePago {
	public def void pagarEntrada(Usuario unUsuario, Entrada entrada)

	public def void methodForUser(Usuario unUsuario, Entrada entrada) {
		validarDineroSuficiente(unUsuario, entrada)
		unUsuario.sumarDinero(-entrada.valorDeLaEntrada)
	}

	public def void validarDineroSuficiente(Usuario unUsuario, Entrada entrada)
}

class Tarjeta implements TipoDePago {

	public override pagarEntrada(Usuario unUsuario, Entrada entrada) {
		validarDatosDeLaTarjeta(unUsuario)
		methodForUser(unUsuario, entrada)
		estadoDeLaTransaccion()
	}

	private def validarDatosDeLaTarjeta(Usuario unUsuario) {
		// servicio externo devuelve el los datos del Usuario y los corrobora MOCKEAR EN LOS TEST
	}

	private def importeDeLaTransferencia(Usuario usuario) {
		1 // servicio externo devuelve el impoerte MOCKEAR EN LOS TEST
	}

	private def estadoDeLaTransaccion() {
		// servicio externo devuelve el estado de la transaccion MOCKEAR EN LOS TEST
	}

	public override validarDineroSuficiente(Usuario unUsuario, Entrada entrada) {
		if (importeDeLaTransferencia(unUsuario) < entrada.valorDeLaEntrada) {
			throw new BusinessException("El Dinero no es Suficiente para Pagar La Entrada ")
		}
	}
}

class Efectivo implements TipoDePago {

	public override pagarEntrada(Usuario unUsuario, Entrada entrada) {
		methodForUser(unUsuario, entrada)
	}

	public override validarDineroSuficiente(Usuario usuario, Entrada entrada) {
		if (usuario.plataQueTengo < entrada.valorDeLaEntrada) {
			throw new BusinessException("El Dinero no es Suficiente para Pagar La Entrada ")
		}
	}

}
