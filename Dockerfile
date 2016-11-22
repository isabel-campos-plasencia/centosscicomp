
FROM centos:centos7

RUN yum group install "Development Tools"

RUN yum install wget
RUN yum install texlive
RUN yum install emacs
RUN yum install gnuplot

# Installing OpenMPI

RUN mkdir /usr/local/src 
RUN cd /usr/local/src
RUN wget https://www.open-mpi.org/software/ompi/v2.0/downloads/openmpi-2.0.1.tar.gz
RUN tar xzvf openmpi-2.0.1.tar.gz
RUN cd openmpi-2.0.1
RUN ./configure --prefix=/usr/local/openmpi-2.0.1
RUN make
RUN make install
RUN cd /usr/local
RUN ln -s openmpi-2.0.1 openmpi

RUN echo 'export GCC=gcc' > /etc/profile.d/scicomp.sh 
RUN echo 'export PATH=$PATH:/usr/local/openmpi/bin' >> /etc/profile.d/scicomp.sh
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/openmpi/lib' >> /etc/profile.d/scicomp.sh


CMD [ "/bin/bash" ]
