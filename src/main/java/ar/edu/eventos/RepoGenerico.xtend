package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class RepoGenerico<T extends Entidad> {
	
	List<T> elementos = newArrayList()
	var EntityJsonParser servJson = new EntityJsonParser()
	int proximoId = 0
	String stringUser

	abstract def List<T> search(String value)

	abstract def String updateAll()
	
    abstract def void actualizarDatos(T t, T t2)
    
    def void update(T object){
    		object.validar()
			validarLaNoExistencia(object)
			this.actualizarDatos(searchById(object.id), object)	
	}
	
	def create(T object) {
		object.validar()
		validarExistencia(object)
		elementos.add(object)
		proximoId++
		object.setId(proximoId)
	}

	def void delete(T object) {
		elementos.remove(object)
	}

	def T searchById(int id) {
		elementos.findFirst[elem|elem.id == id]
	}

	protected def boolean existeElid(T object) {
		elementos.exists[elemento|elemento.id == object.id]
	}

	protected def validarExistencia(T object) {
		if (existeElid(object)) {
			throw new BusinessException("El elemento ya existe en el Repositorio")
		}
	}

	protected def validarLaNoExistencia(T object) {
		if (!existeElid(object)) {
			throw new BusinessException("El elemento no existe en el Repositorio")
		}
	}

}
