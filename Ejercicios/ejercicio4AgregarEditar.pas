{4. Agregar al menú del programa del ejercicio 3, opciones para:
* 
	a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
	   teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
	   un número de empleado ya registrado (control de unicidad).
	    
	b. Modificar edad a uno o más empleados.
	
	c. Exportar el contenido del archivo a un archivo de texto llamado
	   “todos_empleados.txt”.
	   
	d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
	   que no tengan cargado el DNI (DNI en 00).
	   
NOTA: Las búsquedas deben realizarse por número de empleado.}
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
	
	procedure SinDobleCero(var a:archivo);
	var
		e:empleado;
		txt:text;
	begin
		assign(txt,'faltaDNIEmpleado.txt');
		rewrite(txt);
		reset(a);
		while not eof(a) do begin
			read(a,e);
			if(e.dni <> 00)then begin
				write(a,e);
				writeln(txt,e.apellido,' ',e.nro,' ',e.edad,' ',e.dni,' ',e.nombre);
			end;
			read(a,e);
		end;
		close(a);
		close(txt);
	end;
	procedure exportarArchivo(var a:archivo);
	var
		e:empleado;
		txt:text;
	begin
		assign(txt,'todos_empleados.txt');
		rewrite(txt);
		reset(a);
		while not eof(a) do begin
			read(a,e);
			writeln(txt,e.apellido,' ',e.nro,' ',e.edad,' ',e.dni,' ',e.nombre);
		end;
		close(txt);
		close(a);
	end;
	procedure modificarEdad(var a:archivo);
	var
		cant,i:integer;
		e:empleado;
	begin
		cant:= filesize(a)-1;
		for i:= 0 to cant do begin
			read(a,e);
			seek(a,filePos(a)-1);
			e.edad:= e.edad +1;
			write(a,e);
		end;
		close(a);
	end;
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
	procedure agregarEmpleado(var a:archivo);
		procedure controlUnicidad(var a:archivo; apellido:str; var ok:boolean);
		var
			e:empleado;
		begin
			ok:=true;
			reset(a);
			if not eof(a) then begin
				read(a,e);
				while( not eof(a) and ok = true ) do begin
					if(e.apellido = apellido)then 
						ok:=false;
					read(a,e);
				end;
			end;
			close(a);
		end;	
	var
		e:empleado;
		ok:boolean;
	begin
		leerRegistro(e);
		while (e.apellido <> 'fin') do begin
			controlUnicidad(a,e.apellido,ok);
			if(ok = true) then begin
				reset(a);
				seek(a,filesize(a));
				write(a,e);
				close(a);
			end;
			leerRegistro(e);
		end;
	end;
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
			3:ListarMayores(a);
		else 
			writeln(' la opcion es invalida ');
		end;
		close(a);
	end;
	procedure crearArchivo(var a:archivo);
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
		writeln('Agregar Empleado---------------------------------------> c');
		writeln();
		writeln('modificar edad ----------------------------------------> d');
		writeln();
		writeln('Exportar Archivo --------------------------------------> e');
		writeln();
		writeln(' Exportar Sin Dni 00 ----------------------------------->f');
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
					'c':agregarEmpleado(a);
					'd':modificarEdad(a);
					'e':exportarArchivo(a);
					'f':sinDobleCero(a);
				else
					writeln(' opcion invalida');
				end;
				writeln('                       ---------------------- Menu ---------------------');
				writeln();
				writeln('crear registros de empleados --------------------------> a');
				writeln();
				writeln('enlistar Busquedas ------------------------------------> b');
				writeln();
				writeln('Agregar Empleado---------------------------------------> c');
				writeln();
				writeln('modificar edad ----------------------------------------> d');
				writeln();
				writeln('Exportar Archivo --------------------------------------> e');
				writeln();
				writeln(' Exportar Sin Dni 00 ----------------------------------->f');
				writeln();
				writeln('finalizar Menu ----------------------------------------> z');
				writeln();
				write(' ingrese una opcion: ');
				readln(opcion);
			end;
		end;
	end;
var
	a:archivo;
	nombreArc:str;
begin
	write('ingrese un nombre para el archivo: '); readln(nombreArc);
	assign(a,nombreArc);
	menu(a);
end.
