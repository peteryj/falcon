This post will show how to setup a development environment to work with Falcon.

### Preequisites
Falcon only implements object sever at the moment. That means we must have an existing Swift environment. If you don't have one yet, please refer [Tiny Swift](tiny-swift/README.md) to create a lightweight Swift environment.

### Install RocksDB
[RocksDB](https://github.com/facebook/rocksdb) is adopted as the underlying DB in Falcon pack engine. It is implemented with C++ but Falcon is implemnted with Go. So we use a Go wrapper called [gorocksdb](https://github.com/tecbot/gorocksdb) to interoperate with RocksDB. For some reasons currently we only work with RocksDB 5.2.1.

```
sudo yum install epel-release -y
sudo yum group install "Development Tools"  -y
sudo yum install gflags snappy-devel zlib-devel bzip2-devel -y
git clone https://github.com/facebook/rocksdb.git
cd rocksdb
git checkout v5.2.1 -b falcon
make static_lib
sudo make install
```

The build could take several minutes, so keep patient.

### Install Golang

Falcon requires Golang 1.10 or later.

```
wget https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz
sudo tar xf go1.10.2.linux-amd64.tar.gz -C /usr/local/
export PATH=$PATH:/usr/local/go/bin
```

### Build Falcon

```
export GOPATH=~/go
mkdir -p $GOPATH
go get -u github.com/iqiyi/falcon
cd $GOPATH/src/github/iqiyi/falcon
make all
```

The standalone binary file is placed under `bin` directory of the project root. Check the version of Falcon

```
bin/falcon version
```
