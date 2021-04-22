Bootstrap: docker
From: ubuntu:20.04


%help
  Basic install of AFNI package in a singularity container.


%files
  README.md    /opt
  src          /opt

 
%labels
  Maintainer baxter.rogers@vanderbilt.edu


%post

  ## General tools
  #     universe needed for AFNI
  #     software-properties-common needed for universe
  apt update
  apt install -y software-properties-common
  add-apt-repository universe
  apt update
  apt install -y curl wget zip unzip bc ghostscript imagemagick

  ## Fix imagemagick policy to allow output. See https://usn.ubuntu.com/3785-1/
  sed -i 's/rights="none" pattern="PDF"/rights="read | write" pattern="PDF"/' \
    /etc/ImageMagick-6/policy.xml
  sed -i 's/rights="none" pattern="@\*"/rights="read" pattern="@*"/' \
    /etc/ImageMagick-6/policy.xml

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
  mkdir /opt/afni && cd /opt/afni
  curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
  tcsh @update.afni.binaries -package linux_ubuntu_16_64 -do_extras -bindir /opt/afni/abin

  # AFNI setup and check
  export PATH=/opt/afni/abin:${PATH}
  suma -update_env
  afni_system_check.py -check_all

  # Install R packages for AFNI
  export R_LIBS=/opt/R
  mkdir $R_LIBS
  rPkgsInstall -pkgs ALL

  ## Create input/output directories for binding
  mkdir /INPUTS && mkdir /OUTPUTS && mkdir /wkdir


%environment
  export R_LIBS=/opt/R
  export PATH=/opt/afni/abin:${PATH}
  export PATH=/opt/src:${PATH}


%runscript

  # Run the provided command line in xvfb
  xwrapper.sh "$@"
