package ar.edu.eventos

import java.util.List
import ar.edu.eventos.exceptions.BusinessException

abstract class RepoGenerico <T extends objetoT> {
	
	List <T> elementos = newArrayList() 
	int proximoId = 0
 	
	
	def void create(T object){
		object.soyValido()
		validarLaNoExistencia(object)
		elementos.add(object)
		object.setId(proximoId)
		proximoId ++
	}

	def boolean existeElid (T object){
		elementos.exists[elemento|elemento.id==object.id]
	}
	
	def validarExistencia (T object){
		if (existeElid (object)){
			throw new BusinessException("El elemento ya existe en el Repositorio")
		}
	}
	
	def validarLaNoExistencia (T object){
		if (!existeElid (object)){
			throw new BusinessException("El elemento no existe en el Repositorio")
		}
	}
	def void delete(T object){
		elementos.remove(object)
	}
	
	def void update (T object){
		object.soyValido
		validarExistencia(object)
		modificarObjeto(object)
	}
	
	def T searchById(int id){
		elementos.get(id)
	}
	/* hay que hacerlo abstract
	def modificarObjeto(T object){
		var T objetoNuestro = searchById(object.id)
		objetoNuestro.modificarObjeto(object)
	}*/
	
	
	
/*  

●	void update(T object):
* En caso de que tenga errores de validación no debe actualizar. 
* De no existir el objeto buscado, es decir, un objeto con ese id, se debe lanzar una excepción. 
 Modifica el objeto dentro de la colección. 
 * 
●	T searchById(int id): Retorna el objeto cuyo id sea el recibido como parámetro.

●	List<T> search(String value): Devuelve los objetos que coincidan con la búsqueda de acuerdo a los siguientes criterios: 

●	Locación: El valor de búsqueda debe coincidir parcialmente con la descripción.

●	Usuario: El valor de búsqueda debe coincidir parcialmente con el nombre y/o apellido, o exactamente con el nombre de usuario. 

●	Servicio:  El valor de búsqueda debe coincidir con el inicio de la descripción.  


	 
	 */
	
	
}


