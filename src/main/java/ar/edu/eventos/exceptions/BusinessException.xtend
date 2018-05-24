package ar.edu.eventos.exceptions

class BusinessException extends RuntimeException {
	
	new(String msg) {
		super(msg)
	}
}

class Validar {
	
	def validarObjetoNoNulo(Object objeto, String nombrePropiedad) {
		if(objeto === null){
			throw new BusinessException("No podes crear un Objeto sin " + nombrePropiedad)
		}
	}
	def validarStringNoNulo(String unString,String nombrePropiedad) {
		if(unString.length === 0){
			throw new BusinessException("No podes crear un Objeto sin " + nombrePropiedad)
		}
	}
	
	def validarStringYObjetoNoNulo(Object objeto,String unString,String nombrePropiedad) {
		if(objeto === null){
			throw new BusinessException("No podes crear un Objeto sin " + nombrePropiedad)
		}
		if(unString.length === 0){
			throw new BusinessException("No podes crear un Objeto sin " + nombrePropiedad)
		}
	}
	
	
}