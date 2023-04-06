{10. Se tiene información en un archivo de las horas extras realizadas por los empleados de
	 una empresa en un mes. Para cada empleado se tiene la siguiente información:
	 
	 departamento, división, número de empleado, categoría y cantidad de horas extras
	 realizadas por el empleado. Se sabe que el archivo se encuentra ordenado por
	 departamento, luego por división, y por último, por número de empleados. Presentar en
	 pantalla un listado con el siguiente formato:
	
	Departamento
	
	División
	
	Número de Empleado	 Total de Hs. 	Importe a cobrar
	...... 				 .......... 	.........
	...... 				 .......... 	.........

	Total de horas división: ____
	Monto total por división: ____
	División
	.................
	Total horas departamento: ____
	Monto total departamento: ____

	Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
	iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
	de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
	de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
	posición del valor coincidente con el número de categoría.}
program ext;
const
	valor_alto = 9999;
	c = 15;
type
	empleado = record
		departamento:integer;
		division:integer;
		nro_empleado:integer;
		categoria:integer;
		cant_horas:integer;
	end;
	maestro = file of empleado;
	valores = array [1..c] of real;
	
	procedure leer(var mae:maestro; var reg:empleado);
	begin
		if eof(mae) then
			reg.departamento:= valor_alto
		else
			read(mae,reg);
	end;
	procedure listar_horas_extras(var mae:maestro; v:valores);
	var
		reg:empleado;
		departamento,division,horas_departamento,horas_division:integer;
		monto_departamento,monto_division:real;
	begin
		assign(mae,'maestro.dat');
		reset(mae);
		leer(mae,reg);
		while( reg.departamento <> valor_alto) do begin
			writeln('Departamento: ',reg.departamento);
			departamento:= reg.departamento;
			horas_departamento:= 0;
			monto_departamento:=0;
			while( reg.departamento <> valor_alto)and(reg.departamento = departamento)do begin
				writeln('Division: ',reg.division);
				division:= reg.division;
				horas_division:=0;
				monto_division:=0;
				while( reg.departamento <> valor_alto)and(reg.departamento = departamento)and(reg.division = division) do begin
					monto_division:= monto_division + (v[reg.categoria]*reg.cant_horas);
					horas_division:= horas_division + reg.cant_horas;
					writeln('Numero de empleado: ',reg.nro_empleado,', Total de Hs: ',reg.cant_horas,', Importe a cobrar: ',v[reg.categoria]); 
					leer(mae,reg);
				end;
				writeln('Total de horas division: ',horas_division);
				writeln('Monto total division: ',monto_division);
			end;
			writeln('Total de horas division: ',horas_departamento);
			writeln('Monto total departamento: ',monto_departamento);
		end;
		close(mae);
	end;
var
	v:valores;
	mae:maestro;
	t:text;
	i:integer;
begin
	assign(t,'valores.txt');
	reset(t);
	for i:= 1 to c do
		read(t,v[i]);
	close(t);
	listar_horas_extras(mae,v);
end.
