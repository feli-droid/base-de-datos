# Modelo Entidad-Relación (MER) - Terraria

Este repositorio contiene la especificación y documentación del **Modelo Entidad-Relación (MER)** conceptual para el videojuego **Terraria**, derivado del diagrama `app.diagrams.net` (draw.io).

---

## 📌 Descripción del Proyecto

El objetivo de este modelo es estructurar la base de datos conceptual para gestionar los datos clave de un sistema o servidor del juego Terraria. Abarca la relación entre los jugadores, sus personajes creados, los mundos en los que juegan, los biomas, los objetos recolectados, los jefes derrotados y los personajes no jugables (NPCs) que habitan el entorno.

---

## 🧩 Entidades y Atributos

| Entidad | Descripción | Atributos Primarios (PK) | Otros Atributos | Tipo de Entidad |
| :--- | :--- | :--- | :--- | :--- |
| **Jugador** | Usuario registrado que interactúa en la plataforma. | `idJugador` | `usuario` | Fuerte |
| **Personaje** | Avatar dentro del juego perteneciente a un jugador. | `idPersonaje` | `nombre` | Fuerte |
| **Mundo** | Entorno o mapa de juego creado por un jugador. | `idMundo` | `nombreMundo` | Fuerte |
| **Item** | Objeto recogible o de inventario dentro del juego. | `idItem` | `nombre` | Fuerte |
| **Jefe** | Enemigo principal/Boss que puede ser derrotado. | `idJefe` | `nombre` | Fuerte |
| **Bioma** | Región ecológica o zona geográfica que conforma un mundo. | `idBioma` | `nombre` | Débil / Compuesta |
| **NPC** | Personaje No Jugable que ofrece servicios u orientaciones. | `idNpc` | `nombre` | Fuerte |

---

## 🔗 Relaciones y Cardinalidades

1. **Jugador `Posee` Personaje**
   - **Cardinalidad:** `1 : N` (Un jugador puede poseer múltiples personajes; cada personaje pertenece a un solo jugador).
2. **Jugador `Crea` Mundo**
   - **Cardinalidad:** `1 : N` (Un jugador puede crear varios mundos; cada mundo es creado por un jugador).
3. **Personaje `Recolecta` Item**
   - **Cardinalidad:** `N : M` (Un personaje recolecta múltiples items y un item puede ser recolectado por múltiples personajes).
   - **Atributos propios de la relación:** `cantidad`.
4. **Personaje `Derrota` Jefe**
   - **Cardinalidad:** `N : M` (Un personaje puede derrotar a varios jefes y un jefe puede ser derrotado por varios personajes).
   - **Atributos propios de la relación:** `fecha`.
5. **Mundo `Contiene` Bioma**
   - **Cardinalidad:** `1 : N` (Un mundo contiene múltiples biomas).
6. **Bioma `Habita` NPC**
   - **Cardinalidad:** `1 : N` (En un bioma pueden habitar varios NPCs).

---

## 🗄️ Esquema Relacional Sugerido (SQL)

A partir del modelo conceptual, se sugiere el siguiente diseño lógico para tablas relacionales SQL:

```sql
-- Tabla Jugador
CREATE TABLE Jugador (
    idJugador INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla Personaje
CREATE TABLE Personaje (
    idPersonaje INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    idJugador INT NOT NULL,
    FOREIGN KEY (idJugador) REFERENCES Jugador(idJugador) ON DELETE CASCADE
);

-- Tabla Mundo
CREATE TABLE Mundo (
    idMundo INT PRIMARY KEY AUTO_INCREMENT,
    nombreMundo VARCHAR(50) NOT NULL,
    idJugador INT NOT NULL,
    FOREIGN KEY (idJugador) REFERENCES Jugador(idJugador) ON DELETE CASCADE
);

-- Tabla Item
CREATE TABLE Item (
    idItem INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla Jefe
CREATE TABLE Jefe (
    idJefe INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla Bioma
CREATE TABLE Bioma (
    idBioma INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    idMundo INT NOT NULL,
    FOREIGN KEY (idMundo) REFERENCES Mundo(idMundo) ON DELETE CASCADE
);

-- Tabla NPC
CREATE TABLE NPC (
    idNpc INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    idBioma INT NOT NULL,
    FOREIGN KEY (idBioma) REFERENCES Bioma(idBioma) ON DELETE CASCADE
);

-- Tabla Intermedia: Recolecta (Personaje - Item)
CREATE TABLE Recolecta (
    idPersonaje INT NOT NULL,
    idItem INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    PRIMARY KEY (idPersonaje, idItem),
    FOREIGN KEY (idPersonaje) REFERENCES Personaje(idPersonaje) ON DELETE CASCADE,
    FOREIGN KEY (idItem) REFERENCES Item(idItem) ON DELETE CASCADE
);

-- Tabla Intermedia: Derrota (Personaje - Jefe)
CREATE TABLE Derrota (
    idPersonaje INT NOT NULL,
    idJefe INT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idPersonaje, idJefe),
    FOREIGN KEY (idPersonaje) REFERENCES Personaje(idPersonaje) ON DELETE CASCADE,
    FOREIGN KEY (idJefe) REFERENCES Jefe(idJefe) ON DELETE CASCADE
);
```

---

## 🛠️ Cómo Importar el Diagrama en Diagrams.net (Draw.io)

1. Abre [diagrams.net](https://app.diagrams.net/).
2. Ve a **Archivo** > **Abrir desde** > **Dispositivo** (o la fuente de tu preferencia).
3. Selecciona el archivo `.drawio` o `.xml` que contiene la definición XML provista en el archivo original.
4. Podrás visualizar y editar gráficamente todas las entidades, relaciones y atributos descritos.
