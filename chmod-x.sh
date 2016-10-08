#!/bin/bash
PWD=$(dirname $(readlink -f $0))
find $PWD -name '*.sh' -type f |xargs -r chmod +x  

