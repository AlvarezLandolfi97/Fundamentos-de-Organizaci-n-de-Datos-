program numerosSinOrden;
type
	fichero = file of integer;
	str = string[20];
	
var
	archivo:fichero;
	nro:integer;
	nombre:str;
begin
	write('ingrese un nombre para el archivo: ');
	readln(nombre);
	assign(archivo,nombre);
	rewrite(archivo);
	write('ingrese un número entero: ');
	readln(nro);
	while(nro <> 300)do begin
		write(archivo,nro);
		write('ingrese otro número: ');
		readln(nro);
	end;
	close(archivo);
end.
