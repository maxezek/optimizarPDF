# OptimizarPDF

**OptimizarPDF** es un fork de Compress PDF (script for nautilus by Ricardo Ferreira https://bazaar.launchpad.net/~oriolpont/compress-pdf/mine/files

En **MAX **disponemos de ghostscript y zenity. 

Se puede incluir en **CAJA** como un script.

Para su instalación hay que descargar el fichero **OptimizarPDF** a la carpeta oculta de usuario **~/.local/share/caja/scripts **y darle permisos de ejecución en un terminal:

	chmod +x ~/.local/share/nautilus/scripts/OptimizarPDF

o bien en entorno gráfico usar el menu de contexto **clic botón derecho > Propiedades > Permisos** y ahí habilitar **Permitir ejecutar al archivo como un programa**

Modo de uso es bastante sencillo. Desde el navegador de archivos CAJA se selecciona el fichero PDF (o ficheros) y con **clic botón derecho > Scripts > OptimizarPDF**


##Versión tonta de escritorio

Se trata simplemente de una ventana en zenity explicando que hay que hacer.

Sería un lanzador con **OptimizarPDFescritorio**

En la carpeta donde lo descarguemos hay que hacerlo ejecutable:

	chmod +x OptimizarPDFescritorio

El icono **OptimizarPDF.png** estaría en mismo directorio que el script.
