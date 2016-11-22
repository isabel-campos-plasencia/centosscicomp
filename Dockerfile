
FROM centos:centos7

ENV OPENMPI_MAIN_V v2.0
ENV OPENMPI_VERSION openmpi-2.0.1
ENV OPENMPI_HOME /usr/local/$OPENMPI_VERSION

RUN yum -y groupinstall "Development Tools"

RUN yum -y install \
    wget \
    texlive \
    emacs \
    gnuplot

# Installing OpenMPI
 
RUN cd /usr/local/src && mkdir -p $OPENMPI_HOME  \
    wget https://www.open-mpi.org/software/ompi/$OPENMPI_MAIN_V/downloads/$OPENMPI_VERSION.tar.gz  \
    tar xzvf $OPENMPI_VERSION.tar.gz
    
RUN cd $OPENMPI_VERSION && ./configure --prefix=$OPENMPI_HOME \
    make && make install

RUN cd /usr/local && ln -s $OPENMPI_VERSION openmpi

RUN echo 'export GCC=gcc' > /etc/profile.d/scicomp.sh 
RUN echo 'export PATH=$PATH:/usr/local/openmpi/bin' >> /etc/profile.d/scicomp.sh
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/openmpi/lib' >> /etc/profile.d/scicomp.sh


CMD [ "/bin/bash" ]
