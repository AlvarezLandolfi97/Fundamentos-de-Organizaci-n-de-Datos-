{11. A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
	 archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
	 alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
	 agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
	 localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
	 necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.

NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
	  pueden venir 0, 1 ó más registros por cada provincia.}
program alf;
const
	valor_alto = 'zzzz';
type
	str = string[20];
	alfabetizacion = record
		nombre_provincia:str;
		nombre_localidad:str;
		cant_alfabetizadas:integer;
		cant_encuestadas:integer;
	end;
	archivo = file of alfabetizacion;
	
	procedure leer(var det:archivo; var regd:alfabetizacion);
	begin
		if eof(det) then
			regd.nombre_provincia:= valor_alto
		else
			read(det,regd);
	end;
	procedure minimo(var det1,det2:archivo; var  regd1,regd2,min:alfabetizacion);
	begin
		if( regd1.nombre_provincia < regd2.nombre_provincia)then begin
			min:= regd1;
			leer(det1,regd1);
		end
		else begin
			min:= regd2;
			leer(det2,regd2);
		end;
	end;
	procedure actualizar_maestro(var mae:archivo);
	var
		det1,det2:archivo;
		provincia:str;
		alfa,encue:integer;
		regd1,regd2,regm,min:alfabetizacion;
	begin
		assign(det1,'detalle1.dat');
		assign(det2,'detalle2.dat');
		reset(det1);
		reset(det2);
		minimo(det1,det2,regd1,regd2,min);
		while(min.nombre_provincia <> valor_alto)do begin
			provincia:= min.nombre_provincia;
			alfa:=0; encue:=0;
			while(min.nombre_provincia <> valor_alto)and(min.nombre_provincia = provincia)do begin
				alfa:= alfa + min.cant_alfabetizadas;
				encue:= encue + min.cant_encuestadas;
				minimo(det1,det2,regd1,regd2,min);
			end;
			read(mae,regm);
			while(provincia <> regm.nombre_provincia)do
				read(mae,regm);
			seek(mae,filePos(mae)-1);
			regm.cant_encuestadas:=encue;
			regm.cant_alfabetizadas:=alfa;
			write(mae,regm);
		end;
		close(det1);
		close(det2);
	end;
var
	mae:archivo;
begin
	assign(mae,'alfabet.dat');
	reset(mae);
	actualizar_maestro(mae);
	close(mae);
end.
