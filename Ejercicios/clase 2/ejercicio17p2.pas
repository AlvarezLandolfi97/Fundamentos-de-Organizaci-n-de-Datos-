{17. Una concesionaria de motos de la Ciudad de Chascomús, posee un archivo con
	 información de las motos que posee a la venta. De cada moto se registra: código, nombre,
	 descripción, modelo, marca y stock actual. Mensualmente se reciben 10 archivos detalles
	 con información de las ventas de cada uno de los 10 empleados que trabajan. De cada
	 archivo detalle se dispone de la siguiente información: código de moto, precio y fecha de la
	 venta. Se debe realizar un proceso que actualice el stock del archivo maestro desde los
	 archivos detalles. Además se debe informar cuál fue la moto más vendida.

NOTA: Todos los archivos están ordenados por código de la moto y el archivo maestro debe
ser recorrido sólo una vez y en forma simultánea con los detalles}
program alvar;
const
	valor_alto = 9999;
	c = 10;
type 
	str = string[20];
	moto = record
		cod:integer;
		nombre:str;
		descripcion:str;
		modelo:str;
		marca:str;
		stock:str;
	end;
	venta = record
		cod:integer;
		precio:real;
		fecha:str;
	end;
	maestro = file of moto;
	detalle = file of venta;
	detalles = array [1..c] of detalle;
	registros = array [1..c] of venta;
	
	procedure leer(var det:detalle; var reg:venta);
	begin
		if eof(det) then
			reg.cod:= valor_alto
		else
			read(det,reg);
	end;
	procedure minimo(var det:detalle; var reg:registros; var min:venta);
	var
		i,pos:integer;
	begin
		min.cod:= valor_alto;
		for i:= 1 to c do
			if(reg[i].cod < min.cod)then begin
				min:=reg[i];
				pos:= i;
			end;
		if(min.cod <> valor_alto) then
			leer(det[pos],reg[pos]);
	end;
var
	mae:maestro;
	det:detalles;
	reg:registros;
	regm:moto;
	min:venta;
	i,cod,cant,mas_vendida,cod_mas_vendida:integer;
	nom,nombre_mas_vendida,nombre_moto:str;
begin
	assign(mae,'agencia_motos.dat');
	reset(mae);
	for i:= 1 to c do begin
		str(i,nom);
		assign(det[i],'venta',nom,'.dat');
		reset(det[i]);
		leer(det[i],reg[i]);
	end;
	minimo(det,reg,min);
	while(min.cod <> valor:alto) do begin
		cod:= min.cod;
		cant:= 0;
		cant_mas_vendida:= -1;
		nombre_moto:= min.nombre;
		while(min.cod <> valor:alto)and(min.cod =cod)do begin
			cant:0 cant +1;
			minimo(det,reg,min);
		end;
		if(cant_mas_vendida < cant)then begin
			cant_mas_vendida:= cant;
			cod_mas_vendida:= cod;
			nombre_mas_vendida:= nombre_moto;
		end;
		read(mae,regm);
		while(regm.cod <> cod)do
			read(mae,regm);
		regm.stock:= regm.stock - cant;
		seek(mae,filePos(mae) -1);
		write(mae,regm);
	end;
	writeln('la moto mas vendida es ',nombre_mas_vendida,' con codigo ',cod_mas_vendida,', cantidad de ventas: ',cant_mas_vendida);
	for i:= 1 to c do
		close(det[i]);
	close(mae);
end.
