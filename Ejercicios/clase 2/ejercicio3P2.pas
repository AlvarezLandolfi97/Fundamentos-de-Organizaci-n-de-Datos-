{	Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
	De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
	stock mínimo y precio del producto.
	
	Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
	debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
	maestro. La información que se recibe en los detalles es: código de producto y cantidad
	vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
	descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
	debajo del stock mínimo.

	Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
		  puede venir 0 o N registros de un determinado producto.
}
program ejercicio3P2;
const
	valorAlto=9999;
type
	str= string[20];
	producto = record
		cod:integer;
		nombre,descripcion:str;
		stock,stockMin:integer;
		precio:real;
	end;
	venta = record
		cod,cantVendida:integer;
	end;
	maestro = file of producto;
	detalle = file of venta;
	detalles = array [1..30] of detalle;
	registros = array [1..30] of venta;
procedure leerD(var det:detalle; var regd:venta);
begin
	if( eof(det))then
		regd.cod:=valorAlto
	else
		read(det,regd);
end; 
procedure leerM(var mae:maestro; var reg:producto);
begin
	if eof(mae) then
		reg.cod := valorAlto
	else
		read(mae,reg);
end;
procedure leerT(var t:text; var reg:producto);
begin
	if eof(t) then
		reg.cod := valorAlto
	else
		read(t,reg);
end;
procedure minimo(var dets:detalles; var regs:registros; var min:venta);
var
	i,pos:integer;
begin
	min.cod:= valorAlto;
	for i:= 1 to 30 do 
		if(regs[i].cod < min.cod)then begin
			min:=regs[i];
			pos:=i;
		end;
	if(min.cod <> valorAlto)then 
		leerD(dets[pos],regs[pos]);
end;
procedure actualizarMaestro(var mae:maestro; var dets:detalles);
var
	regm:producto;
	regs:registros;
	i,cod,cant:integer;
	min:venta;
begin
	for i:= 1 to 30 do begin
		reset(dets[i]);
		leerD(dets[i],regs[i]);
	end;
	minimo(dets,regs,min);
	while(min.cod <> valorAlto)do begin
		cod:= min.cod;
		cant:=0;
		while (min.cod <> valorAlto) and (min.cod = cod) do begin
			cant:=cant+min.cantVendida;
			minimo(dets,regs,min);
		end;
		leerM(mae,regm);
		while(regm.cod <> cod) do
			read(mae,regm);
		regm.stock:= regm.stock - cant;
		seek(mae,filePos(mae)-1);
		write(mae,regm);
	end;
	close(mae);
	for i:= 1 to 30 do 
		close(dets[i]);
end;
procedure informar(var tex:text);
var
	reg:producto;
begin
	reset(tex);
	leerT(tex,reg);
	while( reg.cod <> valorAlto) do begin
		writeln('codigo: ',reg.cod,' nombre: ',reg.nombre,' stock disponible: ',reg.stock,' stock minimo: ',reg.stockMin,' precio: ',reg.precio,' descripcion: ',reg.descripcion);
		leerT(tex,reg);
	end;
	close(tex);
end;
procedure stockMinimo(var mae:maestro);
var
	regm:producto;
	tex:text;
begin
	reset(mae);
	assign(tex,'aReponer.txt');
	rewrite(tex);
	leerM(mae,regm);
	while (regm.cod <> valorAlto) do begin
		if(regm.stock < regm.stockMin)then
			writeln(tex,regm.nombre,' ',regm.stock,' ',regm.precio,' ',regm.descripcion);
		leerM(mae,regm);
	end;
	close(mae);
	close(tex);
	informar(tex);
end;
var
	mae:maestro;
	dets:detalles;
	i:integer;
	nombre:str;
begin
	assign(mae,'maestro.dat');
	reset(mae);
	for i:= 1 to 30 do begin
		nombre:='sede'+i;
		assign(dets[i],nombre);
		reset(dets[i]);
	end;
	actualizarMaestro(mae,dets);
	stockMinimo(mae);
end.






