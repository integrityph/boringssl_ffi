# make sure you compile for LInux/Windows/MacOS before you run this command from
# within the os folder inside the repo.
LD_LIBRARY_PATH=$PWD/linux/build/lib:$LD_LIBRARY_PATH flutter test test/crypto/pkcs/run_test.dart