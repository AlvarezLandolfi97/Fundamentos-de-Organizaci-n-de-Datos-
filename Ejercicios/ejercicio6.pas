{6. Agregar al menú del programa del ejercicio 5, opciones para:
	a. Añadir uno o más celulares al final del archivo con sus datos ingresados por teclado.
	* 
	b. Modificar el stock de un celular dado.
	
	c. Exportar el contenido del archivo binario a un archivo de texto denominado:

	”SinStock.txt”, con aquellos celulares que tengan stock 0.

NOTA: Las búsquedas deben realizarse por nombre de celular.}
program celulares;

uses sysutils;
 
type	
	str = string[200];
	celular = record
		cod: integer;
		nombre,descripcion,marca:str;
		precio:real; 
		stockMinimo,stockDisponible:integer;
	end;
	archivo = file of celular;
	
	procedure modificarStock(var a:archivo);
	var
		c:celular;
		edit:str;
	begin
		write('Ingrese en nombre de un celular a modificar: ');
		readln(edit);
		if FileExists('celulares.dat')  then begin
			while not eof(a) do begin
				read(a,c);
				if(c.nombre = edit ) then begin
					c.StockDisponible:= c.StockDisponible +1;
					seek(a,FilePos(a)-1);
					write(a,c);
				end;
			end;
		end;
	end;
	procedure exportarSinStock(var a:archivo);
	var
		c:celular;
		t:text;
		ok:boolean;
	begin
		assign(t,'SinStock.txt');
		rewrite(t);
		reset(a);
		ok:= false;
		while( not eof(a) and not ok ) do begin
			read(a,c);
			if(c.stockDisponible = 0) then begin
				writeln(t,c.cod,c.precio,c.marca);
				writeln(t,c.stockMinimo,c.stockDisponible,c.descripcion);
				writeln(t,c.nombre);
				ok:= true;
			end;
		end;
		close(t);
		close(a);
	end;
	procedure masCelulares(var a:archivo);
		procedure leerRegistro(var c:celular);
		begin
			writeln('ingrese el codigo "-1" para dejar de cargar celulares');
			writeln();
			write('ingrese codigo: '); 
			readln(c.cod);
			if(c.cod <> -1)then begin
				write('ingrese nombre: ');
				readln(c.nombre);
				write('ingrese descripcion: ');
				readln(c.descripcion);
				write('ingrese marca: ');
				readln(c.marca);
				write('ingrese precio: ');
				readln(c.precio);
				write('ingrese stockMinimo: ');
				readln(c.stockMinimo);
				write('ingrese stockDisponible: ');
				readln(c.stockDisponible);
			end;
		end;
		procedure cargaArc(var a:archivo);
		var
			c:celular;
		begin
			leerRegistro(c);
			while (c.cod <> -1) do begin
				write(a,c);
				leerRegistro(c);
			end;
		end;
		
	
	begin
		if FileExists('celulares.dat') then begin
			reset(a);
			seek(a,FilePos(a));
			cargaArc(a);
		end
		else begin
			rewrite(a);
			cargaArc(a);
		end;
		close(a);
	end;
			
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
		rewrite(t);
		assign(t,'Celulares.txt');
		rewrite(t);
		writeln('aun no entra al while');
		while not eof(a) do begin
			read(a,c);
			writeln(t,c.cod,c.precio,c.marca);
			writeln(t,c.stockMinimo,c.stockDisponible,c.descripcion);
			writeln(t,c.nombre);
		end;
		close(a);
		close(t);
		writeln('Listo');
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
		writeln('Agregar uno o más celularez -----------------------------------------> e');
		writeln();
		writeln('Exportar celulares con stock 0 --------------------------------------> f');
		writeln();
		writeln('Modificar Stock -----------------------------------------------------> g');
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
				'e':masCelulares(a);
				'f':exportarSinStock(a);
				'g':modificarStock(a);
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
			writeln('Agregar uno o más celularez -----------------------------------------> e');
			writeln();
			writeln('Exportar celulares con stock 0 --------------------------------------> f');
			writeln();
			writeln('Modificar Stock -----------------------------------------------------> g');
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
