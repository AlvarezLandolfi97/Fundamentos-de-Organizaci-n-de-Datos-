{16. La editorial X, autora de diversos semanarios, posee un archivo maestro con la
	 información correspondiente a las diferentes emisiones de los mismos. De cada emisión se
	 registra: fecha, código de semanario, nombre del semanario, descripción, precio, total de
	 ejemplares y total de ejemplares vendido.
	 Mensualmente se reciben 100 archivos detalles con las ventas de los semanarios en todo el
	 país. La información que poseen los detalles es la siguiente: fecha, código de semanario y
	 cantidad de ejemplares vendidos. Realice las declaraciones necesarias, la llamada al
	 procedimiento y el procedimiento que recibe el archivo maestro y los 100 detalles y realice la
	 actualización del archivo maestro en función de las ventas registradas. Además deberá
	 informar fecha y semanario que tuvo más ventas y la misma información del semanario con
	 menos ventas.

Nota: Todos los archivos están ordenados por fecha y código de semanario. No se realizan
	  ventas de semanarios si no hay ejemplares para hacerlo}
program alvar;
const
	valor_alto = 'zzzz';
	c = 100;
type
	str = string[20];
	emision = record
		fecha:str;
		cod_semanario:integer;
		nombre_semanario:str;
		descripcion:str;
		precio:real;
		cant_ejemplares:integer;
		cant_vendidos:integer;
	end;
	sem = record
		fecha:str;
		cod_semanario:integer;
		cant_vendida:integer;
	end;
	maestro = file of emision;
	detalle = file of sem;
	detalles = array [1..c] of detalle;
	registros = array [1..c] of sem;
	procedure leer(var det:detalle; var reg:sem);
	begin
		if eof(det) then
			reg.fecha:= valor_alto
		else
			read(det,reg);
	end;
	procedure minimo(var det:detalles; var reg:registros; var min:sem);
	var
		i,pos:integer;
	begin
		min.fecha:= valor_alto; min.cod_semanario:= 9999;
		for i:= 1 to c do
			if(reg[i].fecha <= min.fecha)and(reg[i].cod_semanario < min.cod_semanario)then begin
				min:= reg[i];
				pos:= i;
			end;
		if (min.fecha <> valor_alto)then
			leer(det[pos],reg[pos]);
	end;
	procedure actualizar_maestro(var mae:maestro; var det:detalles);
	var
		reg:registros;
		regm:emision;
		sem_min,sem_max,min:sem;
		i,semanario,venta:integer;
		nom,fecha:str;
	begin
		reset(mae);
		for i:= 1 to c do begin
			str(i,nom);
			assign(det[i],'semanario',i,'.dat');
			reset(det[i]);
			leer(det[i],reg[i]);
		end;
		sem_min.cant_vendida:= valor_alto; sem_max.cant_vendida:= -1;
		minimo(det,reg,min);
		while(min.fecha <> valor_alto)do begin
			fecha:= min.fecha;
			while(min.fecha <> valor_alto)and(min.fecha = fecha) do begin
				semanario:= min.cod_semanario;
				venta:= 0;
				while(min.fecha <> valor_alto)and(min.fecha = fecha)and(min.cod_semanario = semanario)do begin
					venta:= venta + min.cant_vendida;
					minimo(det,reg,min); 
				end;
				read(mae,regm);
				while(regm.fecha <> fecha)or(regm.cod_semanario <> semanario)do
					read(mae,regm);
				regm.cant_vendida:= regm.cant_vendida + venta;
				if(sem_mix.cant_vendida > regm.cant_vendida)then
					sem_min:= regm;
				else 
					if(sem_max.cant_vendida < regm.cant_vendida)then
						sem_max:= regm;
				seek(mae,filePos(mae) -1);
				write(mae,regm);
			end;
		end;
		writeln('la fecha con mas ventas es 'sem_max.fecha,' semanario ',sem_max.cod_semanario,' con un total de ventas de ',sem_max.cant_vendida);
		writeln();
		writeln('la fecha con menos ventas es 'sem_mix.fecha,' semanario ',sem_mix.cod_semanario,' con un total de ventas de ',sem_mix.cant_vendida);
		close(mae);
		for i:= i to c do
			close(det[i]);
	end;
var
	mae:maestro;
	det:detalles;
begin
	assign(mae,'emisiones.dat');
	actualizar_maestro(mae,det);
end.
