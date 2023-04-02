program ej1P2;
type
	str= string[20];
	ingreso = record
		cod:integer;
		nombre:str;
		monto:real;
	end;
	ingresos = file of ingreso;
	procedure compactar(var i:ingresos);
	var
		ingCompactado:ingresos;
		ing:ingreso;
		trabajador:ingreso;
	begin
		assign(i,"todosLosIngresos"); assign(ingCompactado,"ingresoCompactado");
		reset(i);
		rewrite(ingCompactado);
		if not eof(i) then begin
			read(i,ing);
			while( not eof(i) )do begin
				trabajador.nombre:=ing.nombre;
				trabador.cod:=ing.cod;
				trabajador.monto:=0;
				while (not eof(i))and(ing.nombre = trabajador.nombre )do begin
					monto:= monto + ing.monto;
					read(i,ing);
				end;
				seek(i,filePos(i) -1);
				write(i,trabajador);
			end;
		end;
		
	end;
var
	i:ingresos;
begin
	compactar(i);
end.
