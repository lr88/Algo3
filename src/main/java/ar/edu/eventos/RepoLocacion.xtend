package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepoLocacion extends RepoGenerico<Locacion> {
	int proximoId = 0
	
	/*El valor de búsqueda debe coincidir parcialmente con la descripción */
	override search(String value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override update(Locacion object) {
		object.soyValido()
		validarExistencia(object)
		var locacion = searchById(object.id)
		locacion.nombreDeLaLocacion = object.nombreDeLaLocacion
		locacion.ubicacion = object.ubicacion
	}
	
	
	override Locacion searchById(int id) {
		elementos.findFirst[locacion|locacion.id == id]
	}
	
	override create(Locacion object) {
		object.soyValido()
		validarLaNoExistencia(object)
		elementos.add(object)
		object.setId(proximoId)
		proximoId ++
		
	}
	
}