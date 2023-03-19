{7. Realizar un programa que permita:
	a. Crear un archivo binario a partir de la información almacenada en un archivo de texto.
	El nombre del archivo de texto es: “novelas.txt”

	b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
	una novela y modificar una existente. Las búsquedas se realizan por código de novela.
	
NOTA: La información en el archivo de texto consiste en: código de novela, nombre,
género y precio de diferentes novelas argentinas. De cada novela se almacena la
información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente
información: código novela, precio, y género, y la segunda línea almacenará el nombre
de la novela.}
program eje7;

uses sysutils;

type
	str= string[50];
	novela=record
		cod:integer;
		nombre:str;
		genero:str;
		precio:real; { esta esta en duda ya que el enunciaddo dice, de diferentes novelas argentinas }
	end;
	archivo = file of novela;
	
	procedure crearAPartirdetxt( var a:archivo);
	var
		n:novela;
		t:text;
	begin
		if fileexists('novelas.txt')then begin
			assign(a,'novelas.dat');
			assign(t,'novelas.txt');
			rewrite(a);
			reset(t);
			while not eof(t) do begin
				readln(t,n.cod,n.precio,n.genero);
				readln(t,n.nombre);
				write(a,n);
			end;
			close(a);
			close(t);
		end
		else begin
			writeln('*****************************************');
			writeln(' No existe el archivo "novelas.txt" ');
			writeln('*****************************************');
		end;
	end;
	{b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
	una novela y modificar una existente. Las búsquedas se realizan por código de novela.}
	procedure modificarArchivo(var a:archivo);
		procedure leerRegistro(var n:novela);
		begin
			write('ingrese el codigo de novela: ');
			readln(n.cod);
			write('Ingrese el nombre: ');
			readln(n.nombre);
			write('ingrese el genero: ');
			readln(n.genero);
			write('ingrese el precio: ');
			readln(n.precio);
		end;
	var
		n:novela;
		cod:integer;
		ok:boolean;
	begin
		write('ingrese un codigo de novela a midificar: ');
		readln(cod);
		if fileexists('novelas.dat') then begin
			reset(a);
			seek(a,filePos(a));
			write(a,n);
			ok:=false;
			while not eof(a) and not ok do begin
				seek(a,0);
				read(a,n);
				if(n.cod = cod)then begin
					n.precio:= n.precio +1;
					seek(a,filepos(a)-1);
					write(a,n);
					ok:=true;
				end;
				close(a);
			end;
		end
		else begin
			writeln('*****************************************');
			writeln(' No existe el archivo "novelas.dat" ');
			writeln('*****************************************');
		end;
	end;
var
	a:archivo;
begin
	crearAPartirdetxt(a);
	modificarArchivo(a);
end.
