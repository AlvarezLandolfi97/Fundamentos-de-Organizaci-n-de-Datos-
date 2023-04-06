{7- El encargado de ventas de un negocio de productos de limpieza desea administrar el
	stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos
	los productos que comercializa. De cada producto se maneja la siguiente información:
	código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
	
	Diariamente se genera un archivo detalle donde se registran todas las ventas de productos
	realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas.

Se pide realizar un programa con opciones para:
	a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
		● Ambos archivos están ordenados por código de producto.
		● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
		  archivo detalle.
		● El archivo detalle sólo contiene registros que están en el archivo maestro.
	b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
	   stock actual esté por debajo del stock mínimo permitido.}
program ven;
const 
	valor_alto= 9999;
type	
	str = string[20];
	producto = record
		cod_producto:integer;
		nombre:str;
		precio:real;
		stock:integer;
		stock_min:integer;
	end;
	venta = record
		cod_producto:integer;
		cant_vendida:integer;
	end;
	maestro = file of producto;
	detalle = file of venta;
	
	procedure leer(var det:detalle; var regd:venta);
	begin
		if eof(det) then
			regd.cod_producto:= valor_alto
		else
			read(det,regd);
	end;
	procedure actualizar_maestro(var mae:maestro; var det:detalle);
	var
		regm:producto;
		regd:venta;
		cod,cant:integer;
	begin
		reset(mae);
		reset(det);
		leer(det,regd);
		while( regd.cod_producto <> valor_alto) do begin
			cod:= regd.cod_producto;
			cant:=0;
			read(mae,regm);
			while(regd.cod_producto <> regm.cod_producto)do
				read(mae,regm);
			while(regd.cod_producto = cod)do begin
				cant:= cant + regd.cant_vendida;
				leer(det,regd);
			end;
			regm.stock:= regm.stock - cant;
			seek(mae,filePos(mae)-1);
			write(mae,regm);
		end;
		close(mae);
		close(det);
	end;
	procedure leerm(var mae:maestro; var regm:producto);
	begin
		if eof(mae) then
			regm.cod_producto:= valor_alto
		else
			read(mae,regm);
	end;
	procedure exportar_faltantes(var mae:maestro);
	var
		regm:producto;
		t:text;
	begin
		assign(t,'stock_minimo.txt');
		rewrite(t);
		leerm(mae,regm);
		while( regm.cod_producto <> valor_alto)do begin
			if(regm.stock < regm.stock_min) then
				writeln(t,regm.cod_producto,' ',regm,precio,' ',regm.stock,' ',regm.stock_min,' ',regm.nombre);
			leerm(mae,regm);
		end;
		close(mae);
		close(t);
	end;
var
	mae:maestro;
	det:detalle;
	opcion:integer;
begin
	assign(mae,'maestro.dat');
	assign(det,'detalle.dat');
	writeln('1.-  Para actualizar');
	writeln();
	writeln('2.-  Para exportar los productos en falta');
	writeln(); 
	readln(opcion);
	if(opcion = 1)then
		actualizar_maestro(mae,det)
	else
		if(opcion = 2)then
			exportar_faltantes(mae)
		else
			writeln('opcion invalida');
end. 
