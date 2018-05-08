package ar.edu.eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class testRepoGenerico {

	EntityJsonParser ServicioExternoJson
	RepoUsuario RepoUsuario
	RepoServicios RepoServicios
	RepoLocacion RepoLocacion
	String JSonUsuarios
	String JSonLocaciones
	String JSonServicios

	@Before
	def void init() {

		ServicioExternoJson = new EntityJsonParser
		RepoUsuario = new RepoUsuario
		RepoServicios = new RepoServicios
		RepoLocacion = new RepoLocacion

		JSonUsuarios = '[  
   {  
      "nombreUsuario":"lucas_capo",
      "nombreApellido":"Lucas Lopez",
      "email":"lucas_93@hotmail.com",
      "fechaNacimiento":"15/01/1993",
      "direccion":{  
         "calle":"25 de Mayo",
         "numero":3918,
         "localidad":"San Martín",
         "provincia":"Buenos Aires",
         "coordenadas":{  
            "x":-34.572224,
            "y":58.535651
         }
      }
   },
   {  
      "nombreUsuario":"martin1990",
      "nombreApellido":"Martín Varela",
      "email":"martinvarela90@yahoo.com",
      "fechaNacimiento":"18/11/1990",
      "direccion":{  
         "calle":"Av. Triunvirato",
         "numero":4065,
         "localidad":"CABA",
         "provincia":"",
         "coordenadas":{  
            "x":-33.582360,
            "y":60.516598
         }
      }
   }
]'


		JSonLocaciones = "[{
		\"x\":-34.603759,
		\"y\":-58.381586,
		\"nombre\":\"Salón El Abierto\"
		},
		{
		\"x\":-34.572224,
		\"y\":-58.535651,
		\"nombre\":\"Estadio Obras\"
		}]"

		JSonServicios = "[{
		\"descripcion\":\"Catering Food Party\",
		\"tipo\":\"TF\",
		\"valor\":5000.00,
		\"tarifaTraslado\":30.00,
		\"x\":-34.572224,
		\"y\":58.535651
		}]"

	}

	@Test
	def testearUsuarioJson() {
		var array = ServicioExternoJson.getValueArrayFromJsonResponse(JSonUsuarios)
		ServicioExternoJson.actualizarRepoUsuarios(array)
		Assert.assertEquals(2, ServicioExternoJson.getUsuarios.size)
		Assert.assertTrue(ServicioExternoJson.getUsuarios.get(0).apellido == "Lopez")

	}

	@Test
	def testearLocacionJson() {
		var array = ServicioExternoJson.getValueArrayFromJsonResponse(JSonLocaciones)
		ServicioExternoJson.actualizarRepoLocaciones(array)
		Assert.assertEquals(2, ServicioExternoJson.getLocaciones.size)
		Assert.assertTrue(ServicioExternoJson.getLocaciones.get(0).nombreDeLaLocacion == "Salón El Abierto")

	}

	@Test
	def testearServicioJson() {
		var array = ServicioExternoJson.getValueArrayFromJsonResponse(JSonServicios)
		ServicioExternoJson.actualizarRepoServicio(array)
		Assert.assertEquals(1, ServicioExternoJson.getServicio.size)
		Assert.assertTrue(ServicioExternoJson.getServicio.get(0).descripcion == "Catering Food Party")

	}

}
