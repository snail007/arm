ROOT_DIR=$(dirname $(readlink -f $0))
. $ROOT_DIR/functions/functions
cd $ROOT_DIR

echo $(pm_randstr 4)