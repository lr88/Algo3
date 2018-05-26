package ar.edu.eventos

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.exceptions.Validar

@Accessors
abstract class RepoGenerico<T extends Entidad> {
	Validar validaciones = new Validar
	List<T> elementos = newArrayList()
	var EntityJsonParser servJson = new EntityJsonParser()
	int proximoId = 0

	abstract def List<T> search(String value)

	abstract def String updateAll()
	
    abstract def void actualizarDatos(T t, T t2)
    
    def void update(T object){
    		object.validar()
		validaciones.validarLaNoExistenciaID(object,this)
		this.actualizarDatos(searchById(object.id), object)	
	}
	
	def create(T object) {
		object.validar()
		validaciones.validarLaExistenciaID(object,this)
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
