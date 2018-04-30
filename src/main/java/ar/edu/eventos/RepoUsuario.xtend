package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class RepoUsuario extends RepoGenerico<Usuario>{
	int proximoId = 0
	
	override List<Usuario> search(String buscar) {
	  elementos.filter[usuario|usuario.nombre == usuario.nombre.indexOf(buscar) || usuario.apellido == usuario.apellido.indexOf(buscar)|| usuario.nombreDeUsuario.equals(buscar) ].toList 
	
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