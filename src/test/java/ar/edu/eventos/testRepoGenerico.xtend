package ar.edu.eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

import static org.mockito.Mockito.*

class Asd {

	def hola() {
		"asdasdasdasdsad"
	}
}

class testRepoGenerico {

	EntityJsonParser ServicioExternoJson

	var String coco = "coco estya feliz"
	var Locacion miCasa
	var RepoUsuario RepoUsuario
	var RepoServicios RepoServicios
	var RepoLocacion RepoLocacion
	var String JSonUsuarios
	var String JSonLocaciones
	var String JSonServicios

	@Before
	def void init() {
		
		ServicioExternoJson = new EntityJsonParser
		ServicioExternoJson.repositorioUsuarios = new RepoUsuario
		ServicioExternoJson.repositorioServicios = new RepoServicios
		ServicioExternoJson.repositorioLocacion = new RepoLocacion
		RepoUsuario = ServicioExternoJson.repositorioUsuarios
		RepoServicios = ServicioExternoJson.repositorioServicios
		RepoLocacion = ServicioExternoJson.repositorioLocacion

		miCasa = new Locacion() => [
			nombreDeLaLocacion = "asd"
			ubicacion = new Point(1.0, 2.0)
			validar()
		]

		JSonUsuarios = '[  
   {  
      "nombreUsuario":"lucas_capo",
      "nombre":"Lucas",
	  "apellido":"Lopez",
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
      "nombre":"Martín",
	  "apellido":"Varela",
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

		JSonLocaciones = '[{
		\"x\":-34.603759,
		\"y\":-58.381586,
		\"nombre\":\"Salón El Abierto\"
		},
		{
		\"x\":-34.572224,
		\"y\":-58.535651,
		\"nombre\":\"Estadio Obras\"
		}]'

		JSonServicios = '[  
   {  
      "descripcion":"Catering Food Party",
      "tarifaServicio":{  
         "tipo":"TF",
         "valor":5000.00
      },
      "tarifaTraslado":30.00,
      "ubicacion":{  
         "x":-34.572224,
         "y":58.535651
      }
   }
]
'

	}

	@Test
	def testearUsuarioJson() {
		ServicioExternoJson.actualizarRepoUsuarios(JSonUsuarios)
		Assert.assertEquals(2, RepoUsuario.elementos.size)
		Assert.assertTrue(RepoUsuario.elementos.get(0).apellido == "Lopez")

	}

	@Test
	def testearLocacionJson() {
		ServicioExternoJson.actualizarRepoLocacion(JSonLocaciones)
		Assert.assertEquals(2, RepoLocacion.elementos.size)
		Assert.assertTrue(RepoLocacion.elementos.get(0).nombreDeLaLocacion == "Salón El Abierto")

	}

	@Test
	def testearServicioJson() {
		ServicioExternoJson.actualizarRepoServicio(JSonServicios)
		Assert.assertEquals(1, RepoServicios.elementos.size)
		
		
		
		Assert.assertTrue(RepoServicios.elementos.get(0).descripcion == "Catering Food Party")

	}

	@Test
	def void cocoestafeliz() {
		var rerer = mock(typeof(Asd))
		when(rerer.hola()).thenReturn(coco)
		print(rerer.hola())
		Assert.assertEquals(0,0,0)
	}
	
	@Test
	def void testSePuedeMockearUnServicioJson() {
		var locacion =  mock(typeof(RepoLocacion))
		when(locacion.updateAll()).thenReturn(JSonLocaciones)
		Assert.assertEquals(locacion.updateAll(),JSonLocaciones)
	}

}
