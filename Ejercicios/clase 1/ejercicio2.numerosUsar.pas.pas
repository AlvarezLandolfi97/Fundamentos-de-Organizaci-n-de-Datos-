program enterosUsados;
type
	fichero = file of integer;
	str = string[20];
var
	archivo:fichero;
	cant,nro,suma:integer;
	prom:real;
begin
    cant:=0;
    suma:=0;
    assign(archivo,'Emanuel.arc');
	reset(archivo);	
	while not eof(archivo)do begin
		read(archivo,nro);
		if(nro > 1500)then
			cant:= cant +1;
			suma:=suma+nro;
		writeln(nro);
	end;
	close(archivo);
	writeln();
	writeln();
	writeln(' la cantidad de numeros más grandes a 1500 es: ',cant);
	prom:=suma/cant;
	writeln(' el promedio es: ',prom:2);
	readln();
end.
