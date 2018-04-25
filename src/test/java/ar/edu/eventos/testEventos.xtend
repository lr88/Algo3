package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point
import java.util.List

class testEventos {
	Servicio lunch
	Servicio luces
	Locacion miCasa
	Evento casamiento

	@Before
	def void init() {
		miCasa = new Locacion() => [
			ubicacion = new Point(1.0, 2.0)
		]

		lunch = new Servicio() => [
			costo = 10
		]

		luces = new Servicio() => [
			costo = 10
		]
		casamiento = new EventoAbierto() => [
			fechaDeInicioDelEvento = LocalDateTime.of(2018, 10, 10, 20, 0)
			fechaDeFinDelEvento = LocalDateTime.of(2018, 10, 11, 0, 0)
			contratarServicio(lunch)
			contratarServicio(luces)
		]

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
	def void costoTotalDeUnEventoEnBaseASusServiciosContratados() {
		Assert.assertEquals(20, casamiento.costoTotal, 0)
	}

}
