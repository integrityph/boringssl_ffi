cd src
cmake -GNinja -B build
ninja -C build
cd ..
mv src/build/_deps/boringssl-src/include src/build/_deps/boringssl-src/include.bak
./src/process_header.py src/build/_deps/boringssl-src/include.bak src/build/_deps/boringssl-src/include
dart run ffigen --verbose all --config ffigen.yaml > ffigen.log
rm -rf src/build/_deps/boringssl-src/include
mv src/build/_deps/boringssl-src/include.bak src/build/_deps/boringssl-src/include