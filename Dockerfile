FROM ubuntu:15.10

# development tools to based install
RUN apt-get update && apt-get install -y \
  autoconf \
  automake \
  libtool \
  autotools-dev \
  build-essential \
  checkinstall \
  libjpeg-dev \
  libpng-dev \
  libtiff-dev \
  python \
  python-imaging \
  python-tornado \
  wget \
  imagemagick \
  python-pip \
  bc \
  zlib1g-dev


# Compile tesseract dependencies
RUN mkdir ~/temp \
  && cd ~/temp/ \
  && wget http://www.leptonica.org/source/leptonica-1.73.tar.gz \
  && tar -zxvf leptonica-1.73.tar.gz \
  && cd leptonica-1.73 \
  && ./configure \
  && make \
  && make install \
  && ldconfig

# Compile tesseract 3.04.01 from source
RUN cd ~/temp/ \
  && wget http://github.com/tesseract-ocr/tesseract/archive/3.04.01.tar.gz \
  && tar xvf 3.04.01.tar.gz \
  && cd tesseract-3.04.01 \
  && ./autogen.sh \
  && ./configure --prefix=/usr/local/ \
  && make \
  && make install \
  && ldconfig \
  && cd /usr/local/share \
  && wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.eng.tar.gz \
  && tar xvf tesseract-ocr-3.02.eng.tar.gz

ENV TESSDATA_PREFIX /usr/local/share/tesseract-ocr


# Install pytesseract
RUN pip install --upgrade pip \
  && pip install pytesseract==0.1.6  

# Add textcleaner from Fred's ImageMagick Scripts
# http://www.fmwconcepts.com/imagemagick/textcleaner/
ADD ./bin/textcleaner /usr/local/bin

# Add sample images for testing
ADD ./data/* /data/

# create user tesseract for use with this server
RUN groupadd -r tesseract && useradd -r -g tesseract tesseract
USER tesseract

