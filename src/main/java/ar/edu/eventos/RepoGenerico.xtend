package ar.edu.eventos

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.exceptions.BusinessException

@Accessors
abstract class RepoGenerico <T extends objetoT> {
	List <T> elementos = newArrayList() 
	
	abstract def void create(T object)

	def boolean existeElid (T object){
		elementos.exists[elemento|elemento.id == object.id]
	}
	
	def validarExistencia (T object){
		if (existeElid (object)){
			throw new BusinessException("El elemento ya existe en el Repositorio")
		}
		true
	}
	
	def validarLaNoExistencia (T object){
		if (!existeElid (object)){
			throw new BusinessException("El elemento no existe en el Repositorio")
		}
		true
	}
	def void delete(T object){
		elementos.remove(object)
	}
	
    abstract def void update (T object)
    abstract def T searchById(int id)
    abstract def List<T> search(String value)
	
}




