{13. Suponga que usted es administrador de un servidor de correo electrónico. En los logs
	 del mismo (información guardada acerca de los movimientos que ocurren en el server) que
	 se encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información:
	
	 nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. Diariamente el
	 servidor de correo genera un archivo con la siguiente información: nro_usuario,
	 cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los
	 usuarios en un día determinado. Ambos archivos están ordenados por nro_usuario y se
	 sabe que un usuario puede enviar cero, uno o más mails por día.
	 * 
	 a- Realice el procedimiento necesario para actualizar la información del log en
		un día particular. Defina las estructuras de datos que utilice su procedimiento.
	 b- Genere un archivo de texto que contenga el siguiente informe dado un archivo
		detalle de un día determinado:
			nro_usuarioX…………..cantidadMensajesEnviados………….
			
			nro_usuarioX+n………..cantidadMensajesEnviados

Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que
	  existen en el sistema.
}
program alvarezlandolfi;
const
	valor_alto = 9999;
type
	str = string[20];
	server = record
		nro_usuario:integer;
		nombre_usuario:str;
		nombre,apellido:str;
		cant_mail_enviados:integer;
	end;
	diario = record
		nro_usuario:integer;
		cuenta_destino:integer;
		cuerpo_mensaje:str;
	end;
	maestro = file of server;
	detalle = file of diario;
	procedure leer(var det:detalle; var reg:diario);
	begin
		if eof(det) then
			reg.nro_usuario:= valor_alto
		else
			read(det,reg);
	end;
var
	mae:maestro;
	det:detalle;
	regm:server;
	reg:diario;
	nro_usuario,cant:integer;
	t:text;
begin
	assign(mae,'log.dat');
	assign(det,'diario.dat');
	assign(t,'log_dia.txt');
	rewrite(t);
	reset(mae);
	reset(det);
	leer(det,reg);
	while(reg.nro_usuario <> valor_alto)do begin
		nro_usuario:= reg.nro_usuario;
		cant:= 0;
		while(reg.nro_usuario <> valor_alto)and(reg.nro_usuario = nro_usuario)do begin
			cant:= cant + 1;
			leer(det,reg);
		end;
		read(mae,regm);
		while(regm.nro_usuario <> nro_usuario)do
			read(mae,regm);
		regm.cant_mail_enviados:= regm.cant_mail_enviados + cant;
		writeln(t,'Usuario: ',nro_usuario,' cantidad de mensajes enviados: ',cant);
		seek(mae,filePos(mae) -1);
		write(mae,regm);
	end;
	close(mae);
	close(det);
	close(t);
end.
