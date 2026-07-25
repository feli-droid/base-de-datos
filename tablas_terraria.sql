create table jugador (
    idjugador int primary key,
    usuario varchar(100)
);

create table mundo (
    idmundo int primary key,
    nombremundo varchar(100),
    idjugador int,
    foreign key (idjugador) references jugador(idjugador)
);

create table bioma (
    idbioma int primary key,
    nombre varchar(100),
    idmundo int,
    foreign key (idmundo) references mundo(idmundo)
);

create table personaje (
    idpersonaje int primary key,
    nombre varchar(100),
    idjugador int,
    foreign key (idjugador) references jugador(idjugador)
);

create table npc (
    idnpc int primary key,
    nombre varchar(100),
    idbioma int,
    foreign key (idbioma) references bioma(idbioma)
);

create table item (
    iditem int primary key,
    nombre varchar(100)
);

create table jefe (
    idjefe int primary key,
    nombre varchar(100)
);

create table recolecta (
    idrecolecta int primary key,
    idpersonaje int,
    iditem int,
    cantidad varchar(50),
    foreign key (idpersonaje) references personaje(idpersonaje),
    foreign key (iditem) references item(iditem)
);

create table derrota (
    idderrota int primary key,
    idpersonaje int,
    idjefe int,
    fecha date,
    foreign key (idpersonaje) references personaje(idpersonaje),
    foreign key (idjefe) references jefe(idjefe)
);
