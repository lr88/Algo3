package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point

class testEventos {
	Invitacion unaInvitacion
	Usuario usuario1
	Servicio lunch
	Servicio luces
	Servicio robot
	Locacion miCasa
	EventoCerrado fiesta
	Evento casamiento

	@Before
	def void init() {
		miCasa = new Locacion() => [
			nombreDeLaLocacion ="asd"
			ubicacion = new Point(1.0, 2.0)
			soyValido()
		]
		
		usuario1 = new Usuario() => [
			nombre = "asd"
			apellido ="asd"
			email = "asd"
			fechaDeNacimiento = LocalDateTime.of(2000, 10, 10, 20, 0)
			direccion = new Point(4.0, 2.0)
			radioDeCercanía = 999
			
		]

		lunch = new Servicio() => [
			descripcion = "asd"
			ubicacion = miCasa
			tarifaPorKilometro = 10.0
			tarifaDelServicio = new TarifaPorHora()=>[
				valor = 100
				horasMinimas = 4
			]
		]

		luces = new Servicio() => [
			descripcion = "asd"
			ubicacion = miCasa
			tarifaDelServicio = new TarifaFija()=>[
				valor = 100
			]
			tarifaPorKilometro = 10.0
		]
		
		robot = new Servicio() => [
			descripcion = "asd"
			ubicacion = miCasa
			tarifaDelServicio = new TarifaPorPersona()=>[
				valor = 100
				porcentajeMinimo = 70
			]
			tarifaPorKilometro = 10.0
		
		]

		fiesta = new EventoCerrado() => [
			fechaDeInicioDelEvento = LocalDateTime.of(2018, 10, 10, 20, 0)
			fechaDeFinDelEvento = LocalDateTime.of(2018, 10, 11, 0, 0)
			locacion = miCasa
		]
		casamiento = new EventoAbierto() => [
			fechaDeInicioDelEvento = LocalDateTime.of(2018, 10, 10, 20, 0)
			fechaDeFinDelEvento = LocalDateTime.of(2018, 10, 11, 0, 0)
			contratarServicio(lunch)
			contratarServicio(luces)
		]

		unaInvitacion = new Invitacion(usuario1, 5, fiesta)

	}

	@Test
	def void duracionDelCasamiento() {
		Assert.assertEquals(4, casamiento.duracion(), 0)
	}

	@Test
	def void distancia() {
		Assert.assertEquals(11.11, miCasa.distancia(new Point(1.1, 2.0)), 1)
	}

	@Test
	def void distancia2() {
		Assert.assertEquals(true,usuario1.meQuedaSerca(unaInvitacion))
	}

	@Test
	def void costoTotalDeUnEventoEnBaseASusServiciosContratados() {
		Assert.assertEquals(520, casamiento.costoTotal, 0)
	}

}
