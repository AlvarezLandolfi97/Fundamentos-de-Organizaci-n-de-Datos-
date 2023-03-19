{Realizar un programa para una tienda de celulares, que presente un menú con opciones para:
* 
	a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
	   ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
	   correspondientes a los celulares, deben contener: código de celular, el nombre,
	   descripción, marca, precio, stock mínimo y el stock disponible.
	   * 
	b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
	   stock mínimo.
	   * 
	c. Listar en pantalla los celulares del archivo cuya descripción contenga una
	   cadena de caracteres proporcionada por el usuario.
	   * 
	d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
	   “celulares.txt” con todos los celulares del mismo. El archivo de texto generado
	   podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
	   debería respetar el formato dado para este tipo de archivos en la NOTA 2.
NOTA}
program celulares;
type	
	str = string[200];
	celular = record
		cod: integer;
		nombre,descripcion,marca:str;
		precio:real;
		stockMinimo,stockDisponible:integer;
	end;
	archivo = file of celular;
	{a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
	   ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
	   correspondientes a los celulares, deben contener: código de celular, el nombre,
	   descripción, marca, precio, stock mínimo y el stock disponible.
	   * }
	procedure generarApartir(var a:archivo; var t:text);
	var
		c:celular;
	begin
	
		assign(t,'Celulares.txt');
		reset(t);
		rewrite(a);
		while not eof(t) do begin
			readln(t,c.cod,c.precio,c.marca);
			readln(t,c.stockMinimo,c.stockDisponible,c.descripcion);
			readln(t,c.nombre);
			write(a,c);
		end;
		close(t);
		close(a);
	end;
	{b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
	   stock mínimo.}
	procedure debajoDeLaMinima(var a:archivo);
	var
		c:celular;
	begin
		reset(a);
		writeln(' celulare con stock por debajo del minimo ');
		writeln();
		while not eof(a) do begin
			read(a,c);
			if(c.stockDisponible < c.stockMinimo)then begin
				writeln('Codigo: ',c.cod,' Nombre: ',c.nombre,' Descripcion: ',c.descripcion,' Marca: ',c.marca,' Precio: ',c.precio:2,' Stock minimo: ',c.stockMinimo,' Stock disponible: ',c.stockDisponible);
				writeln();
			end;
			//{linea solo para corroborar}writeln('Codigo: ',c.cod,' Nombre: ',c.nombre,' Descripcion: ',c.descripcion,' Marca: ',c.marca,' Precio: ',c.precio,' Stock minimo: ',c.stockMinimo,' Stock disponible: ',c.stockDisponible);
		end;
		close(a);
		writeln();
	end;
	procedure listadoProporcionado(var a:archivo);
	var
		c:celular;
		descripcion:str;
	begin
		write('ingrese la descripcion del celular: '); readln(descripcion);
		reset(a);
		while not eof(a) do begin
			read(a,c);
			if(descripcion = c.descripcion) then begin
				writeln();
				writeln(' el celular que coincide con su descripcion es: ');
				writeln('Codigo: ',c.cod,' Nombre: ',c.nombre,' Descripcion: ',c.descripcion,' Marca: ',c.marca,' Precio: ',c.precio,' Stock minimo: ',c.stockMinimo,' Stock disponible: ',c.stockDisponible);
				writeln();
			end;
		end;
		close(a);			
	end;
	procedure exportarArchivo(var a:archivo);
	var
		c:celular;
		t:text;
	begin
		reset(a);
		assign(t,'Celulares.txt');
		rewrite(t);
		writeln('aun no entra al while');
		while not eof(a) do begin
			read(a,c);
			writeln(t,c.cod,' ',c.precio,' ',c.marca);
			writeln(t,c.stockMinimo,' ',c.stockDisponible,' ',c.descripcion);
			writeln(t,c.nombre);
			write('entro');
		end;
		close(a);
		close(t);
		writeln('Listo');
		readln();
	end;
	procedure menu(var a:archivo; var t:text);
	var
		opcion:str;
	begin
		writeln('       -----------------Menu---------------');
		writeln();
		writeln('Para generar un nuevo archivo a partir de “celulares.txt” ingrese ---> a');
		writeln();
		writeln('Listar en pantalla los celulares por debajo del minimo --------------> b');
		writeln();
		writeln('Listar en pantalla los celulares del archivo proporcionado ----------> c');
		writeln();
		writeln('Exportar archivo de carga como “celulares.txt” ----------------------> d');
		writeln();
		writeln('Para finalizar ingrese ----------------------------------------------> z');
		writeln();
		write('ingrese una opcion: '); readln(opcion);
		while( opcion <> 'z') do begin
			case opcion of
				'a':generarApartir(a,t);
				'b':debajoDeLaMinima(a);
				'c':listadoProporcionado(a);
				'd':exportarArchivo(a);
			else
				writeln('Opcion invalida');
			end;
			writeln('       -----------------Menu---------------');
			writeln();
			writeln('Para generar un nuevo archivo a partir de “celulares.txt” ingrese ---> a');
			writeln();
			writeln('Listar en pantalla los celulares por debajo del minimo --------------> b');
			writeln();
			writeln('Listar en pantalla los celulares del archivo proporcionado ----------> c');
			writeln();
			writeln('Exportar archivo de carga como “celulares.txt” ----------------------> d');
			writeln();
			writeln('Para finalizar ingrese ----------------------------------------------> z');
			writeln();
			write('ingrese una opcion: '); readln(opcion);
		end;
	end;
var
	a:archivo;
	t:text;
	nombre:str;
begin
	write('ingrese un nombre para guardar el archivo: '); //readln(nombre);
	nombre:='c';
	assign(a,nombre);
	menu(a,t);
end.
