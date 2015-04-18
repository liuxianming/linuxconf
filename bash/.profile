export PATH=$PATH:/home/xliu102/.linuxbrew/bin/

export PATH=/home/xliu102/torch/install/bin:$PATH  # Added automatically by torch-dist
export LD_LIBRARY_PATH=/home/xliu102/torch/install/lib:$LD_LIBRARY_PATH  # Added automatically by torch-dist
export DYLD_LIBRARY_PATH=/home/xliu102/torch/install/lib:$DYLD_LIBRARY_PATH  # Added automatically by torch-dist

# Add pylearn2 support
export PYLEARN2_DATA_PATH=/mnt/sdb/xliu102/data/pylearn2_data
export PYTHONPATH=/mnt/sdb/xliu102/code/DeepLearning/pylearn2:$PYTHONPATH
# add emacs support
alias semacs='emacs -nw'

# support for Intel MKL, TBB, and fortran compiler
source /opt/intel/bin/compilervars.sh intel64
#export PATH="/opt/intel/composer_xe_2013.2.146/bin/intel64:$PATH"
export LD_LIBRARY_PATH="/opt/intel/mkl/lib/intel64:/opt/intel/lib/intel64:$LD_LIBRARY_PATH"

export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/include/x86_64-linux-gnu/c++/4.8

#alias sudo='sudo env PATH=$PATH'
