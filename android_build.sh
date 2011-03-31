export CC=agcc3
autoreconf
CFLAGS=-DANDROID ./configure --host=arm-eabi --build=i686
make -j2
