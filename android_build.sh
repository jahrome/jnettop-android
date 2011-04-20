export NDK=/home/jer/Projet_android/android-ndk-r5
export TOOLCHAIN=/home/jer/standalone-toolchain
export AOSP=/home/jer/cm7
export PRODUCT=vision
export PATH=$TOOLCHAIN/bin/:$PATH

export CC=arm-linux-androideabi-gcc
export CFLAGS="-march=armv7-a -mfloat-abi=softfp -I$AOSP/external/libpcap -I$AOSP/external/gstreamer_aggregate/glib/glib -I$AOSP/external/gstreamer_aggregate/glib -I$AOSP/external/libncurses/include -DANDROID"
export CPPFLAGS=$CFLAGS
export LDFLAGS="-Wl,--fix-cortex-a8 -lsupc++ -L$AOSP/out/target/product/$PRODUCT/system/lib"
export LIBS="$TOOLCHAIN/arm-linux-androideabi/lib/libstdc++.a"

rm -rf $TOOLCHAIN
$NDK/build/tools/make-standalone-toolchain.sh --platform=android-9 --install-dir=$TOOLCHAIN

arm-linux-androideabi-gcc -shared -o $AOSP/out/target/product/$PRODUCT/system/lib/libpcap.so $AOSP/out/target/product/vision/obj/STATIC_LIBRARIES/libpcap_intermediates/pcap-linux.o $AOSP/out/target/product/vision/obj/STATIC_LIBRARIES/libpcap_intermediates/libpcap.a
autoreconf
./configure --host=arm-linux-androideabi --disable-multithreaded-resolver
make -j2
arm-linux-androideabi-strip jnettop
