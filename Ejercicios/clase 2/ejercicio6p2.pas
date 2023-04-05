{6- Se desea modelar la información necesaria para un sistema de recuentos de casos de
covid para el ministerio de salud de la provincia de buenos aires.
* 
Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad casos
activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.
* 
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad casos activos, cantidad casos
nuevos, cantidad recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles.
* 
*  Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
* 
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).}
program covid;
const
	valor_alto = 9999;
	c = 10;
type
	str = string[20];
	casos = record 
		cod_localidad:integer;
		cod_cepa:integer;
		cant_activos:integer;
		cant_nuevos:integer;
		cant_recuperados:integer;
		cant_fallecidos:integer;
	end;
	informe = record
		cod_localidad:integer;
		nombre_localidad:str;
		cod_cepa:integer;
		nombre_cepa:str;
		cant_activos:integer;
		cant_nuevos:integer;
		cant_recuperados:integer;
		cant_fallecidos:integer;
	end;
	detalle = file of casos;
	maestro = file of informe;
	detalles = array [1..c] of detalle;
	registros = array [1..c] of casos;
	
	procedure leer(var det:detalle; var reg:casos);
	begin
		if eof(det) then
			reg.cod := valor_alto
		else
			read(det,reg);
	end;
	procedure minimo(var dets:detalles; var regs:registros; var min:casos);
	var
		i:integer;
	begin
		
	end;
	procedure artualizarMaestro(var mae:maestro; var dets:detalles);
	var
		regsDetalle:registros;
		regM:informe;
		i,cepa:integer;
		nom:str;
		acumulador:casos;
	begin	
		{cod_localidad:integer;
		cod_cepa:integer;
		cant_activos:integer;
		cant_nuevos:integer;
		cant_recuperados:integer;
		cant_fallecidos:integer;}
		for i:= 1 to c do begin
			str(i,nom);
			assign(dets[i],'detalle'+nom+'.dat';
			reset(dets[i]);
			leer(dets[i],regsDetalle[i]);
		end;
		minimo(dets,regsDetalle,min);
		while( min.cod_localidad <> valor_alto)do begin
			cepa:=min.cod_cepa;
			acumulador.cant_activos:=0;
			acumulador.cant_nuevos:=0;
			acumulador.cant_recuperados:=0;
			acumulador.cant_fallecidos:=0;
			while( min.cod_localidad <> valor_alto)and(min.cod_cepa = cepa)do begin
				
			
		assign(mae,'maestro.dat');
		reset(mae);
		
		for i:= 1 to c do 
			close(dets[i]);
	end;
var
	dets:detalles;
	mae:maestro;
begin
	actualizarMaestro(mae,dets);
end.

	
