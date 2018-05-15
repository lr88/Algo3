package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class RepoUsuario extends RepoGenerico<Usuario>{

	override List<Usuario> search(String buscar) {
	  elementos.filter[usuario|usuario.nombre == usuario.nombre.indexOf(buscar) || usuario.apellido == usuario.apellido.indexOf(buscar)|| usuario.nombreDeUsuario.equals(buscar) ].toList 
	}

	override update(Usuario object) {
		object.validar()
		validarLaNoExistencia(object)
		var usuario = searchById(object.id)
		usuario.nombreDeUsuario = object.nombreDeUsuario
		usuario.nombre = object.nombre
		usuario.apellido = object.apellido
		usuario.fechaDeNacimiento = object.fechaDeNacimiento
		usuario.email = object.email
		usuario.direccion = object.direccion
	}
	
	def void loadUser(Usuario usuario) {
		if(elementos.map(elem | elem.apellido+elem.nombre).contains(usuario.apellido+usuario.nombre)){
			update(usuario)
		}
		else{
			create(usuario)
		}
	}
}