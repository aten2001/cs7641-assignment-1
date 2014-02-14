#!/usr/bin/env bash
original_pwd=`pwd`
cd vendor
tar -xzvf jruby-bin-1.7.10.tar.gz
cd jruby-1.7.10/bin
export PATH=$PATH:`pwd`
cd $original_pwd
source bin/jruby_source.sh
