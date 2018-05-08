package ar.edu.eventos

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.exceptions.BusinessException

@Accessors
abstract class RepoGenerico<T extends Entidad> {

	List<T> elementos = newArrayList()
	var EntityJsonParser servJson = new EntityJsonParser()
	int proximoId = 0

	abstract def void update(T object)

	abstract def List<T> search(String value)

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
