package ar.edu.eventos

import org.junit.Test

class testRepoGenerico {

var RepoLocacion RepoLocacion
var RepoServicios RepoServicios

@Test
	def void testSepuedeActualizarUnRepoEspecieConElServicioJason() {
		var String JSonUsuarios ="[{
		\"nombreUsuario\":\"lucas_capo\",
		\"nombreApellido\":\"Lucas Lopez\",
		\"email\":\"lucas_93@hotmail.com\",
		\"fechaNacimiento\":\"15/01/1993\",
		\"direccion\":{
		\"calle\":\"25 de Mayo\",
		\"numero\":3918,
		\"localidad\":\"San Martín\",
		\"provincia\":\"Buenos Aires\",
		\"x\":-34.572224,
		\"y\":58.535651
		}},
   		{  
		\"nombreUsuario\":\"martin1990\",
		\"nombreApellido\":\"Martín Varela\",
		\"email\":\"martinvarela90@yahoo.com\",
		\"fechaNacimiento\":\"18/11/1990\",
		\"direccion\":{
		\"calle\":\"Av. Triunvirato\",
		\"numero\":4065,
		\"localidad\":\"CABA\",
		\"provincia\":\"\",
		\"x\":-33.582360,
		\"y\":60.516598
		}}]"
		}
	}