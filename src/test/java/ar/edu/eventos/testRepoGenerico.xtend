package ar.edu.eventos

import java.util.Map
import org.junit.Assert
import org.junit.Test
import org.uqbar.xtrest.json.JSONUtils

class testRepoGenerico {

	extension JSONUtils = new JSONUtils
	
	String jsonPersonas = '''
		   {  
		      "nombreUsuario":"lucas_capo",
		      "nombreApellido":"Lucas Lopez",
		      "email":"lucas_93@hotmail.com",
		      "fechaNacimiento":"15/01/1993"
		    }
	'''

	@Test
	def void asd() {
		val Map<String, String> propiedades = jsonPersonas.properties
		Assert.assertEquals("lucas_capo", propiedades.get("nombreUsuario"))
		Assert.assertEquals("Lucas Lopez", propiedades.get("nombreApellido"))
	}

}
