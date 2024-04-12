# seismological_data

# Versiones

- Ruby: 3.0.0
- Rails: 7.1.3.2
- Node: 18.20.2
- Vuejs: 3.4.21

## Ejecución 

Para poder utilizar la aplicación es necesario ejecutar los siguientes comandos. Para el backend es necesario ingresar a la carpeta /backend y ejecutar.

```
# Instalación de gemas
bundle install

# Creación de BD
rails db:create
rails db:migrate

# Ejecución de task para obtener Feature
rails feature:get_feature

# Inicio de servidor
rails s 

```

Por otro lado, el frontend se ejecuta a través de la siguiente línea de comando. 

```
yarn serve
```
