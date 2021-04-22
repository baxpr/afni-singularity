#!/usr/bin/env bash

singularity run --contain --cleanenv \
	--bind INPUTS:/tmp \
	--bind INPUTS:/INPUTS \
	--bind OUTPUTS:/OUTPUTS \
	afnitest.simg \
	reface-pipeline.sh
