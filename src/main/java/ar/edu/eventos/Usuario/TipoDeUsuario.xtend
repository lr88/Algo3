package ar.edu.eventos.Usuario

import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.Eventos.Evento

interface TipoDeUsuario {
	
	public def void puedoCancelarElEvento(Evento evento)

	public def void puedoPostergarElEvento(Evento evento)

	public def void puedoOrganizarEventoAbierto(Evento unEvento, Usuario unUsuario)

	public def void puedoOrganizarelEventoCerrado(Evento unEvento, Usuario unUsuario)
}

@Accessors
class Free implements TipoDeUsuario {
	
	private int maximoDePersonasPorEvento = 50
	private int maximoDeEventosMensuales = 3

	public override void puedoCancelarElEvento(Evento evento) {
		throw new BusinessException("No podes Cancelar Eventos")
	}

	public override void puedoPostergarElEvento(Evento evento) {
		throw new BusinessException("No podes postergar Eventos")
	}

	public override void puedoOrganizarEventoAbierto(Evento unEvento, Usuario unUsuario) {
		throw new BusinessException("No podes organizar Eventos Abiertos")
	}

	public override void puedoOrganizarelEventoCerrado(Evento unEvento, Usuario unUsuario) {
		validarEventosEsteMes(unEvento, unUsuario)
		validarEventosactivos(unEvento, unUsuario)
		validarcantidadDeInvitados(unEvento, unUsuario)
	}

	private def void validarEventosEsteMes(Evento unEvento, Usuario unUsuario) {
		if (!(unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales)){
		throw new BusinessException("Superas la cantidad permitida por mes")
		}
	}

	private def void validarEventosactivos(Evento unEvento, Usuario unUsuario) {
		if (!(unUsuario.eventosActivos() < 1)) {
			throw new BusinessException("Superas la cantidad permitida a la vez")
	}}

	private def void validarcantidadDeInvitados(Evento unEvento, Usuario unUsuario) {
		if (!(unEvento.cantidadDePersonasQueAsisten < maximoDePersonasPorEvento)) {
			throw new BusinessException("Superas la cantidad maxima de invitados")
		}
	}
}

class Amateur implements TipoDeUsuario {
	
	private int  maximoDeInvitacionesPorEvento = 50
	private int cantidadMaximaPermitidaDeSimultaneidadDeEventos = 5

	public override void puedoCancelarElEvento(Evento evento) {
	}

	public override void puedoPostergarElEvento(Evento evento) {
	}

	public override void puedoOrganizarEventoAbierto(Evento unEvento, Usuario unUsuario) {
		if (!(unUsuario.eventosActivos() < cantidadMaximaPermitidaDeSimultaneidadDeEventos)) {
			throw new BusinessException("Por Ser de tipo Amateur no podes organizar este Evento")
		}
	}

	public override void puedoOrganizarelEventoCerrado(Evento unEvento, Usuario unUsuario) {
		if (!(unUsuario.eventosActivos() < cantidadMaximaPermitidaDeSimultaneidadDeEventos &&
			unEvento.cantidadDePersonasQueAsisten() < maximoDeInvitacionesPorEvento)) {
			throw new BusinessException("Por Ser de tipo Amateur no podes organizar este Evento")
		}
	}
	
}

class Profesional implements TipoDeUsuario {

	private int maximoDeEventosMensuales = 20

	public override void puedoCancelarElEvento(Evento evento) {
	}

	public override void puedoPostergarElEvento(Evento evento) {
	}

	public override void puedoOrganizarEventoAbierto(Evento unEvento,Usuario unUsuario) {
		if (!(unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales)) {
			throw new BusinessException("Por Ser de tipo Profesional no podes organizar este Evento")
		}
	}

	public override void puedoOrganizarelEventoCerrado(Evento unEvento, Usuario unUsuario) {
		if (!(unUsuario.cantidadDeEventosEnEsteMes(unEvento) < maximoDeEventosMensuales)) {
			throw new BusinessException("Por Ser de tipo Profesional no podes organizar este Evento")
		}
	}
	
}
