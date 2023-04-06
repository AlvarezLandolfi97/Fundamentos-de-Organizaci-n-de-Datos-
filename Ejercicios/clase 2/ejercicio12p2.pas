{12. La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio de
la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se
realizan al sitio.
La información que se almacena en el archivo es la siguiente:
* 
*  año, mes, dia, idUsuario y tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado por los
siguientes criterios: año, mes, dia e idUsuario.
* 
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará
el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato
mostrado a continuación:
Año : ---
Mes:-- 1
día:-- 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
--------
idusuario N Tiempo total de acceso en el dia 1 mes 1
Tiempo total acceso dia 1 mes 1
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 1
--------
idusuario N Tiempo total de acceso en el dia N mes 1
Tiempo total acceso dia N mes 1
Total tiempo de acceso mes 1
------
Mes 12
día 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
--------
idusuario N Tiempo total de acceso en el dia 1 mes 12
Tiempo total acceso dia 1 mes 12
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 12
--------
idusuario N Tiempo total de acceso en el dia N mes 12
Tiempo total acceso dia N mes 12
Total tiempo de acceso mes 12
Total tiempo de acceso año
Se deberá tener en cuenta las siguientes aclaraciones:
- El año sobre el cual realizará el informe de accesos debe leerse desde teclado.
- El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año
no encontrado”.
- Debe definir las estructuras de datos necesarias.
- El recorrido del archivo debe realizarse una única vez procesando sólo la información
necesaria.}
program alvarez;
const
	valor_alto = 9999;
	lim = 12;
type
	control = record
		anio:integer;
		mes:integer;
		dia:integer;
		id_usuario:integer;
		time:real;
	end;
	maestro = file of control;
	
	procedure leer(var mae:maestro; var reg:control);
	begin
		if eof(mae) then
			reg.anio:= valor_alto
		else
			read(mae,reg);
	end;
var
	mae:maestro;
	reg:control;
	anio,mes,dia,usuario:integer;
	time,time_dia,time_mes,time_anio:real;
begin
	assign(mae,'accesos.dat');
	reset(mae);
	write('ingrese el anio de acceso que le interesa: '); readln(anio);
	leer(mae,reg);
	while(reg.anio <> valor_alto)and(reg.anio <> anio)do
		leer(mae,reg);
	if(reg.anio = valor_alto)then
		write(' no hay registro del anio ',anio)
	else begin
		writeln(' tiempo de acceso del anio ',anio);
		mes:= reg.mes;
		time_anio:=0;
		while(reg.anio = anio)do begin
			mes:= reg.mes;
			time_mes:=0;
			while(reg.anio = anio)and(reg.mes = mes)do begin
				dia:= reg.dia;
				time_dia:=0;
				while(reg.anio = anio)and(reg.mes = mes)and(reg.dia = dia)do begin
					usuario:= reg.id_usuario;
					time:=0;
					while(reg.anio = anio)and(reg.mes = mes)and(reg.dia = dia)and(reg.id_usuario = usuario)do begin
						time:= time + reg.time;
						leer(mae,reg);
					end;
					writeln('Usuario: ',usuario,'tiempo de acceso: ',time,' dia: ',dia,' mes: ',mes);
					time_dia:= time_dia + time;
				end;
				writeln(' tiempo total de acceso:',time_dia,', dia: ',dia,', mes: ',mes);
				time_mes:= time_mes + time_dia;
			end;
			writeln('tiempo total de acceso: ',time_mes,', mes: ',mes);
			time_anio:= time_anio + time_mes;
		end;
		writeln('tiempo total de acceso durante el anio: ',time_anio);
	end;
	close(mae);
end.
