sudo apt install build-essential git m4 scons zlib1g zlib1g-dev \
    libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev \
    python3-dev libboost-all-dev pkg-config libhdf5-dev libpng-dev mold pip libcapstone-dev

pip install -r requirements.txt

scons build/RISCV/gem5.opt -j 8 --linker=mold
