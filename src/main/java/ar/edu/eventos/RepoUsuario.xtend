package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class RepoUsuario extends RepoGenerico<Usuario>{

	override List<Usuario> search(String buscar) {
	  elementos.filter[usuario|usuario.nombre == usuario.nombre.indexOf(buscar) || usuario.apellido == usuario.apellido.indexOf(buscar)|| usuario.nombreDeUsuario.equals(buscar) ].toList 
	}

	def void loadUser(Usuario usuario) {
		if(elementos.map(elem | elem.apellido+elem.nombre).contains(usuario.apellido+usuario.nombre)){
			update(usuario)
		}
		else{
			create(usuario)
		}
	}
	
	override updateAll() {
		var EntityJsonParser servJson = new EntityJsonParser
		/*servJson.actualizarRepoUsuarios.forEach [ x |
			if (this.validarExistencia(x)) {
				this.actualizarDatos(this.search(x.nombre).head, x)
			} else {
				this.create(x)
			}
		]*/
	}
	
	override actualizarDatos(Usuario usuarioViejo, Usuario usuarioNuevo) {
		usuarioViejo=>[
		usuarioViejo.nombreDeUsuario = usuarioNuevo.nombreDeUsuario
		usuarioViejo.nombre = usuarioNuevo.nombre
		usuarioViejo.apellido = usuarioNuevo.apellido
		usuarioViejo.fechaDeNacimiento = usuarioNuevo.fechaDeNacimiento
		usuarioViejo.email = usuarioNuevo.email
		usuarioViejo.direccion = usuarioNuevo.direccion
   ]
	}
	
}