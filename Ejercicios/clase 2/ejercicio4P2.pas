{4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}
program maquin;
const
	c = 5;
	valor_alto = 9999;
type
	//f = record
	//	dia,mes,anio:integer
	//end;
	maquina = record
		cod_usuario:integer;
		fecha:integer;
		tiempo_sesion:real;
	end;
	archivo = file of maquina;
	maquinas = array [1..c] of archivo;
	registros = array [1..c] of maquina;
	
	procedure leer(var ar:archivo; var maq:maquina);
	begin
		if eof(ar) then
			maq.cod_usuario:= valor_alto
		else
			read(ar,maq);
	end;
	procedure minimo(var dets:maquinas; var regs:registros; var min:maquina);
	var
		i,pos:integer;
	begin
		min.cod_usuario:= valor_alto; min.fecha:= valor_alto; 
		for i:= 1 to c do 
			if(regs[i].cod_usuario <= min.cod_usuario)and(regs[i].fecha < min.fecha)then begin
				min:=regs[i];
				pos:= i;
			end;
		if(min.cod_usuario <> valor_alto)then
			leer(dets[pos],regs[pos]);
			
	end;
	procedure genera_maestro(var det:archivo; var mae:archivo);
	var
		dets:maquinas; { detalles archivos}
		regs:registros;{ registros }
		regm:maquina; { acumulador }
		min:maquina;
		i,cod:integer;
		f,nom:string[15];
		t:real;
	begin
		for i:= 1 to c do begin
			str(i,nom);
			assign(dets[i],'detalle'+nom);
			reset(dets[i]);
			leer(dets[i],regs[i]);
		end;
		assign(mae,'/var/log');
		rewrite(mae);
		minimo(dets,regs,min);
		while( min.cod_usuario <> valor_alto ) do begin
			cod:= min.cod_usuario;
			while( min.cod_usuario <> valor_alto ) and ( min.cod_usuario = cod ) do begin
				f:= min.fecha;
				t:=0;
				while( min.cod_usuario <> valor_alto ) and ( min.cod_usuario = cod ) and ( min.fecha = f ) do begin
					t:= t + min.tiempo_sesion;
					minimo(dets,regs,min);
				end;
				regm.cod_usuario:=cod;
				regm.fecha:= f;
				regm.tiempo_sesion:= t;
				write(mae,regm);
			end;
		end;
		
		for i:= 1 to c do
			close(dets[i]);
		close(mae)M
	end;
var
	mae:archivos;
	det:archivo;
begin
	genera_maestro(det,mae);
end.
