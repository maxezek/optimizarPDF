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

# Versi�n para MAdrid-linuX, MAX por 
# AUTHOR:		Ezequiel Cabrillo, <ezequiel.cabrillo@educa.madrid.org>
# NAME:			OptimizarPDF
# Versi�n de escritorio que mantiene partes del original para Nautilus.
# Est� forma parte de un c�digo en Python. En la versi�n script completa se
# cambia Nautilus por Caja  

VERSION="0.1"
COMPRESSPDF_BATCH_ABORT_ERR=115

# Fichero PDF elegido en la ventana de Gtk3 de ID VFichero de optimizarpdf.py
FILE=$1

# Compresi�n elegida en la ventana de Gtk3 de ID Vseleccion de optimizarpdf.py
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
		error_noquality="Nenhum nível de optimização escolhido."
		error_ghostscript="O PDF Compress necessita do pacote ghostscript, que não est� instalado. Por favor instale-o e tente novamente."
		error_nopdf="O ficheiro seleccionado não é um ficheiro PDF v�lido."
		label_filename="Guardar PDF como..."
		label_level="Por favor escolha um nível de optimização abaixo."
		optimization_level="Nível de Optimização"
		level_default="Normal"
		level_screen="Visualização no Ecrã (72dpi)"
		level_low="Baixa Qualidade (150dpi)"
		level_high="Alta Qualidade (300dpi)"
		level_color="Alta Qualidade (Preservação de Cores) (300dpi)"
		job_done="foi comprimido com sucesso"
		filename_suffix="_comprimido"
		label_suffix="Introduza o sufixo a utilizar no nome dos ficheiros comprimidos."
		warning_overwrite="Isto vai substituir os ficheiros PDF originais."
		error_zenity="Erro - Este script precisa do Zenity para funcionar.";;


	es*)
		# Spanish (es-AR) by Eduardo Battaglia and (es-ES) Ezequiel Cabrillo
		error_nofiles="Ning�n archivo seleccionado."
		error_noquality="Ning�n nivel de optimizaci�n escogido."
		error_ghostscript="OptimizarPDF necesita el paquete ghostscript, que no est� instalado. Por favor inst�lelo e intente nuevamente."
		label_filename="Guardar PDF como..."
		label_level="Por favor escoja un nivel de optimizaci�n debajo."
		optimization_level="Nivel de Optimizaci�n"
		level_default="Normal, recomendado"
		level_screen="S�lo visualizaci�n en pantalla, 72 dpi"
		level_low="Calidad media para eBook, 150 dpi"
		level_high="Alta calidad para impresi�n, 300 dpi"
		level_color="Alta calidad (Preservaci�n de Colores)"
		job_done="generado"
		filename_suffix="_opt"
		label_suffix="Elige el sufijo para el archivo optimizado"
		warning_overwrite="Esto sobreescribir� los PDF originales."
		error_zenity="Error - Este script necesita Zenity para ejecutarse";;


	cs*)
		# Czech (cz-CZ) by Martin Pavlík
		error_nofiles="Nebyl vybr�n ž�dný soubor."
		error_noquality="Nebyla zvolena �roveň optimalizace."
		error_ghostscript="PDF Compress vyžaduje balíček ghostscript, který není nainstalov�n. Nainstalujte jej prosím a opakujte akci."
		label_filename="Uložit PDF jako..."
		label_level="Prosím vyberte �roveň optimalizace z níže uvedených."
		optimization_level="Úroveň optimalizace"
		level_default="Výchozí"
		level_screen="Pouze pro čtení na obrazovce"
		level_low="Nízk� kvalita"
		level_high="Vysok� kvalita"
		level_color="Vysok� kvalita (se zachov�ním barev)";;


	fr*)
		# French (fr-FR) by Astromb
		error_nofiles="Aucun fichier sélectionné"
		error_noquality="Aucun niveau d'optimisation sélectionné"
		error_ghostscript="PDF Compress a besoin du paquet ghostscript, mais il n'est pas installé. Merci de l'installer et d'essayer à nouveau."
		error_nopdf="Le fichier que vous avez sélectionné n'est pas un PDF valide."
		label_filename="Sauvegarder le PDF sous..."
		label_level="Merci de choisir, ci-dessous, un niveau d'optimisation."
		optimization_level="Niveau d'optimisation"
		level_default="Défaut"
		level_screen="Affichage à l'écran"
		level_low="Basse qualité"
		level_high="Haute qualité"
		level_color="Haute qualité (Couleurs préservées)";;

	de*)
		# German (de-DE)
		error_nofiles="Keine Datei ausgewählt."
		error_noquality="Kein Kompressionsgrad ausgewählt."
		error_ghostscript="PDF Compress benötigt das Paket ghostscript, welches nicht installiert ist. Bitte installieren und erneut versuchen."
		error_nopdf="Die ausgewählte Datei ist kein PDF oder defekt."
		label_filename="Speichern unter..."
		label_level="Bitte wählen Sie einen Komprimierungsgrad."
		optimization_level="Optimierungsgrad"
		level_default="Standard"
		level_screen="Bildschirm (72dpi)"
		level_low="Niedrige Qualität (E-Book - 150dpi)"
		level_high="Hohe Qualität (Ausdrucke - 300dpi)"
		level_color="Hohe Qualität (Farbtreu - 300dpi)"
		job_done="wurde erfolgreich komprimiert"
		label_suffix="Datei-Endung wählen:"
		warning_overwrite="Dies wird die Orginal-PDF-Datei überschreiben.";;

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

# En el original se pueden seleccionar m�s de un fichero. Aqu� optimizarpdf.py solo pasa uno.

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

# Se a�ade una nueva variable para respetar al m�ximo el script original y 
# que el fichero resultante est� en el mismo directorio que el original.
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
