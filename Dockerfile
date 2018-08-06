FROM kd6kxr/buildqt

#   add the dependencies

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential locales pkg-config cmake cmake-data libgl1-mesa-dri libgl1-mesa-dev libglu1-mesa-dev autotools-dev libomp-dev git libexiv2-dev libfftw3-dev libtiff5-dev libjpeg-dev libpng-dev libopenexr-dev libgsl-dev libraw-dev liblcms2-dev libboost-all-dev libcfitsio-dev ca-certificates ssl-cert && apt-get clean

#   clone source code, checkout dev branch 

RUN mkdir -p ~/programs && git clone https://github.com/LuminanceHDR/LuminanceHDR.git ~/programs/code-lhdr && cd ~/programs/code-lhdr && git checkout master

#  compile

RUN export QT=/opt/local/Qt && mkdir ~/programs/code-lhdr/build && cd ~/programs/code-lhdr/build && cmake .. -DCMAKE_C_COMPILER="/usr/bin/gcc"       -DCMAKE_CXX_COMPILER="/usr/bin/g++" -DCMAKE_BUILD_TYPE="Release"  -DCMAKE_VERBOSE_MAKEFILE=1 -DCMAKE_CXX_FLAGS=" -O3   -march=x86-64 -std=gnu++11"   -DUPDATE_TRANSLATIONS=1  -DCMAKE_PREFIX_PATH=$(echo $QT/lib/cmake/* | sed -Ee 's$ $;$g')
RUN cd ~/programs/code-lhdr/build && make -j2 install

#   set entrypoint cmd

LABEL maintainer="kd6kxr@gmail.com"
CMD echo "This is a test..." && LD_LIBRARY_PATH=/opt/local/Qt/lib /usr/local/bin/luminance-hdr && echo "...THATS ALL FOLKS!!!"
