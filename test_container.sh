#!/usr/bin/env bash

singularity run --contain --cleanenv \
	--bind INPUTS:/tmp \
	--bind INPUTS:/INPUTS \
	--bind OUTPUTS:/OUTPUTS \
	afni-singularity_v1.0.4.simg \
	reface-pipeline.sh
