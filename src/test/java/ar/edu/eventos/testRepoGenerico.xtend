package ar.edu.eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.updateService.UpdateService

import static org.mockito.Mockito.*

class testRepoGenerico {

	var EntityJsonParser EnJsPars
	var Locacion miCasa
	var String jSonUsuarios
	var String jSonLocaciones
	var String jSonServicios
	var UpdateService updServs
	var EntityJsonParser servJsonParser
	var RepoLocacion RL
	var RepoServicios RS
	var RepoUsuario RU

	@Before
	def void init() {

		updServs = new UpdateService
		
		RL = new RepoLocacion
		RS = new RepoServicios
		RU = new RepoUsuario

		EnJsPars = new EntityJsonParser => [

			repositorioLocacion = RL
			repositorioServicios = RS
			repositorioUsuarios = RU

			repositorioLocacion.servJson = servJsonParser
			repositorioServicios.servJson = servJsonParser
			repositorioUsuarios.servJson = servJsonParser

			repositorioLocacion.update = updServs
			repositorioServicios.update = updServs
			repositorioUsuarios.update = updServs
		]

		miCasa = new Locacion() => [
			nombreDeLaLocacion = "asd"
			ubicacion = new Point(1.0, 2.0)
			validar()
		]

		jSonUsuarios = '[  
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
   },{  
      "nombreUsuario":"Adrian58",
      "nombre":"Adrian",
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

		jSonLocaciones = '[{
		\"x\":-34.603759,
		\"y\":-58.381586,
		\"nombre\":\"Salón El Abierto\"
		},
		{
		\"x\":-34.572224,
		\"y\":-58.535651,
		\"nombre\":\"Estadio Obras\"
		}]'

		jSonServicios = '[  
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
		EnJsPars.actualizarRepoUsuarios(jSonUsuarios)
		Assert.assertEquals(3, EnJsPars.repositorioUsuarios.elementos.size)
		Assert.assertTrue(EnJsPars.repositorioUsuarios.elementos.get(0).apellido == "Lopez")
	}

	@Test
	def testearLocacionJson() {
		EnJsPars.actualizarRepoLocacion(jSonLocaciones)
		Assert.assertEquals(2, EnJsPars.repositorioLocacion.elementos.size)
		Assert.assertTrue(EnJsPars.repositorioLocacion.elementos.get(0).nombreDeLaLocacion == "Salón El Abierto")
	}

	@Test
	def testearServicioJson() {
		EnJsPars.actualizarRepoServicio(jSonServicios)
		Assert.assertEquals(1, EnJsPars.repositorioServicios.elementos.size)
		Assert.assertTrue(EnJsPars.repositorioServicios.elementos.get(0).descripcion == "Catering Food Party")
	}
	
	@Test
	def void mockUpdateServiceLocaciones() {
		RL.servJson = EnJsPars
		RL.update = mock(typeof(UpdateService))
		when(RL.locations).thenReturn(jSonLocaciones)
		RL.updateAll
		Assert.assertTrue(EnJsPars.repositorioLocacion.elementos.get(0).nombreDeLaLocacion == "Salón El Abierto")
	}
	@Test
	def void mockUpdateServiceUsuarios() {
		RU.servJson = EnJsPars
		RU.update = mock(typeof(UpdateService))
		when(RU.getUsers).thenReturn(jSonUsuarios)
		RU.updateAll
		Assert.assertTrue(EnJsPars.repositorioUsuarios.elementos.get(0).nombre == "Lucas")
	}
	@Test
	def void mockUpdateServiceServicios() {
		RS.servJson = EnJsPars
		RS.update = mock(typeof(UpdateService))
		when(RS.getServis()).thenReturn(jSonServicios)
		RS.updateAll
		Assert.assertTrue(EnJsPars.repositorioServicios.elementos.get(0).descripcion == "Catering Food Party")
	}

}
