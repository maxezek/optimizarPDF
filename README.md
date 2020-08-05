![LogoOptimizarPDF](https://github.com/maxezek/optimizarPDF/blob/master/OptimizarPDF.png) 

# OptimizarPDF

>El README sigue una estructura cronológica paso a paso desde el primer descubrimiento y su adaptación a MAX como ya un programa en python. EN el futuro se cambiará y se usará la wiki


**OptimizarPDF** es un fork de Compress PDF (script for nautilus by Ricardo Ferreira https://bazaar.launchpad.net/~oriolpont/compress-pdf/mine/files

En **MAX** disponemos de ghostscript y zenity. 

Se puede incluir en **CAJA** como un script. El fichero con nombre OptimizarPDF es el script. 

Para su instalación hay que descargar el fichero **OptimizarPDF** a la carpeta oculta de usuario **~/.config/caja/scripts** y darle permisos de ejecución en un terminal:

	chmod +x ~/.config/caja/scripts/OptimizarPDF

o bien en entorno gráfico usar el menu de contexto **clic botón derecho > Propiedades > Permisos** y ahí habilitar **Permitir ejecutar al archivo como un programa**

Modo de uso es bastante sencillo. Desde el navegador de archivos CAJA se selecciona el fichero PDF (o ficheros) y con **clic botón derecho > Scripts > OptimizarPDF**


## Versión tonta de escritorio

Se trata simplemente de una ventana en zenity explicando que hay que hacer.

Sería un lanzador con **OptimizarPDFescritorio**

En la carpeta donde lo descarguemos hay que hacerlo ejecutable:

	chmod +x OptimizarPDFescritorio

El icono **OptimizarPDF.png** estaría en mismo directorio que el script.

## Versión como elemento del menú contextual en CAJA

En este caso lo que hacemos es copiar con sudo el fichero **OptimizarPDFmenu** en **/usr/bin** con permiso de ejecución. Y luego con **caja-utils** instalado ir a **Inicio > Sistema > Preferencias > Visualización y comportamiento > Herramienta de configuración de las acciones de Caja**

Allí seguir estos dos pantallazos **¡ojo! cambiar OptimizarPDF por OptimizarPDFmenu**

![pantallazo1](https://github.com/maxezek/optimizarPDF/blob/master/Captura%20de%20pantalla%20-2020-07-21%2018-35-07.png)
![pantallazo2](https://github.com/maxezek/optimizarPDF/blob/master/Captura%20de%20pantalla%20-2020-07-21%2018-35-57.png)

## Versión lista de escritorio

Si ya tengo una versión escirta en Python que convierte el script en un programita que aparece en la sección Oficina del menú de MAX. La podéis descargar desde:

https://github.com/maxezek/optimizarPDF/releases

Debería funcionar en una MAX 9 de 32 bits y luego en todas las superiores de 64 bits.

