FROM clearlinux
RUN swupd bundle-add git vim graphviz c-extras-gcc9 curl flex bison
RUN useradd -ms /bin/bash student
USER student
WORKDIR /home/student
RUN git clone https://github.com/memoherreraacosta/compilers-lecture.git
