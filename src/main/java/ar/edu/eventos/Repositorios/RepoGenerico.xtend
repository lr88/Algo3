package ar.edu.eventos.Repositorios

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.exceptions.Validar
import org.uqbar.updateService.UpdateService
import ar.edu.eventos.Json.Entidad
import ar.edu.eventos.Json.EntityJsonParser

@Accessors
abstract class RepoGenerico<T extends Entidad> {
	
	UpdateService update
		
	Validar validaciones = new Validar
	
	protected List<T> elementos = newArrayList()
	
	var EntityJsonParser servJson 
	
	protected int proximoId = 0

	protected abstract def List<T> search(String value)

	protected abstract def void updateAll()

	protected abstract def void actualizarDatos(T t, T t2)

	def void update(T objectViejo,T objectNuevo) {
		objectNuevo.validar()
		this.actualizarDatos(objectViejo, objectNuevo)
	}

	def void create(T object) {
		object.validar()
		validaciones.validarLaExistenciaID(object, this)
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

	public def boolean existeElid(T object) {
		elementos.exists[elemento|elemento.id == object.id]
	}

}
