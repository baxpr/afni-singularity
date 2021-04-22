#!/usr/bin/env bash
#
# Pipeline for refacing an image using AFNI.

# Initialize defaults (will be changed later if passed as options)
export project=NO_PROJ
export subject=NO_SUBJ
export session=NO_SESS
export scan=NO_SCAN
export img_niigz=/INPUTS/t1.nii.gz

# Parse options
while [[ $# -gt 0 ]]; do
	key="${1}"
	case $key in
		--project)
			export project="${2}"; shift; shift ;;
		--subject)
			export subject="${2}"; shift; shift ;;
		--session)
			export session="${2}"; shift; shift ;;
		--scan)
			export scan="${2}"; shift; shift ;;
		--img_niigz)
			export img_niigz="${2}"; shift; shift ;;
		*)
			echo Unknown input "${1}"; shift ;;
	esac
done

# Reface
nm=$(basename "${img_niigz}" .nii.gz)
@afni_refacer_run \
	-input "${img_niigz}" \
	-mode_all \
	-prefix /OUTPUTS/${nm}

# Make PDF
info_string="$project $subject $session $scan"
thedate=$(date)
cd /OUTPUTS/${nm}_QC
for piece in deface face face_plus reface reface_plus ; do

montage \
-mode concatenate ${nm}.${piece}.???.png \
-tile 1x -trim -quality 100 -background white -gravity center -resize 2400x2800 \
-border 20 -bordercolor white ${piece}.png

convert -size 2600x3365 xc:white \
-gravity center \( ${piece}.png -resize '2400x3000' \) -composite \
-gravity center -pointsize 48 -annotate +0-1600 \
"${info_string}  :   ${piece}" \
-gravity SouthEast -pointsize 48 -annotate +100+50 "${thedate}" \
${piece}.png

done

convert deface.png face.png face_plus.png reface.png reface_plus.png /OUTPUTS/refacer.pdf
