{14. Una compañía aérea dispone de un archivo maestro donde guarda información sobre
	 sus próximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida
	 y la cantidad de asientos disponibles. La empresa recibe todos los días dos archivos detalles
	 para actualizar el archivo maestro. En dichos archivos se tiene destino, fecha, hora de salida
	 y cantidad de asientos comprados. Se sabe que los archivos están ordenados por destino
	 más fecha y hora de salida, y que en los detalles pueden venir 0, 1 ó más registros por cada
	 uno del maestro. Se pide realizar los módulos necesarios para:

	 c. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje
		sin asiento disponible.
	 
	 d. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que
	    tengan menos de una cantidad específica de asientos disponibles. La misma debe
	    ser ingresada por teclado.

NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.}
program alvar;
const
	valor_alto = 'zzzz';
type
	str = string[20];
	vuelo = record
		destino:str;
		fecha:str;
		hora_salida:real;
		asientos_dis_ven:integer;
	end;
	archivo = file of vuelo;
	
	procedure leer(var mae:archivo; var reg:vuelo);
	begin
		if eof(mae) then
			reg.destino:= valor_alto
		else
			read(mae,reg);
	end;
	procedure minimo(var det1,det2:archivo; var reg1,reg2,min:vuelo);
	begin
		if(reg1.destino <= reg2.destino)and(reg1.fecha <= reg2.fecha)and(reg1.hora_salida <= reg2.hora_salida)then begin
			min:= reg1;
			leer(det1,reg1);
		end
		else begin
			min:= reg2;
			leer(det2,reg2);
		end;
	end;
	procedure actualizar_maestro(var mae:archivo);
	var
		det1,det2:archivo;
		reg1,reg2,regm,min:vuelo;
		destino,fecha:str;
		hora_salida:real;
		venta:integer;
	begin
		reset(mae);
		assign(det1,'detalle1.dat');
		assign(det2,'detalle2.dat');
		reset(det1);
		reset(det2);
		minimo(det1,det2,reg1,reg2,min);
		while(min.destino <> valor_alto)do begin
			destino:= min.destino;
			while(min.destino <> valor_alto)and(min.destino = destino)do begin
				fecha:= min.fecha;
				while(min.destino <> valor_alto)and(min.destino = destino)and(min.fecha = fecha)do begin
					hora_salida:=min.hora_salida;
					venta:=0;
					while(min.destino <> valor_alto)and(min.destino = destino)and(min.fecha = fecha)and(min.hora_salida = hora_salida)do begin
						venta:= venta + min.asientos_dis_ven;
						minimo(det1,det2,reg1,reg2,min);
					end;
					read(mae,regm);
					while(regm.destino <> destino)and(regm.fecha <> fecha)and(regm.hora_salida <> hora_salida)do
						read(mae,regm);
					regm.asientos_dis_ven:= regm.asientos_dis_ven - venta;
					seek(mae,filePos(mae) -1);
					write(mae,regm);
				end;
			end;
		end;
		close(mae);
		close(det1);
		close(det2);
	end;
	procedure lista_menor(var mae:archivo);
	var
		regm:vuelo;
		cant:integer;
		t:text;
	begin
		reset(mae);
		assign(t,'lista_menores.txt');
		rewrite(t);
		writeln(t,'Lista de vuelos con menos cantidad de asientos que los pasados \n');
		write('ingrese una cantidad minimo de asientos: '); readln(cant);
		leer(mae,regm);
		while(regm.destino <> valor_alto)do begin
			if(regm.asientos_dis_ven < cant)then
				writeln(t,regm.destino,'  ',regm.fecha,'  ',regm.hora_salida,'  ',regm.asientos_dis_ven);
			leer(mae,regm);
		end;
		close(mae);
		close(t);
	end;
var
	mae:archivo;
	
begin
	assign(mae,'vuelos.dat');
	actualizar_maestro(mae);
	lista_menor(mae);
end.
