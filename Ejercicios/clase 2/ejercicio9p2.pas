{9. Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
	provincia y localidad. Para ello, se posee un archivo con la siguiente información:
	*  código de provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
	Presentar en pantalla un listado como se muestra a continuación:
		Código de Provincia
		Código de Localidad              Total de Votos
		................................ ......................
		................................ ......................
		Total de Votos Provincia: ____
		Código de Provincia
		Código de Localidad              Total de Votos
		................................ ......................
		Total de Votos Provincia: ___
		…………………………………………………………..
		Total General de Votos: ___

NOTA: La información se encuentra ordenada por código de provincia y código de
	  localidad.}
program vot;
const
	valor_alto = 9999;
type
	votos = record
		cod_provincia:integer;
		cod_localidad:integer;
		nro_mesa:integer;
		cant_votos:integer;
	end;
	maestro = file of votos;
	procedure leer(var mae:maestro; var reg:votos);
	begin
		if eof(mae) then
			reg.cod_provincia:= valor_alto
		else
			read(mae,reg);
	end;
var
	mae:maestro;
	reg:votos;
	provincia,localidad,cant_provincia,cant_localidad:integer;
begin
	assign(mae,'votos.dat');
	reset(mae);
	leer(mae,reg);
	while(reg.cod_provincia <> valor_alto) do begin
		provincia:= reg.cod_provincia;
		cant_provincia:=0;
		while(reg.cod_provincia <> valor_alto)and(reg.cod_provincia = provincia)do begin
			localidad:= reg.cod_localidad;
			cant_localidad:=0;
			while(reg.cod_provincia <> valor_alto)and(reg.cod_provincia = provincia)and(reg.cod_localidad = localidad)do begin
				cant_localidad:= cant_localidad + reg.cant_votos;
				leer(mae,reg);
			end;
			writeln('provincia: ',provincia,', Localidad: ',localidad,', cantidad de votos: ',cant_localidad);
			cant_provincia:= cant_provincia + cant_localidad;
		end;
	end;
	writeln();
	writeln('Cantidad de votos en total: ',cant_provincia);
	close(mae);
end.
