package ar.edu.eventos.TestEventos
import ar.edu.eventos.Usuario.Usuario
import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point
import ar.edu.eventos.Eventos.Invitacion
import ar.edu.eventos.Eventos.Locacion
import ar.edu.eventos.Eventos.EventoCerrado
import ar.edu.eventos.Eventos.Evento
import ar.edu.eventos.Eventos.Entrada
import ar.edu.eventos.Eventos.EventoAbierto
import ar.edu.eventos.Eventos.Servicio
import ar.edu.eventos.Eventos.TarifaPorHora
import ar.edu.eventos.Eventos.TarifaFija
import ar.edu.eventos.Eventos.TarifaPorPersona
import java.util.List

class testEventos {
	Invitacion unaInvitacion
	Usuario usuario1
	Servicio lunch
	Servicio luces
	Servicio robot
	Locacion miCasa
	Locacion lugar1
	EventoCerrado fiesta
	Evento casamiento
	Entrada unEntrada

	@Before
	def void init() {
		
		unEntrada= new Entrada(casamiento)
		
		miCasa = new Locacion() => [
			nombreDeLaLocacion ="asd"
			ubicacion = new Point(4.1, 2.0)
			validar()
		]
			
		lugar1 = new Locacion() => [
			nombreDeLaLocacion ="asd"
			ubicacion = new Point(4.0, 2.0)
			superficieM2 = 10
			validar()
		]
		
		usuario1 = new Usuario() => [
			nombre = "asd"
			apellido ="asd"
			email = "asd"
			fechaDeNacimiento = LocalDateTime.of(2000, 10, 10, 20, 0)
			direccion = lugar1
			radioDeCercanía = 999
			
		]

		lunch = new Servicio() => [
			descripcion = "asd"
			ubicacion = miCasa
			tarifaPorKilometro = 1.0
			tarifaDelServicio = new TarifaPorHora()=>[
				valor = 10
				costoMínimoFijo = 20
			]
		]

		luces = new Servicio() => [
			descripcion = "asd"
			ubicacion = miCasa
			tarifaDelServicio = new TarifaFija()=>[
				valor = 10
			]
			tarifaPorKilometro = 1.0
		]
		
		robot = new Servicio() => [
			descripcion = "asd"
			ubicacion = miCasa
			tarifaDelServicio = new TarifaPorPersona()=>[
				valor = 10
				porcentajeMinimo = 10
			]
			tarifaPorKilometro = 1.0
		
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
			agregarEntrada(unEntrada)
			contratarServicio(robot)	
			locacion = lugar1
		]

		unaInvitacion = new Invitacion(usuario1, 5, fiesta)

	}

	@Test
	def void duracionDelCasamiento() {
		Assert.assertEquals(4, casamiento.duracion(), 0)
	}

	@Test
	def void distancia() {
		Assert.assertEquals(11.11, casamiento.distancia(new Point(4.1, 2.0)), 1)
	}

	@Test
	def void distancia2() {
		Assert.assertEquals(true,usuario1.meQuedaSerca(unaInvitacion))
	}

	@Test
	def void costoTotalDeUnEventoEnBaseASusServiciosContratados() {
		Assert.assertEquals(95.85, casamiento.costoTotal, 1)
	}
	
}
