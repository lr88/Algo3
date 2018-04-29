package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepoUsuario extends RepoGenerico<Usuario>{
	int proximoId = 0
	
	/*El valor de búsqueda debe coincidir 
	 * parcialmente con el nombre y/o apellido, o exactamente con el nombre de usuario.
	 */
	override search(String value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override update(Usuario object) {
		object.soyValido()
		validarExistencia(object)
		var usuario = searchById(object.id)
		usuario.nombreDeUsuario = object.nombreDeUsuario
		usuario.nombre = object.nombre
		usuario.apellido = object.apellido
		usuario.fechaDeNacimiento = object.fechaDeNacimiento
		usuario.email = object.email
		usuario.direccion = object.direccion
	}
		
	override Usuario searchById(int id) {
		elementos.findFirst[usuario|usuario.id == id]
	}
	
	override create(Usuario object) {
		object.soyValido()
		validarLaNoExistencia(object)
		elementos.add(object)
		object.setId(proximoId)
		proximoId ++
	}
	
}