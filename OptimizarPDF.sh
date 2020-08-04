#! /bin/bash
#-*- coding: utf-8 -*-

# Script bash de Optimizar PDF
# Basado en compress-pdf de:
# AUTHOR:		Ricardo Ferreira; oriolpont
# NAME:			Compress PDF 1.5
# DESCRIPTION:	A nice Nautilus script with a GUI to compress and optimize PDF files
# REQUIRES:		ghostscript, poppler-utils, zenity, sed, python-notify (optional)
# LICENSE:		GNU GPL v3 (http://www.gnu.org/licenses/gpl.html)
# WEBSITE:		https://launchpad.net/compress-pdf

# Versión para MAdrid-linuX, MAX por 
# AUTHOR:		Ezequiel Cabrillo, <ezequiel.cabrillo@educa.madrid.org>
# NAME:			OptimizarPDF
# Versión de escritorio que mantiene partes del original para Nautilus.
# Está forma parte de un código en Python. En la versión script completa se
# cambia Nautilus por Caja  

VERSION="0.1"
COMPRESSPDF_BATCH_ABORT_ERR=115

# Fichero PDF elegido en la ventana de Gtk3 de ID VFichero de optimizarpdf.py
FILE=$1

# Compresión elegida en la ventana de Gtk3 de ID Vseleccion de optimizarpdf.py
COMP_COMMAND=$2

echo $COMP_COMMAND

# Messages
		# English (en-US)
		error_nofiles="No file selected."
		error_noquality="No optimization level selected."
		error_ghostscript="PDF Compress requires the ghostscript package, which is not installed. Please install it and try again."
		error_nopdf="One or more files are not valid."
		label_filename="Save PDF as..."
		label_level="Please choose an optimization level below."
		optimization_level="Optimization Level"
		level_default="Default"
		level_screen="Screen-view only (72dpi)"
		level_low="Low Quality (150dpi)"
		level_high="High Quality (300dpi)"
		level_color="High Quality (Color Preserving) (300dpi)"
		job_done="has been successfully compressed"
		filename_suffix="_opt"
		label_suffix="Choose the suffix for the filenames."
		warning_overwrite="That will overwrite the original PDF files."
		error_zenity="Error - This script needs Zenity to run."


case $LANG in

	pt*)
		# Portuguese (pt-PT)
		error_nofiles="Nenhum ficheiro seleccionado."
		error_noquality="Nenhum nÃ­vel de optimizaÃ§Ã£o escolhido."
		error_ghostscript="O PDF Compress necessita do pacote ghostscript, que nÃ£o está instalado. Por favor instale-o e tente novamente."
		error_nopdf="O ficheiro seleccionado nÃ£o Ã© um ficheiro PDF válido."
		label_filename="Guardar PDF como..."
		label_level="Por favor escolha um nÃ­vel de optimizaÃ§Ã£o abaixo."
		optimization_level="NÃ­vel de OptimizaÃ§Ã£o"
		level_default="Normal"
		level_screen="VisualizaÃ§Ã£o no EcrÃ£ (72dpi)"
		level_low="Baixa Qualidade (150dpi)"
		level_high="Alta Qualidade (300dpi)"
		level_color="Alta Qualidade (PreservaÃ§Ã£o de Cores) (300dpi)"
		job_done="foi comprimido com sucesso"
		filename_suffix="_comprimido"
		label_suffix="Introduza o sufixo a utilizar no nome dos ficheiros comprimidos."
		warning_overwrite="Isto vai substituir os ficheiros PDF originais."
		error_zenity="Erro - Este script precisa do Zenity para funcionar.";;


	es*)
		# Spanish (es-AR) by Eduardo Battaglia and (es-ES) Ezequiel Cabrillo
		error_nofiles="Ningún archivo seleccionado."
		error_noquality="Ningún nivel de optimización escogido."
		error_ghostscript="OptimizarPDF necesita el paquete ghostscript, que no está instalado. Por favor instálelo e intente nuevamente."
		label_filename="Guardar PDF como..."
		label_level="Por favor escoja un nivel de optimización debajo."
		optimization_level="Nivel de Optimización"
		level_default="Normal, recomendado"
		level_screen="Sólo visualización en pantalla, 72 dpi"
		level_low="Calidad media para eBook, 150 dpi"
		level_high="Alta calidad para impresión, 300 dpi"
		level_color="Alta calidad (Preservación de Colores)"
		job_done="generado"
		filename_suffix="_opt"
		label_suffix="Elige el sufijo para el archivo optimizado"
		warning_overwrite="Esto sobreescribirá los PDF originales."
		error_zenity="Error - Este script necesita Zenity para ejecutarse";;


	cs*)
		# Czech (cz-CZ) by Martin PavlÃ­k
		error_nofiles="Nebyl vybrán Å¾ádnÃ½ soubor."
		error_noquality="Nebyla zvolena úroveÅˆ optimalizace."
		error_ghostscript="PDF Compress vyÅ¾aduje balÃ­Äek ghostscript, kterÃ½ nenÃ­ nainstalován. Nainstalujte jej prosÃ­m a opakujte akci."
		label_filename="UloÅ¾it PDF jako..."
		label_level="ProsÃ­m vyberte úroveÅˆ optimalizace z nÃ­Å¾e uvedenÃ½ch."
		optimization_level="ÃšroveÅˆ optimalizace"
		level_default="VÃ½chozÃ­"
		level_screen="Pouze pro ÄtenÃ­ na obrazovce"
		level_low="NÃ­zká kvalita"
		level_high="Vysoká kvalita"
		level_color="Vysoká kvalita (se zachovánÃ­m barev)";;


	fr*)
		# French (fr-FR) by Astromb
		error_nofiles="Aucun fichier sÃ©lectionnÃ©"
		error_noquality="Aucun niveau d'optimisation sÃ©lectionnÃ©"
		error_ghostscript="PDF Compress a besoin du paquet ghostscript, mais il n'est pas installÃ©. Merci de l'installer et d'essayer Ã  nouveau."
		error_nopdf="Le fichier que vous avez sÃ©lectionnÃ© n'est pas un PDF valide."
		label_filename="Sauvegarder le PDF sous..."
		label_level="Merci de choisir, ci-dessous, un niveau d'optimisation."
		optimization_level="Niveau d'optimisation"
		level_default="DÃ©faut"
		level_screen="Affichage Ã  l'Ã©cran"
		level_low="Basse qualitÃ©"
		level_high="Haute qualitÃ©"
		level_color="Haute qualitÃ© (Couleurs prÃ©servÃ©es)";;

	de*)
		# German (de-DE)
		error_nofiles="Keine Datei ausgewÃ¤hlt."
		error_noquality="Kein Kompressionsgrad ausgewÃ¤hlt."
		error_ghostscript="PDF Compress benÃ¶tigt das Paket ghostscript, welches nicht installiert ist. Bitte installieren und erneut versuchen."
		error_nopdf="Die ausgewÃ¤hlte Datei ist kein PDF oder defekt."
		label_filename="Speichern unter..."
		label_level="Bitte wÃ¤hlen Sie einen Komprimierungsgrad."
		optimization_level="Optimierungsgrad"
		level_default="Standard"
		level_screen="Bildschirm (72dpi)"
		level_low="Niedrige QualitÃ¤t (E-Book - 150dpi)"
		level_high="Hohe QualitÃ¤t (Ausdrucke - 300dpi)"
		level_color="Hohe QualitÃ¤t (Farbtreu - 300dpi)"
		job_done="wurde erfolgreich komprimiert"
		label_suffix="Datei-Endung wÃ¤hlen:"
		warning_overwrite="Dies wird die Orginal-PDF-Datei Ã¼berschreiben.";;

esac



# Las partes no traducidas se mantienen del script original de compress-pdf
# Check if all the arguments are proper PDF files

IS_PDF=$(file --brief --mime-type "$FILE" | grep -i "/pdf") # ignoring case for 'pdf'; as far as I know, the slash before (sth/pdf) is universal mimetype output. In most cases we can even expect 'application/pdf' (portability issues?).

if [ "x$IS_PDF" = x ];
then
	zenity --error --title="OptimizarPDF $VERSION" --text="$error_nopdf"
	exit 1
fi

# Everything is OK. We can go on.

# Ask the user to select an output format

# En el original se pueden seleccionar más de un fichero. Aquí optimizarpdf.py solo pasa uno.

# Choose output filename(s)
if [ $# -eq 1 ]
then
	pdf_file=$FILE
	suggested_filename=${pdf_file%.*}${filename_suffix}.${pdf_file##*.}
	ficherofinal="$ruta/$suggested_filename"
	output_filename=$(zenity --file-selection --save --confirm-overwrite --filename="$PWD/$suggested_filename" --title="$label_filename")
	if [ "$?" != "0"  -o  "x$output_filename" = x ]; then exit 1; fi
else
	filename_suffix=$(zenity --entry --title="OptimizarPDF $VERSION" --text="$label_suffix" --entry-text="$filename_suffix")
	if [ "$?" != "0" ]; then exit 1; fi
	if [ "x$filename_suffix" = x ]
		then if ! zenity --warning --title="OptimizarPDF $VERSION" --text="$warning_overwrite"; then exit 1; fi
	fi
	case "$filename_suffix" in */*) zenity --error --title="OptimizarPDF $VERSION"; exit 1; esac # Check if the specified suffix is legal (we use 'case' instead of 'if' to directly use asterisk * globbing -- and avoid [[...]] for portability)
fi

# Finally, we process the files

	pdf_file=$(basename "$FILE")
	output_filename=${pdf_file%.*}${filename_suffix}.${pdf_file##*.}
	output_name=$(basename "$output_filename")
	temp_pdfmarks=tmp-compresspdf-$output_name-pdfmarks
	temp_filename=tmp-compresspdf-$output_name

# Se añade una nueva variable para respetar al máximo el script original y 
# que el fichero resultante esté en el mismo directorio que el original.
	ruta=$(dirname "$FILE")

# Execute ghostscript while showing a progress bar

if [ -e $temp_pdfmarks  -o  -e $temp_filename ]; then $ZENITY --error --title="Optimizar PDF $VERSION"; exit 1; fi

# Extract metadata from the original PDF. This is not a crucial functionality, but maybe we could warn if pdfinfo or sed are not available	

pdfinfo "$FILE" | sed -e 's/^ *//;s/ *$//;s/ \{1,\}/ /g' -e 's/^/  \//' -e '/CreationDate/,$d' -e 's/$/)/' -e 's/: / (/' > "$temp_pdfmarks"

if ! grep /Title "$temp_pdfmarks"; then echo '  /Title ()' >> "$temp_pdfmarks"; fi # Warning: if the pdf has not defined a Title:, ghostscript makes a fontname become the title.
	
echo -e 0a'\n''  /Title ()''\n'.'\n'w | ed afile # use to prepend instead of append	
sed -i '1s/^ /[/' "$temp_pdfmarks"	
sed -i '/:)$/d' "$temp_pdfmarks"	
echo "  /DOCINFO pdfmark" >> "$temp_pdfmarks"


	# Execute ghostscript while showing a progress bar
	(
		gs -sDEVICE=pdfwrite -dPDFSETTINGS=$COMP_COMMAND -dColorConversionStrategy=/LeaveColorUnchanged -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -dSAFER -sOutputFile="$ruta/$temp_filename" "$FILE" "$temp_pdfmarks" & echo -e "$!\n"
		# we output the pid so that it passes the pipe; the explicit linefeed starts the zenity progressbar pulsation
	) | ( # the pipes create implicit subshells; marking them explicitly
		read PIPED_PID
		if zenity --progress --pulsate --auto-close --title="Optimizar PDF $VERSION"
		then
			rm "$temp_pdfmarks"
			mv -f "$ruta/$temp_filename" "$ruta/$output_filename" & # we go on to the next file as fast as possible (this subprocess survives the end of the script, so it is even safer)
			notify-send "Optimizar PDF" "$output_name $job_done"
		else
			kill $PIPED_PID
			rm "$temp_pdfmarks"
			rm "$ruta/$temp_filename"
			exit $COMPRESSPDF_BATCH_ABORT_ERR # Warning: it exits the subshell but not the script
		fi
	)
