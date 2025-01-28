set -e
export PATH=$CUDA_BASE:$PATH
nvcc -c -arch sm_100a $1.cu -o $1.o
cuobjdump -sass $1.o > $1.sass
