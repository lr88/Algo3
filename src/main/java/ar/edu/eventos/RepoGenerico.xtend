package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class RepoGenerico<T extends Entidad> {
	
	protected List<T> elementos = newArrayList()
	protected var EntityJsonParser servJson = new EntityJsonParser()
	protected int proximoId = 0
	protected String stringUser

	protected abstract def List<T> search(String value)

	protected abstract def String updateAll()
	
    protected abstract def void actualizarDatos(T t, T t2)
    
    protected def void update(T object){
    		object.validar()
			validarLaNoExistencia(object)
			this.actualizarDatos(searchById(object.id), object)	
	}
	
	protected def void create(T object) {
		object.validar()
		validarExistencia(object)
		elementos.add(object)
		proximoId++
		object.setId(proximoId)
	}

	protected def void delete(T object) {
		elementos.remove(object)
	}

	protected def T searchById(int id) {
		elementos.findFirst[elem|elem.id == id]
	}

	protected def boolean existeElid(T object) {
		elementos.exists[elemento|elemento.id == object.id]
	}

	protected def void validarExistencia(T object) {
		if (existeElid(object)) {
			throw new BusinessException("El elemento ya existe en el Repositorio")
		}
	}

	protected def void validarLaNoExistencia(T object) {
		if (!existeElid(object)) {
			throw new BusinessException("El elemento no existe en el Repositorio")
		}
	}

}
