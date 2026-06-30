CREATE DATABASE SICRCB;

USE SICRCB;

CREATE TABLE rol(
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL
);

CREATE TABLE usuario(
id INT PRIMARY KEY AUTO_INCREMENT,
contraseña VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
estado VARCHAR(20) NOT NULL ,
image_url VARCHAR (255),
CONSTRAINT uc_email UNIQUE (email) 
);

CREATE TABLE tipo_documento(
id INT PRIMARY KEY AUTO_INCREMENT,
sigla VARCHAR(10)  NOT NULL,
nombre_documento VARCHAR(100) NOT NULL,
estado VARCHAR(20) NOT NULL,
CONSTRAINT uc_sigla UNIQUE (sigla),
CONSTRAINT uc_nombre_documento UNIQUE (nombre_documento) 
 
);

CREATE TABLE user_data(
id INT PRIMARY KEY AUTO_INCREMENT,
numero_documento INT NOT NULL,
primer_nombre VARCHAR(50) NOT NULL,
segundo_nombre VARCHAR(50),
primer_apellido VARCHAR(50) NOT NULL,
segundo_apellido VARCHAR(50),

id_usuario INT NOT NULL,
id_tipo_documento INT NOT NULL,

FOREIGN KEY (id_usuario)
REFERENCES usuario(id)
ON DELETE RESTRICT
ON UPDATE CASCADE,

FOREIGN KEY (id_tipo_documento)
REFERENCES tipo_documento(id)
ON DELETE RESTRICT
ON UPDATE CASCADE, 

CONSTRAINT uc_user_data UNIQUE(numero_documento,id_tipo_documento)

);

CREATE TABLE rol_usuario(
id_user INT,
id_rol INT,

PRIMARY KEY(id_user,id_rol),

FOREIGN KEY(id_user)
REFERENCES usuario(id)
ON DELETE RESTRICT
ON UPDATE CASCADE,

FOREIGN KEY(id_rol)
REFERENCES rol(id)
ON DELETE RESTRICT
ON UPDATE CASCADE

);

CREATE TABLE administrador(
id INT PRIMARY KEY AUTO_INCREMENT,
id_user_data INT NOT NULL,
estado VARCHAR(20) NOT NULL,
fecha_inicio DATE NOT NULL,
fecha_fin DATE,

FOREIGN KEY(id_user_data)
REFERENCES user_data(id)
ON DELETE RESTRICT
ON UPDATE CASCADE

);

CREATE TABLE propietario(
id INT PRIMARY KEY AUTO_INCREMENT,
id_user_data INT NOT NULL,
estado VARCHAR(20) NOT NULL,

FOREIGN KEY (id_user_data)
REFERENCES user_data(id)
ON DELETE RESTRICT
ON UPDATE CASCADE

);

CREATE TABLE queja_sugerencia(
id INT PRIMARY KEY AUTO_INCREMENT,
id_propietario INT NOT NULL,
id_administrador INT NOT NULL,
descripcion_pqr VARCHAR(500) NOT NULL,
titulo_pqr VARCHAR(150) NOT NULL,
estado VARCHAR(20) NOT NULL,
fecha TIMESTAMP NOT NULL,
evidencias VARCHAR(50),

FOREIGN KEY (id_propietario)
REFERENCES propietario(id)
ON DELETE RESTRICT
ON UPDATE CASCADE,

FOREIGN KEY (id_administrador)
REFERENCES administrador(id)
ON DELETE RESTRICT
ON UPDATE CASCADE

);

CREATE TABLE bloque(
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(20) NOT NULL
);

CREATE TABLE interior(
id INT PRIMARY KEY AUTO_INCREMENT,
numero VARCHAR(20) NOT NULL,
id_bloque INT NOT NULL,

FOREIGN KEY (id_bloque)
REFERENCES bloque(id)
ON DELETE RESTRICT
ON UPDATE CASCADE
);

CREATE TABLE apartamento(
id INT PRIMARY KEY AUTO_INCREMENT,
estado	VARCHAR(20) NOT NULL,
numero INT NOT NULL,
id_interior INT NOT NULL,

FOREIGN KEY (id_interior)
REFERENCES interior(id)
ON DELETE RESTRICT
ON UPDATE CASCADE

);

CREATE TABLE propietario_gestion_apartamento(
id INT PRIMARY KEY AUTO_INCREMENT,
id_propietario INT NOT NULL,
id_apartamento INT NOT NULL,
fecha_registro DATE NOT NULL,
estado VARCHAR(20),

FOREIGN KEY (id_propietario)
REFERENCES propietario(id)
ON DELETE RESTRICT
ON UPDATE CASCADE,

FOREIGN KEY (id_apartamento)
REFERENCES apartamento(id)
ON DELETE RESTRICT
ON UPDATE CASCADE,

CONSTRAINT uc_gest_ap UNIQUE (id_propietario,id_apartamento,fecha_registro)

);

CREATE TABLE tipo_multa(
id INT PRIMARY KEY AUTO_INCREMENT,
numero VARCHAR(20) NOT NULL,
descripcion VARCHAR(1000) NOT NULL,
valor FLOAT NOT NULL,
estado VARCHAR(20) NOT NULL

);

CREATE TABLE multa(
id INT PRIMARY KEY AUTO_INCREMENT,
numero INT NOT NULL,
nombre VARCHAR(100) NOT NULL,
descripcion VARCHAR(100) NOT NULL,
estado VARCHAR(20) NOT NULL,
id_tipo_multa INT NOT NULL,
id_apartamento INT NOT NULL,
id_administrador INT NOT NULL,
evidencia VARCHAR(500) NOT NULL,

FOREIGN KEY (id_tipo_multa)
REFERENCES tipo_multa(id)
ON DELETE RESTRICT
ON UPDATE CASCADE,

FOREIGN KEY (id_apartamento)
REFERENCES apartamento(id)
ON DELETE RESTRICT
ON UPDATE CASCADE,

FOREIGN KEY (id_administrador)
REFERENCES administrador(id)
ON DELETE RESTRICT
ON UPDATE CASCADE,

CONSTRAINT uc_numero_multa UNIQUE (numero) 

);

CREATE TABLE pqr_especifica(
id INT PRIMARY KEY AUTO_INCREMENT,
id_queja_sugerencia INT NOT NULL,
id_apartamento INT NOT NULL,

FOREIGN KEY (id_queja_sugerencia)
REFERENCES 	queja_sugerencia(id)
ON DELETE RESTRICT
ON UPDATE CASCADE,

FOREIGN KEY (id_apartamento)
REFERENCES apartamento(id)
ON DELETE RESTRICT
ON UPDATE CASCADE
 
 );
 
 CREATE TABLE noticia(
 id INT PRIMARY KEY AUTO_INCREMENT,
 descripcion VARCHAR(10000) NOT NULL,
 estado VARCHAR(20) NOT NULL,
 fecha_publicacion TIMESTAMP NOT NULL,
 id_administrador INT NOT NULL,
 
 FOREIGN KEY (id_administrador)
 REFERENCES administrador(id)
 ON DELETE RESTRICT
 ON UPDATE CASCADE
 );
 
 CREATE TABLE salon_comunal(
 id INT PRIMARY KEY AUTO_INCREMENT,
 estado VARCHAR(20) NOT NULL
 );
 
 CREATE TABLE silla(
 id INT PRIMARY KEY AUTO_INCREMENT,
 cantidad INT NOT NULL,
 estado VARCHAR(20) NOT NULL
 );
 
 CREATE TABLE alquiler(
 id INT PRIMARY KEY AUTO_INCREMENT,
 id_propietario INT NOT NULL,
 id_salon_comunal INT ,
 descripcion VARCHAR(500) NOT NULL,
 hora_inicio TIMESTAMP NOT NULL,
 hora_fin TIMESTAMP NOT NULL,
 valor_hora INT NOT NULL,
 estado VARCHAR(20) NOT NULL,
 
 FOREIGN KEY (id_propietario)
 REFERENCES propietario(id)
 ON DELETE RESTRICT
 ON UPDATE CASCADE,
 
 FOREIGN KEY (id_salon_comunal)
 REFERENCES salon_comunal(id)
 ON DELETE RESTRICT
 ON UPDATE CASCADE
 );
 
 CREATE TABLE alquiler_silla(
 id_alquiler INT,
 id_silla INT,
 
 PRIMARY KEY(id_alquiler,id_silla),
 
 FOREIGN KEY (id_alquiler)
 REFERENCES alquiler(id)
 ON DELETE RESTRICT
 ON UPDATE CASCADE,
 
 FOREIGN KEY (id_silla)
 REFERENCES silla(id)
 ON DELETE RESTRICT
 ON UPDATE CASCADE
 );