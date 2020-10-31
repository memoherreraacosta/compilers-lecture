FROM clearlinux
RUN swupd bundle-add git vim graphviz sudo c-extras-gcc9 curl flex
RUN useradd -ms /bin/bash student
USER student
WORKDIR /home/student
RUN git clone https://github.com/memoherreraacosta/compilers-lecture.git
