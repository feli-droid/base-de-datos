create table jugador (
    idjugador int primary key,
    usuario varchar(100) not null
);
 
create table mundo (
    idmundo int primary key,
    nombremundo varchar(100) not null,
    idjugador int not null,
    foreign key (idjugador) references jugador(idjugador)
);
 
create table bioma (
    idbioma int primary key,
    nombre varchar(100) not null,
    idmundo int not null,
    foreign key (idmundo) references mundo(idmundo)
);
 
create table personaje (
    idpersonaje int primary key,
    nombre varchar(100) not null,
    idjugador int not null,
    foreign key (idjugador) references jugador(idjugador)
);
 
create table npc (
    idnpc int primary key,
    nombre varchar(100) not null,
    idbioma int not null,
    foreign key (idbioma) references bioma(idbioma)
);
 
create table item (
    iditem int primary key,
    nombre varchar(100) not null
);
 
create table jefe (
    idjefe int primary key,
    nombre varchar(100) not null
);
 
create table recolecta (
    idrecolecta int primary key,
    idpersonaje int not null,
    iditem int not null,
    cantidad int not null,
    foreign key (idpersonaje) references personaje(idpersonaje),
    foreign key (iditem) references item(iditem)
);
 
create table derrota (
    idderrota int primary key,
    idpersonaje int not null,
    idjefe int not null,
    fecha date not null,
    foreign key (idpersonaje) references personaje(idpersonaje),
    foreign key (idjefe) references jefe(idjefe)
);
