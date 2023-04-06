{8. Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
	los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
	cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
	mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
	cliente.

	Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la
	empresa.
	El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
	mes, día y monto de la venta.

	El orden del archivo está dado por: cod cliente, año y mes.

Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras.}
program cuen;
const
	valor_alto = 9999;
type
	str = string[21];
	venta = record
		cod_cliente:integer;
		nombre_cliente:str;
		apellido_cliente:str;
		anio,mes,dia:integer;
		monto:real;
	end;
	maestro = file of venta;
	procedure leer(var mae:maestro; var reg:venta);
	begin
		if eof(mae) then
			reg.cod_cliente:= valor_alto
		else
			read(mae,reg);
	end;
var
	mae:maestro;
	reg:venta;
	cod,anio,mes:integer;
	monto_total,monto_anio,monto_mes:real;
begin
	assign(mae,'maestro.dat');
	reset(mae);
	leer(mae,reg);
	while( reg.cod_cliente <> valor_alto) do begin
		cod:= reg.cod_cliente;
		monto_total:=0;
		anio:= reg.anio;
		monto_anio:=0;
		while( reg.cod_cliente <> valor_alto )and(reg.cod_cliente = cod)and( reg.anio = anio)do begin
			monto_mes:=0;
			mes:=reg.mes;
			while ( reg.cod_cliente <> valor_alto )and(reg.cod_cliente = cod)and( reg.anio = anio)and( reg.mes = mes )do begin
				monto_mes:= monto_mes + reg.monto;
				leer(mae,reg);
			end;
			writeln(' Cliente numero: ',reg.cod_cliente,' nombre: ',reg.nombre_cliente,' apellido: ',reg.apellido_cliente);
			writeln('compro por $ ',monto_mes,' en el mes ',mes,' anio ',anio);
			monto_anio:= monto_anio + monto_mes;
		end;
		writeln(' Cliente numero: ',reg.cod_cliente,' nombre: ',reg.nombre_cliente,' apellido: ',reg.apellido_cliente);
		writeln('compro por $ ',monto_anio,' en el anio ',anio);
		monto_total:= monto_total + monto_anio;
	end;
	write( ' monto total vendida por la emprsa a clientes: ',monto_total);
	close(mae);
end.
