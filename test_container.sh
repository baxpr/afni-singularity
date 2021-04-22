#!/usr/bin/env bash

singularity run --contain --cleanenv \
	--bind INPUTS:/tmp \
	--bind INPUTS:/INPUTS \
	--bind OUTPUTS:/OUTPUTS \
	afnitest.simg \
	@afni_refacer_run \
	-input /INPUTS/t1.nii.gz \
	-mode_all \
	-prefix /OUTPUTS/t1
