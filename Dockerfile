FROM debian:stretch
ENV http_proxy '-H unix:///var/lib/docker/docker.sock'
RUN export http_proxy=$HTTP_PROXY
RUN echo http_proxy=-H unix:///var/lib/docker/docker.sock >> /etc/environment·

MAINTAINER Jochen Saalfeld "jochen@intevation.de"


RUN apt-get update && \
	apt-get install -y build-essential git autoconf automake mingw-w64 mingw-w64-i686-dev \
		mingw-w64-x86-64-dev nsis stow unzip imagemagick texlive \
		latex-xcolor libglib2.0-dev gettext docbook-utils ghostscript \
		texinfo libgdk-pixbuf2.0-dev texlive-latex-extra libqt4-dev-bin \
		wget mingw-w64 texlive-lang-german cmake libgtk2.0-bin \
		libxml2-utils gpgsm libgettextpo-dev

RUN useradd -d /home/gpg4win -m gpg4win

#CMD useradd -u $(stat -c "%u" /build) gpg4win
USER gpg4win
#VOLUME ["/build"]
WORKDIR /build/gpg4win/
CMD cd packages && \
	sh download.sh && \
	cd .. && \
	./autogen.sh --force && \
	./autogen.sh --build-w32 && \
	make 
