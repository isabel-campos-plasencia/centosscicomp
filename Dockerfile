
FROM centos:centos7

# In case we want to install openMPI from sources
#ENV OPENMPI_MAIN_V v2.0
#ENV OPENMPI_VERSION openmpi-2.0.1
#ENV OPENMPI_HOME /usr/local/$OPENMPI_VERSION

RUN yum -y groupinstall "Development Tools"

RUN yum -y install \
    wget \
    texlive \
    emacs \
    which \
    gnuplot \
    gsl* \
    gmp* \
    openmpi*

# Setting environment

RUN echo 'export GCC=gcc' > /etc/profile.d/scicomp.sh 
RUN echo 'export PATH=$PATH:/usr/lib64/openmpi/bin:/usr/lib64/openmpi/lib' >> /etc/profile.d/scicomp.sh
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/openmpi/lib' >> /etc/profile.d/scicomp.sh
RUN echo 'export MPI_INCLUDE=/usr/include/openmpi-x86_64' >> /etc/profile.d/scicomp.sh

# Creating regular user developer

RUN useradd developer

CMD [ "/bin/bash", "su developer"]


# Installing OpenMPI from sources
#WORKDIR /usr/local/src
#RUN mkdir -p $OPENMPI_HOME  
#RUN wget https://www.open-mpi.org/software/ompi/$OPENMPI_MAIN_V/downloads/$OPENMPI_VERSION.tar.gz
#RUN tar xzvf $OPENMPI_VERSION.tar.gz
#WORKDIR /usr/local/src/$OPENMPI_VERSION    
#RUN ./configure --prefix=$OPENMPI_HOME && make && make install
#WORKDIR /usr/local
#RUN ln -s $OPENMPI_VERSION openmpi
#RUN echo 'export PATH=$PATH:/usr/local/openmpi/bin' >> /etc/profile.d/scicomp.sh
#RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/openmpi/lib' >> /etc/profile.d/scicomp.sh


