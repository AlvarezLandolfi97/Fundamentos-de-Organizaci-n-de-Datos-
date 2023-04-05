{5. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
	toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
	información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
	en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
	reuniendo dicha información.
	Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
	nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
	del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
	padre.
	En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
	apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
	lugar.
	Realizar un programa que cree el archivo maestro a partir de toda la información de los
	archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
	apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
	apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
	además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se
	deberá, además, listar en un archivo de texto la información recolectada de cada persona.

	Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
		  Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
		  además puede no haber fallecido.}
program perdida;
const 
	c = 50;
	valor_alto = 9999;
type
	str=string[20];
	dire = record
		calle,nro,piso,depto:integer;
		ciudad:str;
	end;
		
	nacimiento = record
		nro_partida:integer;
		nombre,apellido:str;
		direccion:dire;
		matricula_medico:integer;
		nombre_madre,apellido_madre:str;
		dni_madre:integer;
		nombre_padre,apellido_padre:str;
		dni_padre:integer;
	end;
	{nro partida nacimiento, DNI, nombre y
	apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
	lugar.}
	fallecido = record
		nro_partida:integer;
		dni:integer;
		nombre,apellido:str;
		matricula_medico:integer;
		fecha:str;
		hora_muerte:real;
		lugar:str;
	end;
	persona = record
		nro_partida:integer;
		nombre,apellido:str;
		direccion:dire;
		matricula_medico:integer;
		nombre_madre:str;
		apellido_madre:str;
		dni_madre:integer;
		nombre_padre:str;
		apellido_padre:str;
		dni_padre:integer;
		fallecio:boolean;
		matricula_medico_deceso:integer;
		fecha:str;
		hora_muerte:real;
		lugar:str;
	end;
	maestro = file of persona;
	detalleN = file of nacimiento;
	detalleM = file of fallecido;
	detallesN = array [1..c] of detalleN;
	detallesM = array [1..c] of detalleM;
	registrosN = array [1..c] of nacimiento;
	registrosF = array [1..c] of fallecido;
	
	procedure leerN(var det:detalleN; var regN:nacimiento);
	begin
		if eof(det) then
			regN.nro_partida:= valor_alto
		else
			read(det,regN);
	end;
	procedure leerF(var det:detalleM; var regM:fallecido);
	begin
		if eof(det) then
			regM.nro_partida:= valor_alto
		else
			read(det,regM);
	end;
	procedure exportar_completo(regm:persona; var t:text);
	begin
		writeln(t,regm.nro_partida,' ',regm.nombre,' ',regm.apellido);
		writeln(t,regm.direccion.calle,' ',regm.direccion.nro,' ',regm.direccion.piso,' ',regm.direccion.depto,' ',regm.direccion.ciudad);
		write(regm.matricula_medico,' ',regm.nombre_madre,' ',regm.apellido_madre,' ',regm.dni_madre,'\n');
		writeln(regm.nombre_padre,' ',regm.apellido_padre,' ',regm.dni_padre,' ',regm.fallecio,' ',regm.matricula_medico_deceso,' ',regm.fecha,' ',regm.hora_muerte,' ',regm.lugar);
		writeln(t);
	end;
	procedure exportar_incompleto(regm:persona; var t:text);
	begin
		writeln(t,regm.nro_partida,' ',regm.nombre,' ',regm.apellido);
		writeln(t,regm.direccion.calle,' ',regm.direccion.nro,' ',regm.direccion.piso,' ',regm.direccion.depto,' ',regm.direccion.ciudad);
		write(regm.matricula_medico,' ',regm.nombre_madre,' ',regm.apellido_madre,' ',regm.dni_madre,'\n');
		writeln(regm.nombre_padre,' ',regm.apellido_padre,' ',regm.dni_padre,' ',regm.fallecio,'\n');
		writeln(t);
	end;
	procedure copiar_completo(var regm:persona; var regn:nacimiento; var regf:registrosF; var det_nacidos:detallesN; var det_fallecidos:detallesM; var t:text);
	begin
		regm.nro_partida:= regn.nro_partida;
		regm.nombre:= regn.nombre;
		regm.apellido:= regn.apellido;
		regm.direccion.calle:= regn.direccion.calle;
		regm.direccion.nro:= regn.direccion.nro;
		regm.direccion.piso:= regn.direccion.piso;
		regm.direccion.depto:= regn.direccion,depto;
		regm.direccion.ciudad:= regn.direccion.ciudad;
		regm.matricula_medico:= regn.matricula_medico;
		regm.nombre_madre:= regn.nombre_madre;
		regm.apellido_madre:= regn.apellido_madre;
		regm.dni_madre:= regn.dni_madre;
		regm.nombre_padre:= regn.nombre_padre;
		regm_apellido_padre:= regn.apellido_padre;
		regm_dni_padre:= regn.dni_padre;
		regm.fallecio:= true;
		regm.matricula_medico_deceso:= regf.matricula_medico;
		regm.fecha:= regf.fecha;
		regm.hora_muerte:= regf.hora_muerte;
		regm.lugar:= regf.lugar;
		exportar_completo(regm,t);
		leerN(det,regN);
		leerF(det,regM);
	end;
	{ nro partida nacimiento, nombre,
	apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
	apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
	además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar}
	procedure copiar_incompleto_exp(var regm:persona; var regn:registrosN;var det_nacidos:detallesN; var t:text);
	begin
		regm.nro_partida:= regn.nro_partida;
		regm.nombre:= regn.nombre;
		regm.apellido:= regn.apellido;
		regm.direccion.calle:= regn.direccion.calle;
		regm.direccion.nro:= regn.direccion.nro;
		regm.direccion.piso:= regn.direccion.piso;
		regm.direccion.depto:= regn.direccion,depto;
		regm.direccion.ciudad:= regn.direccion.ciudad;
		regm.matricula_medico:= regn.matricula_medico;
		regm.nombre_madre:= regn.nombre_madre;
		regm.apellido_madre:= regn.apellido_madre;
		regm.dni_madre:= regn.dni_madre;
		regm.nombre_padre:= regn.nombre_padre;
		regm_apellido_padre:= regn.apellido_padre;
		regm_dni_padre:= regn.dni_padre;
		regm.fallecio:= false;
		exportar_incompleto(regm,t);
		leerN(det,regN);
	end;
	procedure genera_maestro_exp(var mae:maestro; var det_nacidos:detallesN; var det_fallecidos:detallesM);
	var
		regm:persona;
		regn:registrosN;
		regf:registrosF;
		i:integer;
		nom:str;
		t:text;
	begin
		assign(mae,'maestro.dat');
		rewrite(mae);
		assign(t,'texto_denso.txt');
		rewrite(t);
		for i:= 1 to c do begin
			str(i,nom);
			assign(det_nacidos[i],'nacido'+nom+'.dat');
			reset(dat_nacidos(i]);
			leerN(det_nacidos[i],regn[i]);
			assign(det_fallecido[i],'fallecido'+nom+'.dat');
			reset(det_fallecido[i]);
			leerF(det_fallecido[i],regf[i]);
		
			while (regn[i].nro_partida <> valor_alto) do begin
					if(regn[i].nro_partida = regf[i].nro_partida)then
						copiar_completo_exp(regm,regn[i],regf[i],det_nacidos[i],det_fallecidos[i],t)
					else
						copiar_incompleto_exp(regm,regn[i],det_nacidos[i],t);
			end;
			close(det_nacidos[i]);
			close(det_fallecidos[i]);
		end;
		close(mae);
		close(t);
	end;
var
	mae:maestro;
	det_nacidos:detallesN;
	det_fallecidos:detallesM;
begin
	genera_maestro(mae,det_nacidos,det_fallecidos);
end.
