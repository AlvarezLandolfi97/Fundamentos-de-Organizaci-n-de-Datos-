{ 	Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
	cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
	(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
	un archivo detalle con el código de alumno e información correspondiente a una materia
	(esta información indica si aprobó la cursada o aprobó el final).
	
	Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
	haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
	programa con opciones para:
		a. Actualizar el archivo maestro de la siguiente manera:

			i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.

			ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin final.

		b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
		   con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.

	NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.txt”.

}
program ejercicio2P2;
type
	str=string[20];
	alumno= record
		cod:integer;
		apellido,nombre:str;
		cursadas:integer;
		cerradas:integer;
	end;
	materia= record
		cod:integer;
		aprobo:boolean;
	end;
	maestro = file of alumno;
	detalle = file of materia;
	
	procedure actualizarMaestro(var mae:maestro; var det:detalle);
	var
		regm:alumno;
		regd:materia;
		finales,cursada:integer;
	begin
		reset(mae); reset(det);
		if filesize(det) <> 0 then begin
			while not eof(dat) do begin
				read(mae,regm);
				read(det,regd);
				finales:= 0; cursada:= 0;
				while (regm.cod <> regd.cod) do
					read(mae,regm);
				while  (regm.cod = regd.cod) do begin
					if (regd.aprobo = true)then
						finales:= finales +1
					else
						cursada:= cursada +1;
					read(det,regd);
				end;
				seek(mae,filePos(mae)-1);
				seek(det,filePos(det)-1);
				regm.cursadas:= regm.cursadas+ cursadas;
				regm.cerradas:= regm.cerradas+ finales;
				write(mae,regm);
			end;
			close(mae);
			close(det);
		end
		else
			writeln(' no hay materias que actualizar ');
	end;
	procedure listarMateriasNoCerradas(var mae:maestro);
	var
		regm:alumno;
		alum:text;
	begin
		assign(alum,"alumnos.txt");
		rewrite(alum);
		reset(mae);
		while not eof(mae) do begin
			read(mae,regm);
			if(regm.cursadas >=4)then 
				writeln(alum,regm.cod,' ',regm.cursadas,' ',regm.finales,' ',regm.nombre,' ',regm.apellido);
		end;
		close(mae);
		close(alum);
	end;
var
	det:detalle;
	mae:maestro;
	opcion:char;
begin
	writeln(' Menu ');
	writeln();
	writeln('" a " para Crear el archivo maestro a partir de un archivo de texto llamado “alumnos.txt”');
	writeln();
	writeln('" b " para Crear el archivo detalle a partir de en un archivo de texto llamado “detalle.txt”');
	writeln();
	write('ingrese una opcion: '); readln(opcion);
	assign(mae,"maestro.dat"); assign(det,"detalle.dat");
	case opcion of
		"a": actualizarMaestro(mae,det);
		"b": listarMateriasNoCerradas(mae);
	else
		writeln('opcion incorrecta?);
	end;
end.
