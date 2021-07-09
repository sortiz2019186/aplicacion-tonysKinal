/*
Shandel Noe Ortiz Morales ---
*/

# --- Creación de la Base de Datos ---
Drop database if exists DBTonysKinal2019186;
Create database DBTonysKinal2019186;
Use DBTonysKinal2019186;


# --- Creación de las entidades ---
Create table Empresas(
	codigoEmpresa int not null auto_increment,
    nombreEmpresa varchar(150) not null,
    direccion varchar(150) not null,
    telefono varchar(10) not null,
    primary key PK_codigoEmpresa (codigoEmpresa)
);

Create table Presupuesto(
	codigoPresupuesto int not null auto_increment,
    fechaSolicitud date not null,
    cantidadPresupuesto decimal(10,2) not null,
    codigoEmpresa int not null,
    primary key PK_codigoPresupuesto (codigoPresupuesto),
    constraint FK_Presupuesto_Empresas
		foreign key (codigoEmpresa) 
        references Empresas(codigoEmpresa)
);

Create table Servicios(
	codigoServicio int not null auto_increment,
    fechaServicio date not null,
    tipoServicio varchar(100) not null,
    horaServicio time not null,
    lugarServicio varchar(100) not null,
    telefonoContacto varchar(10) not null,
    codigoEmpresa int not null,
    primary key PK_codigoServicio(codigoServicio),
    constraint FK_Servicios_Empresas
		foreign key (codigoEmpresa) 
        references Empresas(codigoEmpresa)
);

Create table TipoPlato(
	codigoTipoPlato int not null auto_increment,
    descripcionTipo varchar(100) not null,
    primary key PK_codigoTipoPlato(codigoTipoPlato)
);

Create table Platos(
	codigoPlato int not null auto_increment,
    cantidad int not null,
    nombrePlato varchar(50) not null,
    descripcionPlato varchar(150) not null,
    precioPlato decimal(10,2),
    codigoTipoPlato int not null,
    primary key PK_codigoPlato(codigoPlato),
    constraint FK_Platos_TipoPlato
		foreign key (codigoTipoPlato) 
        references TipoPlato(codigoTipoPlato)
);

Create table Productos(
	codigoProducto int not null auto_increment,
    nombreProducto varchar(150) not null,
    cantidad int not null,
    primary key PK_codigoProducto(codigoProducto)
);

Create table Productos_has_Plato(
	Productos_codigoProducto int not null,
    codigoPlato int not null,
    codigoProducto int not null,
    primary key PK_Productos_codigoProducto (Productos_codigoProducto),
    constraint FK_Productos_has_Platos_Productos1 foreign key (codigoProducto) references Productos(codigoProducto),
    constraint FK_Productos_has_Platos_Platos1 foreign key (codigoPlato) references Platos(codigoPlato)
);

Create table Servicios_has_Platos(
	Servicios_codigoServicio int not null,
    codigoPlato int not null,
    codigoServicio int not null,
    primary key PK_Servicios_codigoServicio (Servicios_codigoServicio),
    constraint FK_Servicios_has_Platos_Servicios1 foreign key (codigoServicio) references Servicios(codigoServicio),
    constraint FK_Servicios_has_Platos_Platos1 foreign key (codigoPlato) references Platos(codigoPlato)
);

Create table TipoEmpleado(
	codigoTipoEmpleado int not null auto_increment,
    descripcion varchar(100) not null,
    primary key PK_codigoTipoEmpleado(codigoTipoEmpleado)
);

Create table Empleados(
	codigoEmpleado int not null auto_increment,
    numeroEmpleado int not null,
    apellidosEmpleado varchar(150) not null,
    nombresEmpleado varchar(150) not null,
    direccionEmpleado varchar(150) not null,
    telefonoContacto varchar(10) not null,
    gradoCocinero varchar(50) not null,
    codigoTipoEmpleado int not null,
    primary key PK_codigoEmpleado(codigoEmpleado),
    constraint FK_Empleados_TipoEmpleado
		foreign key (codigoTipoEmpleado) 
        references TipoEmpleado(codigoTipoEmpleado)
);

Create table Servicios_has_Empleados(
	Servicios_codigoServicio int not null,
    codigoServicio int not null,
    codigoEmpleado int not null,
    fechaEvento date not null,
    horaEvento time not null,
    lugarEvento varchar(150) not null,
    primary key PK_Servicios_codigoServicio (Servicios_codigoServicio),
    constraint FK_Servicios_has_Empleados_Servicios1 foreign key (codigoServicio) references Servicios(codigoServicio),
    constraint FK_Servicios_has_Empleados_Empleados1 foreign key (codigoEmpleado) references Empleados(codigoEmpleado)
);

# --- Agregar Empresas ---
Delimiter $$
    Create Procedure sp_AgregarEmpresas(
		in nomEmpresa varchar(150),
		in direc varchar(150),
        in tel varchar(10)
    )
    Begin
		Insert into Empresas(nombreEmpresa,
			direccion, telefono)
			values (nomEmpresa, direc, tel);
    End $$
Delimiter ;
Call sp_AgregarEmpresas('Pollo Campero','Guatemala, Ciudad', '12345678');
Call sp_AgregarEmpresas('Farmacia Galeno','Guatemala, Ciudad','12378946');
Call sp_AgregarEmpresas('Pizza Hut','Zona 6 de Mixco','15975364');
Call sp_AgregarEmpresas('Taco Bell','Zona 5, Villa Nueva','45678912');
Call sp_AgregarEmpresas('Almuerzos La Villa','Zona 9, Villa Canales','48621357');
Call sp_AgregarEmpresas('Refacciones Martinez','Ciudad de Guatemala','25874136');
Call sp_AgregarEmpresas('Fundacion KINAL','Zona 7, Guatemala','58823476');

# --- Listar Empresas ---
Delimiter $$
	Create procedure sp_ListarEmpresas()
    Begin
		Select
			Empresas.codigoEmpresa,
			Empresas.nombreEmpresa,
			Empresas.direccion,
			Empresas.telefono
			from Empresas;
    End $$
Delimiter ;
Call sp_ListarEmpresas();

# --- Actualizar Empresas ---
Delimiter $$
	Create procedure sp_ActualizarEmpresas(
		in codEmpresa int,
		in nomEmpresa varchar(150),
		in direc varchar(150),
		in tel varchar(10)
	)
    Begin
		Update Empresas set
			codigoEmpresa = codEmpresa,
			nombreEmpresa = nomEmpresa,
			direccion = direc,
			telefono = tel
			where codigoEmpresa = codEmpresa;
    End $$
Delimiter ;

# --- Eliminar Empresas ---
Delimiter $$
	Create procedure sp_EliminarEmpresas(
	in codEmpresa int
	)
    Begin
		Delete from Empresas
			where codigoEmpresa = codEmpresa;
    End $$
Delimiter ;

# --- Buscar Empresas ---
Delimiter $$
	Create procedure sp_BuscarEmpresas(in codEmpresa int)
    Begin
		Select
			Empresas.codigoEmpresa,
			Empresas.nombreEmpresa,
			Empresas.direccion,
			Empresas.telefono
			from Empresas 
			where codigoEmpresa = codEmpresa;
    End $$  
Delimiter ;

#-----------------------------------------

# --- Agregar Presupuesto ---
Delimiter $$
	Create procedure sp_AgregarPresupuesto(
		in fechaSoli date,
		in cantPresupuesto decimal(10,2),
		in codEmpresa int
	)
	Begin
		Insert into Presupuesto(fechaSolicitud,
			cantidadPresupuesto, codigoEmpresa)
			values (fechaSoli, cantPresupuesto,
			codEmpresa);
	End $$
Delimiter ;
Call sp_AgregarPresupuesto('2020-01-01','5000.00',1);
Call sp_AgregarPresupuesto('2020-02-01','1000.00',2);
Call sp_AgregarPresupuesto('2020-03-01','100.00',3);
Call sp_AgregarPresupuesto('2020-04-01','150.00',4);
Call sp_AgregarPresupuesto('2020-05-01','1500.00',5);

# --- Listar Presupuesto ---
Delimiter $$
	Create procedure sp_ListarPresupuesto()
	Begin
		Select
			Presupuesto.codigoPresupuesto,
			Presupuesto.fechaSolicitud,
			Presupuesto.cantidadPresupuesto,
			Presupuesto.codigoEmpresa
			from Presupuesto;
	End $$
Delimiter ;
Call sp_ListarPresupuesto();

# --- Actualizar Presupuesto ---
Delimiter $$
	Create procedure sp_ActualizarPresupuesto(
		in codPresupuesto int,
		in fechaSoli date,
		in cantPresupuesto decimal(10,2),
		in codEmpresa int
	)
	Begin
		Update Presupuesto set
			codigoPresupuesto = codPresupuesto,
			fechaSolicitud = fechaSoli,
			cantidadPresupuesto = cantPresupuesto,
			codigoEmpresa = codEmpresa
			where codigoPresupuesto = codPresupuesto;
	End $$
Delimiter ;

# --- Eliminar Presupuesto ---
Delimiter $$
	Create procedure sp_EliminarPresupuesto(
		in codPresupuesto int
	)
	Begin
		Delete from Presupuesto
			where codigoPresupuesto =
			codPresupuesto;
	End $$
Delimiter ;

# --- Buscar Presupuesto ---
Delimiter $$
	Create procedure sp_BuscarPresupuesto(
		in codPresupuesto int
	)
	Begin
		Select
			Presupuesto.codigoPresupuesto,
			Presupuesto.fechaSolicitud,
			Presupuesto.cantidadPresupuesto,
			Presupuesto.codigoEmpresa
			from Presupuesto
			where codigoPresupuesto = codPresupuesto;
	End $$
Delimiter ;

#-----------------------------------------

# --- Agregar Servicios ---
Delimiter $$
	Create procedure sp_AgregarServicios(
		in fecServicio date,
		in tipServicio varchar(100),
		in horServicio time,
		in lugServicio varchar(100),
		in telContacto varchar(10),
		in codEmpresa int
	)
	Begin
		Insert into Servicios(fechaServicio,
		tipoServicio, horaServicio, lugarServicio,
		telefonoContacto, codigoEmpresa) values
		(fecServicio, tipServicio, horServicio,
		lugServicio, telContacto, codEmpresa);
	End $$
Delimiter ;
Call sp_AgregarServicios('2020-01-01','Almuerzo','13:00','Zona 9, Ciudad','1234',1);
Call sp_AgregarServicios('2020-01-02','Almuerzo','13:00','Zona 10, Ciudad','1592',2);
Call sp_AgregarServicios('2020-01-03','Cena','19:00','Villa Nueva','7894',3);
Call sp_AgregarServicios('2020-01-04','Cena','19:00','Villa Canales','4569',4);
Call sp_AgregarServicios('2020-01-05','Desayuno','08:00','Vista Hermosa','1239',5);

# --- Listar Servicios ---
Delimiter $$
	Create procedure sp_ListarServicios()
	Begin
		Select
			Servicios.codigoServicio,
			Servicios.fechaServicio,
			Servicios.tipoServicio,
			Servicios.horaServicio,
			Servicios.lugarServicio,
			Servicios.telefonoContacto,
			Servicios.codigoEmpresa
			from Servicios;
	End $$
Delimiter ;
Call sp_ListarServicios();

# --- Actualizar Servicios ---
Delimiter $$
	Create procedure sp_ActualizarServicios(
		in codServicio int,
        in fecServicio date,
        in tipServicio varchar(100),
        in horServicio time,
        in lugServicio varchar(100),
        in telContacto varchar(10)
    )
	Begin
		Update Servicios set
			codigoServicio = codServicio,
            fechaServicio = fecServicio,
            tipoServicio = tipServicio,
            horaServicio = horServicio,
            lugarServicio = lugServicio,
            telefonoContacto = telContacto
            where codigoServicio = codServicio;
	End $$
Delimiter ;

# --- Eliminar Servicios ---
Delimiter $$
	Create procedure sp_EliminarServicios(
		in codServicio int
    )
	Begin
		Delete from Servicios
			where codigoServicio = codServicio;
	End $$
Delimiter ;

# --- Buscar Servicios ---
Delimiter $$
	Create procedure sp_BuscarServicios(
		in codServicio int
    )
	Begin
		Select
			Servicios.codigoServicio,
			Servicios.fechaServicio,
			Servicios.tipoServicio,
			Servicios.horaServicio,
			Servicios.lugarServicio,
			Servicios.telefonoContacto,
			Servicios.codigoEmpresa
			from Servicios
			where codigoServicio = codServicio;
	End $$
Delimiter ;

#-----------------------------------------

# --- Agregar TipoPlato ---
Delimiter $$
	Create procedure sp_AgregarTipoPlato(
		in descTipo varchar(100)
	)
	Begin
		Insert into TipoPlato(descripcionTipo)
		values (descTipo);
	End $$
Delimiter ;
Call sp_AgregarTipoPlato('Entrada');
Call sp_AgregarTipoPlato('Fuerte');
Call sp_AgregarTipoPlato('Postre');

# --- Listar TipoPlato ---
Delimiter $$
	Create procedure sp_ListarTipoPlato()
	Begin
		Select
			TipoPlato.codigoTipoPlato,
			TipoPlato.descripcionTipo
			from TipoPlato;
	End $$
Delimiter ;
Call sp_ListarTipoPlato();

# --- Actualizar TipoPlato ---
Delimiter $$
	Create procedure sp_ActualizarTipoPlato(
		in codTipoPlato int,
        in descTipo varchar(100)
    )
	Begin
		Update TipoPlato set
			codigoTipoPlato = codTipoPlato,
            descripcionTipo = descTipo
            where codigoTipoPlato = codTipoPlato;
	End $$
Delimiter ;

# --- Eliminar TipoPlato ---
Delimiter $$
	Create procedure sp_EliminarTipoPlato(
		in codTipoPlato int
    )
	Begin
		Delete from TipoPlato
			where codigoTipoPlato = codTipoPlato;
	End $$
Delimiter ;

# --- Buscar TipoPlato ---
Delimiter $$
	Create procedure sp_BuscarTipoPlato(
		in codTipoPlato int
    )
	Begin
		Select
			TipoPlato.codigoTipoPlato,
			TipoPlato.descripcionTipo
			from TipoPlato
            where codigoTipoPlato = codTipoPlato;
	End $$
Delimiter ;

#-----------------------------------------

# --- Agregar Platos ---
Delimiter $$
	Create procedure sp_AgregarPlatos(
		in cant int,
        in nomPlato varchar(50),
		in descPlato varchar(150),
		in precPlato decimal(10,2),
		in codTipoPlato int
	)
	Begin
		Insert into Platos(cantidad, nombrePlato,
			descripcionPlato, precioPlato,
			codigoTipoPlato) values (cant, nomPlato,
			descPlato, precPlato, codTipoPlato);
	End $$
Delimiter ;
Call sp_AgregarPlatos(10,'Sopa de fideos','Sopa con fideo fino y condimentado','15.00',1);

# --- Listar Platos ---
Delimiter $$
	Create procedure sp_ListarPlatos()
	Begin
		Select
			Platos.codigoPlato,
			Platos.cantidad,
			Platos.nombrePlato,
			Platos.descripcionPlato,
			Platos.precioPlato,
			Platos.codigoTipoPlato
			from Platos;
	End $$
Delimiter ;
Call sp_ListarPlatos();

# --- Actualizar Platos ---
Delimiter $$
	Create procedure sp_ActualizarPlatos(
		in codPlato int,
        in cant int,
        in nomPlato varchar(50),
        in descPlato varchar(150),
        in precPlato decimal(10,2),
        in codTipoPlato int
    )
	Begin
		Update Platos set
			codigoPlato = codPlato,
            cantidad = cant,
            nombrePlato = nomPlato,
            descripcionPlato = descPlato,
            precioPlato = precPlato,
            codigoTipoPlato = codTipoPlato
            where codigoPlato = codPlato;
	End $$
Delimiter ;

# --- Eliminar Platos ---
Delimiter $$
	Create procedure sp_EliminarPlatos(
		in codPlato int
    )
	Begin
		Delete from Platos
			where codigoPlato = codPlato;
	End $$
Delimiter ;

# --- Buscar Platos ---
Delimiter $$
	Create procedure sp_BuscarPlatos(
		in codPlato int
    )
	Begin
		Select
			Platos.codigoPlato,
			Platos.cantidad,
			Platos.nombrePlato,
			Platos.descripcionPlato,
			Platos.precioPlato,
			Platos.codigoTipoPlato
			from Platos
            where codigoPlato = codPlato;
	End $$
Delimiter ;

#-----------------------------------------

# --- Agregar Productos ---
Delimiter $$
	Create procedure sp_AgregarProductos(
		in nomProducto varchar(150),
		in cant int
	)
	Begin
		Insert into Productos(nombreProducto,
			cantidad) values (nomProducto, cant);
	End $$
Delimiter ;
Call sp_AgregarProductos('Aceite de Oliva',50);
Call sp_AgregarProductos('Vino Blanco',10);
Call sp_AgregarProductos('Juego de Vajillas',20);
Call sp_AgregarProductos('Juego de Servidoras',30);
Call sp_AgregarProductos('Especias',12);

# --- Listar Productos ---
Delimiter $$
	Create procedure sp_ListarProductos()
	Begin
		Select
			Productos.codigoProducto,
			Productos.nombreProducto,
			Productos.cantidad
			from Productos;
	End $$
Delimiter ;
Call sp_ListarProductos();

# --- Actualizar Productos ---
Delimiter $$
	Create procedure sp_ActualizarProductos(
		in codProducto int,
        in nomProducto varchar(150),
        in cant int
    )
	Begin
		Update Productos set
			codigoProducto = codProducto,
            nombreProducto = nomProducto,
            cantidad = cant
            where codigoProducto = codProducto;
	End $$
Delimiter ;

# --- Eliminar Productos ---
Delimiter $$
	Create procedure sp_EliminarProductos(
		in codProducto int
    )
	Begin
		Delete from Productos
			where codigoProducto = codProducto;
	End $$
Delimiter ;

# --- Buscar Productos ---
Delimiter $$
	Create procedure sp_BuscarProductos(
		in codProducto int
    )
	Begin
		Select
			Productos.codigoProducto,
			Productos.nombreProducto,
			Productos.cantidad
			from Productos
            where codigoProducto = codProducto;
	End $$
Delimiter ;

#-----------------------------------------

# --- Agregar TipoEmpleado ---
Delimiter $$
	Create procedure sp_AgregarTipoEmpleado(
		in descrip varchar(100)
	)
	Begin
		Insert into TipoEmpleado(descripcion)
			values (descrip);
	End $$
Delimiter ;
Call sp_AgregarTipoEmpleado('Mesero');
Call sp_AgregarTipoEmpleado('Aprobador');
Call sp_AgregarTipoEmpleado('Jefe');
Call sp_AgregarTipoEmpleado('Subjefe');
Call sp_AgregarTipoEmpleado('Catero');

# --- Listar TipoEmpleado ---
Delimiter $$
	Create procedure sp_ListarTipoEmpleado()
	Begin
		Select
			TipoEmpleado.codigoTipoEmpleado,
			TipoEmpleado.descripcion
			from TipoEmpleado;
	End $$
Delimiter ;
Call sp_ListarTipoEmpleado();

# --- Actualizar TipoEmpleado ---
Delimiter $$
	Create procedure sp_ActualizarTipoEmpleado(
		in codTipoEmpleado int,
        in descrip varchar(100)
    )
	Begin
		Update TipoEmpleado set
			codigoTipoEmpleado = codTipoEmpleado,
            descripcion = descrip
            where codigoTipoEmpleado = codTipoEmpleado;
	End $$
Delimiter ;

# --- Eliminar TipoEmpleado ---
Delimiter $$
	Create procedure sp_EliminarTipoEmpleado(
		in codTipoEmpleado int
    )
	Begin
		Delete from TipoEmpleado
			where codigoTipoEmpleado = codTipoEmpleado;
	End $$
Delimiter ;

# --- Buscar TipoEmpleado ---
Delimiter $$
	Create procedure sp_BuscarTipoEmpleado(
		in codTipoEmpleado int
	)
	Begin
		Select
			TipoEmpleado.codigoTipoEmpleado,
			TipoEmpleado.descripcion
			from TipoEmpleado
            where codigoTipoEmpleado = codTipoEmpleado;
	End $$
Delimiter ;

#-----------------------------------------

# --- Agregar Empleados ---
Delimiter $$
	Create procedure sp_AgregarEmpleados(
		in numEmpleado int,
		in apellidosEmp varchar(150),
		in nombresEmp varchar(150),
		in direccionEmp varchar(150),
		in telContacto varchar(10),
		in gradCocinero varchar(50),
		in codTipoEmpleado int
	)
	Begin
		Insert into Empleados(numeroEmpleado,
			apellidosEmpleado, nombresEmpleado,
			direccionEmpleado, telefonoContacto,
			gradoCocinero, codigoTipoEmpleado)
			values (numEmpleado, apellidosEmp,
			nombresEmp, direccionEmp, telContacto,
			gradCocinero, codTipoEmpleado);
	End $$
Delimiter ;
Call sp_AgregarEmpleados('1001','Gutierrez Salvatierra','Armando Gudiel','Zona 9, Ciudad Guatemala','12312312','Cocinero Chef',1);
Call sp_AgregarEmpleados('1002','Najera Ramirez','Jorge Alejandro','Villa Nueva','1234','Cocinero Master',2);
Call sp_AgregarEmpleados('1003','Lopez Sandoval','Eva María','Villa Canales','15923','Cocinero Chef',3);
Call sp_AgregarEmpleados('1004','Terraza Montenegro','Hugo Alejandro','San Miguel Petapa','147852','Cocinero Master',4);
Call sp_AgregarEmpleados('1005','Llarena Ramirez','Brenda Lucrecia','Zona 10','123789','Cocinero Profesional',5);

# --- Listar Empleados ---
Delimiter $$
	Create procedure sp_ListarEmpleados()
	Begin
		Select
			Empleados.codigoEmpleado,
			Empleados.numeroEmpleado,
			Empleados.apellidosEmpleado,
			Empleados.nombresEmpleado,
			Empleados.direccionEmpleado,
			Empleados.telefonoContacto,
			Empleados.gradoCocinero,
			Empleados.codigoTipoEmpleado
			from Empleados;
	End $$
Delimiter ;
Call sp_ListarEmpleados();

# --- Actualizar Empleados ---
Delimiter $$
	Create procedure sp_ActualizarEmpleados(
		in codEmpleado int,
        in numEmpleado int,
		in apellidosEmp varchar(150),
		in nombresEmp varchar(150),
		in direccionEmp varchar(150),
		in telContacto varchar(10),
		in gradCocinero varchar(50),
		in codTipoEmpleado int
    )
	Begin
		Update Empleados set
			codigoEmpleado = codEmpleado,
            numeroEmpleado = numEmpleado,
            apellidosEmpleado = apellidosEmp,
            nombresEmpleado = nombresEmp,
            direccionEmpleado = direccionEmp,
            telefonoContacto = telContacto,
            gradoCocinero = gradCocinero,
            codigoTipoEmpleado = codTipoEmpleado
            where codigoEmpleado = codEmpleado;
	End $$
Delimiter ;

# --- Eliminar Empleados ---
Delimiter $$
	Create procedure sp_EliminarEmpleados(
		in codEmpleado int
    )
	Begin
		Delete from Empleados
			where codigoEmpleado = codEmpleado;
	End $$
Delimiter ;

# --- Buscar Empleados ---
Delimiter $$
	Create procedure sp_BuscarEmpleados(
		in codEmpleado int
    )
	Begin
		Select
			Empleados.codigoEmpleado,
			Empleados.numeroEmpleado,
			Empleados.apellidosEmpleado,
			Empleados.nombresEmpleado,
			Empleados.direccionEmpleado,
			Empleados.telefonoContacto,
			Empleados.gradoCocinero,
			Empleados.codigoTipoEmpleado
			from Empleados
            where codigoEmpleado = codEmpleado;
	End $$
Delimiter ;