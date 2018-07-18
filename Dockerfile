FROM debian:testing

#   add the dependencies

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential locales cmake git qt5-default libqt5webkit5-dev qt5-image-formats-plugins libexiv2-dev libfftw3-single3 libtiff5-dev libjpeg-dev libpng-dev openexr libgsl-dev libraw-dev liblcms2-dev libboost-dev libcfitsio-dev ca-certificates ssl-cert

#   clone source code, checkout dev branch 

RUN mkdir -p ~/programs && git clone https://github.com/LuminanceHDR/LuminanceHDR.git ~/programs/code-lhdr && cd ~/programs/code-lhdr && git checkout master

#  compile

RUN mkdir ~/programs/code-lhdr/build && cd ~/programs/code-lhdr/build && cmake .. -DCMAKE_PREFIX_PATH=/usr/lib/x86_64-linux-gnu/qt5 -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON  -DCMAKE_CXX_FLAGS="-std=c++11 -Wno-deprecated-declarations -Wno-unused-result -O3 -pipe" -DCMAKE_C_FLAGS="-O3 -pipe"  -DCMAKE_INSTALL_BINDIR:STRING="/programs" -DCMAKE_BUILD_TYPE=Release
RUN cd ~/programs/code-lhdr/build && make install && chmod 777 /programs/luminancehdr

#   set entrypoint cmd

LABEL maintainer="kd6kxr@gmail.com"
CMD echo "This is a test..." && /programs/luminancehdr && echo "...THATS ALL FOLKS!!!"
