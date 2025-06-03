# analisis-matrices-primas

## Primeros pasos

Este repositorio utiliza **micromamba** para gestionar un entorno de R aislado, sin necesidad de instalar R globalmente.
Sin embargo, para utilizar RStudio sí se requiere instalación global.

A continuación se indican los pasos para empezar a trabajar en el proyecto.

### 1. Instalar micromamba

Para instalar micromamba en Debian, se pueden seguir los siguientes pasos:

1. Descargar y extraer micromamba

    ```bash
    curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
    ```

2. Mover micromamba a un directorio del $PATH

    ```bash
    sudo mkdir -p /opt/micromamba
	sudo mv bin/micromamba /opt/micromamba/
	sudo ln -s /opt/micromamba/micromamba /usr/local/bin/micromamba
    ```
    
3. Activar los comandos `micromamba activate` y `micromamba deactivate`

    ```bash
    micromamba shell init -s bash -r ~/micromamba
	source ~/.bashrc
    ```
    
4. Verificar instalación

    ```bash
    micromamba --version
    ```
    
Más información y opciones para otros sistemas operativos están disponibles en [la página oficial de micromamba](https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html).
    
### 2. Instalar RStudio

Para instalar RStudio en Debian, se pueden seguir los siguientes pasos:

1. Si no lo tienes ya, instala Gdebi, una una aplicación que facilita la instalación de paquetes .deb

    ```bash
    sudo apt update
    sudo apt install gdebi-core
    ```
    
2. Descarga el archivo .deb correspondiente desde [RStudio Desktop](https://posit.co/download/rstudio-desktop/)

3. Instalar el paquete desde la carpeta en la que se ha guardado

    ```bash
    sudo gdebi rstudio-xxx.deb
    ```
    
### 3. Clonar este repositorio

```bash
git clone git@github.com:pepamontero/analisis-matrices-primas.git
cd analisis-matrices-primas
```
    
### 4. Crear el entorno de micromamba

Una descripción de los paquetes necesarios para este proyecto se encuentra en el archivo `environment.yml`, incluido en el repositorio. Para reproducir el entorno, basta con ejecutar:

```bash
micromamba create -n r-env -f environment.yml
```

### 5. Activar el entorno creado

```bash
micromamba activate r-env
```

¡Listo para trabajar en local!

### 6. (Opcional) Añadir otros paquetes al entorno

Para añadir un paquete package-name al entorno, puedes utilizar (con el entorno activo):

```bash
micromamba install <package-name> -c conda-forge
```

Sin embargo, como siempre utilizaremos `conda-forge`, puedes configurarlo (solo una vez) para poder omitir esta parte:

```bash
micromamba config append channels conda-forge
micromamba config set channel_priority strict
```

A partir de aquí, para añadir paquetes valdrá con

```bash
micromamba install <package-name>
```



## Trabajar colaborativamente en el proyecto

Conforme el proyecto avance, es posible que el entorno que estamos utilizando también lo haga. Es importante tener cuidado con esto puesto que el entorno no se actualiza automaticamente para el resto de usuarios simplemente utilizando `git pull`.

A continuación se explican varias herramientas que necesitarás para trabjar de manera colaborativa.

Nota: se recomienda mucho utilizar diferentes branches en cualquier caso para trabajar de manera colaborativa en este proyecto.

### Modificar el entorno

Si quieres añadir (o eliminar) paquetes al entorno, y quieres publicar estos cambios, debes exportar los datos de micromamba utilizando

```bash
micromamba activate r-env
micromamba env export --no-builds | grep -v "prefix:" > environment.yml
```

Si utilizas este nombre, se reescribirá automaticamente. Después puedes publicar los cambios con `git push`.

### Actualizar el entorno

Antes de nada, hay dos scripts que facilitarán este proceso:

- `check_env_change.sh`: antes de hacer `pull`, comprueba si habrá cambios en `environment.yml`
- `sync_env.sh`: vuelve a crear el entorno, basándose en el archivo `environment.yml` disponible en local

Para poder utilizarlos, necesitas convertirlos en ejecutables (haz esto fuera del entorno):

```bash
chmod +x check_env_change.sh
chmod +x sync_env.sh
```

Si puede que otro compañero haya modificado el entorno, antes de hacer pull, comprueba si hay cambios con

```bash
./check_env_change.sh
```

Si no hay cambios, puedes hacer pull y terminar. Si hay cambios, primero haz pull, y después actualiza el entorno mediante

```bash
./sync_env.sh
```
