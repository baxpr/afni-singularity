Bootstrap: docker
From: ubuntu:20.04


%help
  Basic install of AFNI package in a singularity container.


%setup
  mkdir -p ${SINGULARITY_ROOTFS}/opt/afni


%files
  README.md    /opt/afni

 
%labels
  Maintainer baxter.rogers@vanderbilt.edu


%post

  ## General tools ("universe" needed for AFNI)
  apt update
  apt install -y software-properties-common
  add-apt-repository universe
  apt update
  apt install -y curl wget zip unzip bc

  ## For AFNI on Ubuntu 20.04, https://afni.nimh.nih.gov/
  
  # Packages
  apt install -y tcsh xfonts-base libssl-dev       \
                 python-is-python3                 \
                 python3-matplotlib                \
                 gsl-bin netpbm gnome-tweak-tool   \
                 libjpeg62 xvfb xterm vim curl     \
                 gedit evince eog                  \
                 libglu1-mesa-dev libglw1-mesa     \
                 libxm4 build-essential            \
                 libcurl4-openssl-dev libxml2-dev  \
                 libgfortran-8-dev libgomp1        \
                 gnome-terminal nautilus           \
                 gnome-icon-theme-symbolic         \
                 firefox xfonts-100dpi             \
                 r-base-dev

  # Make a symbolic link for the specific version of GSL in this version of Ubuntu
  ln -s /usr/lib/x86_64-linux-gnu/libgsl.so.23 /usr/lib/x86_64-linux-gnu/libgsl.so.19

  # AFNI binaries
  cd /opt/afni
  curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
  tcsh @update.afni.binaries -package linux_ubuntu_16_64 -do_extras -bindir /opt/afni/abin

  # AFNI setup and check
  cp /opt/afni/abin/AFNI.afnirc $HOME/.afnirc
  export PATH=/opt/afni/abin:${PATH}
  suma -update_env
  afni_system_check.py -check_all

  # Install R
  export R_LIBS=/opt/R
  mkdir  $R_LIBS
  echo  'export R_LIBS=/opt/R' >> ~/.bashrc
  rPkgsInstall -pkgs ALL

  ## Create input/output directories for binding
  mkdir /INPUTS && mkdir /OUTPUTS


%environment
  #export PATH=/opt/afni/abin:${PATH}


%runscript
  bash "$@"
