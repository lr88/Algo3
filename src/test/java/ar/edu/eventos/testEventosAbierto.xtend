package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class testEventosAbierto {
	
	Usuario usuario1
	Locacion casaUsuario1
	
	
	EventoAbierto eventoAbierto1
	/*new(String unNombreDeUsuario, String unNombre, String unApellido, String unEmail, Point unLugar,
		boolean es_Antisocial, LocalDateTime unaFecha, double unRadioDeCercanía,TipoDeUsuario unTipoDeUsuario) {
		nombreDeUsuario = unNombreDeUsuario
		nombre = unNombre
		apellido = unApellido
		email = unEmail
		direccion = unLugar
		esAntisocial = es_Antisocial
		fechaDeNacimiento = unaFecha
		radioDeCercanía = unRadioDeCercanía
		tipoDeUsuario = unTipoDeUsuario
	} */


	@Before
	def void init() {
		
	casaUsuario1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 3)	
	
	usuario1 = new Usuario ("usuario1","usuario1","usuario1","usuario1@usuario1.com",
		new Point(1.0, 2.0),false,LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional
	)
	}


	@Test
	def void a() {
		usuario1.CrearEventoAbierto()
		
		
		
	}

}
