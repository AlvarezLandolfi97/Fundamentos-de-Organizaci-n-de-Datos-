{15. Se desea modelar la información de una ONG dedicada a la asistencia de personas con
	 carencias habitacionales. La ONG cuenta con un archivo maestro conteniendo información
	 como se indica a continuación: Código pcia, nombre provincia, código de localidad, nombre
	 de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin
	 agua,# viviendas sin sanitarios.
	 Mensualmente reciben detalles de las diferentes provincias indicando avances en las obras
	 de ayuda en la edificación y equipamientos de viviendas en cada provincia. La información
	 de los detalles es la siguiente: Código pcia, código localidad, #viviendas con luz, #viviendas
	 construidas, #viviendas con agua, #viviendas con gas, #entrega sanitarios.
	 
	 Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
	 recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
	 provincia y código de localidad.
	
	 Para la actualización se debe proceder de la siguiente manera:
		
		1. Al valor de vivienda con luz se le resta el valor recibido en el detalle.
		
		2. Idem para viviendas con agua, gas y entrega de sanitarios.
		
		3. A las viviendas de chapa se le resta el valor recibido de viviendas construidas
		   La misma combinación de provincia y localidad aparecen a lo sumo una única vez.

Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades sin viviendas de
chapa (las localidades pueden o no haber sido actualizadas).}
program alvar;
const
	valor_alto = 9999;
	c = 10;
type
	str = string[20];
	
	carencias = record
		cod_provincia:integer;
		nombre_provincia:str;
		cod_ciudad:integer;
		nombre_localidad:str;
		cod_localidad:integer;
		cant_sin_con_luz:integer;
		cant_sin_con_gas:integer;
		cant_de_chapa:integer;	
		cant_con_sin_agua:integer;
		cant_sin_con_sanitarios:integer;
	end;
	archivo = file of carencias;
	detalles = array [1..c] of archivo;
	registros = array [1..c] of carencias;
	
	procedure leer(var mae:archivo; var reg:carencias);
	begin
		if eof(mae) then
			reg.cod_provincia:= valor_alto
		else
			read(mae,reg);
	end;
	procedure minimo(var det:detalles; reg:registros; var min:carencias);
	var
		i,pos:integer;
	begin
		min.cod_provincia:= valor_alto;
		for i:= 1 to c do 
			if(reg[i].cod_provincia <= min.cod_provincia)and(reg[i].cod_localidad < min.cod_localidad)then begin
				min:= reg[i];
				pos:=i;
			end;
		if (min.cod_provincia <> valor_alto)then
			leer(det[pos],reg[pos]);
	end;{:  Código pcia, nombre provincia, código de localidad, nombre
		de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin
		agua,# viviendas sin sanitarios.}
	procedure actualizar_maestro(var mae:archivo);
	var
		i,provincia,localidad,s_luz,s_gas,s_chapa,s_agua,s_sanitarios,viviendas_de_chapa:integer;
		det:detalles;
		reg:registros;
		regm:carencias;
		nom:str;
	begin
		reset(mae);
		for i:= 1 to c do begin
			str(i,nom);
			assign(det[i],'avance',nom,'.dat');
			reset(det[i]);
			leer(det[i],reg[i]);
		end;
		minimo(det,reg,min);
		while(min.cod_provincia <> valor_alto) do begin
			provincia:= min.cod_provincia;
			while(min.cod_provincia <> valor_alto)and(min.cod_provincia = provincia)do begin
				localidad:= min.cod_localidad;
				s_luz:= 0; s_gas:= 0; s_chapa:= 0; s_agua:= 0; s_sanitarios:= 0;
				viviendas_de_chapa:= 0;
				while(min.cod_provincia <> valor_alto)and(min.cod_provincia = provincia)and(min.cod_localidad = localidad)do begin
					s_luz:= s_luz + min.cant_sin_con_luz;
					s_gas:= s_gas + min.cant_sin_con_gas;
					s_chapa:= s_chapa + min.cant_de_chapa;
					s_agua:= s_agua + min.cant_con_sin_agua;
					s_sanitarios:= s_sanitarios + cant_sin_con_sanitarios;
					minimo(det,reg,min);
				end;
				read(mae,regm);
				while(regm.cod_provincia <> provincia)and(regm.cod_localidad <> localidad)do
					read(mae,regm);
				regm.cant_sin_con_luz:= regm.cant_sin_con_luz - s_luz;
				regm.cant_sin_con_gas:= regm.cant_sin_con_gas - s_gas;
				regm.cant_de_chapa:= regm.cant_de_chapa - s_chapa;
				regm.cant_con_sin_agua:= regm.cant_con_sin_agua - s_agua;
				regm.cant_sin_con_sanitarios:= regm.cant_sin_con_sanitarios - s_sanitarios;
				seek(mae,filePos(mae) -1);
				write(mae,regm);
				if(regm.cant_de_chapa <> 0)then
					viviendas_de_chapa:= viviendas_de_chapa + 1;
			end;
		end;
		writeln('la cantidad de localidades con viviendas de chapa es: ',viviendas_de_chapa);
		close(mae);
		for i:= 1 to c do
			close(det[i]);
	end;
var
	mae:archivo;
begin
	assign(mae,'ong.dat');
	actualizar_maestro(mae);
end.
