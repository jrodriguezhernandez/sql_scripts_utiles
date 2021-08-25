CREATE USER 'NombreDelUsuario'@'%' IDENTIFIED BY 'Password';
GRANT ALL ON BaseDeDatos.* TO 'NombreDelUsuario'@'%';
FLUSH PRIVILEGES;
