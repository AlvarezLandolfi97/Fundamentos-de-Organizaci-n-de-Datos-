{18 . Se cuenta con un archivo con información de los casos de COVID-19 registrados en los
	  diferentes hospitales de la Provincia de Buenos Aires cada día. Dicho archivo contiene:
	  
	  cod_localidad, nombre_localidad, cod_municipio, nombre_minucipio, cod_hospital,
	  nombre_hospital, fecha y cantidad de casos positivos detectados.
	  * 
	  El archivo está ordenado por localidad, luego por municipio y luego por hospital.
	  
	  a. Escriba la definición de las estructuras de datos necesarias y un procedimiento que haga
		 un listado con el siguiente formato:
	
			Nombre: Localidad 1
				Nombre: Municipio 1
					Nombre Hospital 1……………..Cantidad de casos Hospital 1
					……………………..
					Nombre Hospital N…………….Cantidad de casos Hospital N
				Cantidad de casos Municipio 1
				…………………………………………………………………….
				Nombre Municipio N
					Nombre Hospital 1……………..Cantidad de casos Hospital 1
					……………………..
					NombreHospital N…………….Cantidad de casos Hospital N
				Cantidad de casos Municipio N
			Cantidad de casos Localidad 1
			-----------------------------------------------------------------------------------------
			Nombre Localidad N
				Nombre Municipio 1
					Nombre Hospital 1……………..Cantidad de casos Hospital 1
					……………………..
					Nombre Hospital N…………….Cantidad de casos Hospital N
				Cantidad de casos Municipio 1
				…………………………………………………………………….
				Nombre Municipio N
					Nombre Hospital 1……………..Cantidad de casos Hospital 1
					……………………..
					Nombre Hospital N…………….Cantidad de casos Hospital N
				Cantidad de casos Municipio N
		Cantidad de casos Localidad N
	Cantidad de casos Totales en la Provincia

	b. Exportar a un archivo de texto la siguiente información nombre_localidad,
	   nombre_municipio y cantidad de casos de municipio, para aquellos municipios cuya
	   cantidad de casos supere los 1500. El formato del archivo de texto deberá ser el			
	   adecuado para recuperar la información con la menor cantidad de lecturas posibles.

NOTA: El archivo debe recorrerse solo una vez.}
program alvar;
const
	valor_alto = 9999;
	lim = 1500;
type
	str = string[20];
	covid = record
		cod_localidad:integer;
		nombre_localidad:str;
		cod_municipio:integer;
		nombre_municipio:str;
		cod_hospital:integer;
		nombre_hospital:str;
		fecha:str;
		cant_positivos:integer;
	end;
	maestro = file of covid;
	{El archivo está ordenado por localidad, luego por municipio y luego por hospital.}
	procedure leer(var mae:maestro; var reg:covid);
	begin
		if eof(mae) then
			reg.cod_localidad:= valor_alto
		else
			read(mae,reg);
	end;
	procedure listar_casos(var mae:maestro);
	var
		regm:covid;
		localidad,municipio,hospital,cant,cant_municipio,cant_localidad,cant_provincia:integer;
		nombre_localidad,nombre_municipio,nombre_hospital:str;
		t:text;
	begin
		reset(mae);
		assign(t,'casos.minimos.txt');
		rewrite(t);
		leer(mae,regm);
		cant_provincia:= 0;
		while(regm.cod_localidad <> valor_alto)do begin
			localidad:= regm.cod_localidad;
			nombre_localidad:= regm.nombre_localidad;
			writeln('Nombre localidad ',nombre_localidad);
			cant_localidad:= 0;
			while(regm.cod_localidad <> valor_alto)and(regm.cod_localidad = localidad)do begin
				municipio:= regm.cod_municipio;
				nombre_municipio:= regm.nombre_municipio;
				writeln('Nombre municipio ',nombre_municipio);
				cant_municipio:= 0;
				while(regm.cod_localidad <> valor_alto)and(regm.cod_localidad = localidad)and(regm.cod_municipio = municipio)do begin
					hospital:= regm.cod_hospital;
					nombre_hospital:= regm.nombre_hospital;
					write('Nombre hospital ',nombre_hospital);
					cant:= 0;
					while(regm.cod_localidad <> valor_alto)and(regm.cod_localidad = localidad)and(regm.cod_municipio = municipio)and(regm.cod_hospital = hospital) do begin
						cant:= cant + regm.cant_positivos;
						leer(mae,regm);
					end;
					writeln(',  cantidad de casos: ',cant);
					cant_municipio:= cant_municipio + cant;
				end;
				if(cant_municipio > lim)then begin
					writeln(t,cant_municipio,' ',nombre_municipio,' ',nombre_localidad);
				end;
				writeln('cantidad de casos municipio ',nombre_municipio,': ',cant_municipio);
				cant_localidad:= cant_localidad + cant_municipio;
			end;
			writeln('cantidad de casos localidad ',nombre_localidad,': ',cant_localidad);
			cant_provincia:= cant_provincia + cant_localidad;
		end;
		writeln('cantidad de casos provincia Buenos Aires: ',cant_provincia);
		close(mae);
		close(t);
	end;
var
	mae:maestro;
begin
	assign(mae,'casos_covid_detectados.dat');
	listar_casos(mae);
end.
