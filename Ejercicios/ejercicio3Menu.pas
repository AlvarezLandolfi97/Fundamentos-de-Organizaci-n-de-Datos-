{3. Realizar un programa que presente un menú con opciones para:
		a. Crear un archivo de registros no ordenados de empleados y completarlo con
		   datos ingresados desde teclado. De cada empleado se registra: número de
		   empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
		   DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
		   
		b. Abrir el archivo anteriormente generado y
		   i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
		      determinado.
		      
           ii. Listar en pantalla los empleados de a uno por línea.
           
           iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
           
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.}
program menu;
type
	str = string[20];
	empleado = record
		nro:integer;
		apellido:str;
		nombre:str;
		edad:integer;
		dni:integer;
	end;
	archivo = file of empleado;

	procedure manipulacionArchivos(var a:archivo);
		procedure ListarPorApellido(var a:archivo);
		var
			e:empleado;
			apellido:str;
		begin
			write(' ingrese un Apellido de empleado a buscar: ');
			readln(apellido);
			writeln('Empleados con Apellido ',apellido,': ');
			writeln();
			while not eof(a) do begin
				read(a,e);
				if(e.apellido = apellido)then begin
					writeln('Nombre ',e.nombre,' Apellido ',e.apellido,' numero de empleado ',e.nro,' edad ',e.edad,' dni ',e.dni);
					writeln();
				end;
			end;
		end;
		procedure ListarEmpleados(var a:archivo);
		var
			e:empleado;
		begin
			writeln(' Lista de todos los emplados: ');
			writeln();
			while not eof(a) do begin
				read(a,e);
				writeln('Nombre ',e.nombre,' Apellido ',e.apellido,' numero de empleado ',e.nro,' edad ',e.edad,' dni ',e.dni);
				writeln();
			end;
		end;
		procedure ListarMayores(var a:archivo);
		var
			e:empleado;
		begin
			writeln('Lista de empleados mayor de 70 años: ');
			writeln();
			while not eof(a) do begin
				read(a,e);
				if(e.edad > 70) then begin
					writeln('Nombre ',e.nombre,' Apellido ',e.apellido,' numero de empleado ',e.nro,' edad ',e.edad,' dni ',e.dni);
					writeln();
				end;
			end;
		end;
	var
		opcion:integer;
	begin
		writeln('           ----------------------Menu--------------------');
		writeln();
		writeln(' Listar empleados con apellido tal ------> 1');
		writeln();
		writeln('Listar empledos en linea ----------------> 2');
		writeln();
		writeln('Listar a los empleados mayores ----------> 3');
		writeln();
		write('ingresa la opcion deseada: ');
		readln(opcion);
		reset(a);
		case opcion of
			1:ListarPorApellido(a);
			2:ListarEmpleados(a);
			3:
		else 
			writeln(' la opcion es invalida ');
		end;
		close(a);
	end;
	procedure crearArchivo(var a:archivo);
		procedure leerRegistro(var e:empleado);
		begin
			write(' ingrese un Apellido: ');
			readln(e.apellido);
			if(e.apellido <> 'fin')then begin
				write('ingrese un nombre: ');
				readln(e.nombre);
				write('ingrese numero de empleado: ');
				readln(e.nro);
				write('ingrese edad: ');
				readln(e.edad);
				write('ingrese dni: ');
				readln(e.dni);
			end;
		end;
	var
		e:empleado;
	begin
		rewrite(a);
		leerRegistro(e);
	    while(e.apellido <> 'fin')do begin
			write(a,e);
			leerRegistro(e);
		end;
		close(a);
	end;
	procedure menu(var a:archivo);
	var
		opcion:str;
	begin
		writeln('                       ---------------------- Menu ---------------------');
		writeln();
		writeln('crear registros de empleados --------------------------> a');
		writeln();
		writeln('enlistar Busquedas ------------------------------------> b');
		writeln();
		writeln('finalizar Menu ----------------------------------------> z');
		writeln();
		write(' ingrese una opcion: ');
		readln(opcion);
		if(opcion <> 'z')then begin
			while(opcion <> 'z')do begin
				case opcion of
					'a':crearArchivo(a);
					'b':manipulacionArchivos(a);
				else
					writeln(' opcion invalida');
				end;
				writeln('                       ---------------------- Menu ---------------------');
				writeln();
				writeln('crear registros de empleados ---> a');
				writeln();
				writeln('enlistar Busquedas ------------------------------------> b');
				writeln();
				writeln('finalizar Menu --------------------------> z');
				writeln();
				write(' ingrese una opcion: ');
				readln(opcion);
			end;
		end;
	end;
var
	a:archivo;
	nombreArc:str
begin
	write('ingrese un nombre para el archivo: '); readln(nombreArc);
	assign(a,nombreArc);
	menu(a);
end.
