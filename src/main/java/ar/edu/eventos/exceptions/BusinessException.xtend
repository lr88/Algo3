package ar.edu.eventos.exceptions

import ar.edu.eventos.Json.Entidad
import ar.edu.eventos.Repositorios.RepoGenerico

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
	
	public def validarLaExistenciaID(Entidad objeto, RepoGenerico generico) {
		if (generico.existeElid(objeto)) {
			throw new BusinessException("El elemento ya existe en el Repositorio")
		}
	}
	def validarLaNoExistenciaID(Entidad objeto, RepoGenerico generico) {
		if (!generico.existeElid(objeto)) {
			throw new BusinessException("El elemento no existe en el Repositorio")
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