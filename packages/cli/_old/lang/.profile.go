

prepare_go() {
#  export GOROOT=$HOME/go
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
}


uname -a | grep Darwin > /dev/null \
  && export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

mkdir -p $HOME/bin
export PATH="$HOME/bin:$PATH"

which go > /dev/null && prepare_go
