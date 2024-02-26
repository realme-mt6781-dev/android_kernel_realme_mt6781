#!/bin/bash
clear
function compile() 
{
echo InfixKernel-spaced, CODENAMED - spaced
echo
sleep 3 >/dev/null
source ~/.bashrc && source ~/.profile
export LC_ALL=C && export USE_CCACHE=1
ccache -M 100G >/dev/null
export ARCH=arm64
export KBUILD_BUILD_HOST=InfixKernel-spaced
export KBUILD_BUILD_USER="HELLINFIX"

clangbin=clang/bin/clang
if ! [ -a $clangbin ]; then mkdir clang && cd clang
sudo apt install -y libelf-dev libarchive-tools zstd flex bc ccache
bash <(curl -s https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman) -S
bash <(curl -s https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman) --patch=glibc
ls
cd ..
fi
read -p "Wanna do dirty build? (Y/N): " build_type
if [[ $build_type == "N" || $build_type == "n" ]]; then
echo Deleting out directory and doing clean Build
sleep 3 >/dev/null
rm -rf out && mkdir -p out
fi
if [[ $build_type == "Y" || $build_type == "y" ]]; then
echo Warning :- Doing dirty build
sleep 3 >/dev/null
fi
if ! [[ $build_type == "Y" || $build_type == "y" ]]; then
if ! [[ $build_type == "N" || $build_type == "n" ]]; then
echo Invalid Input , Read carefully before typing
echo Trying to restart script
sleep 3 >/dev/null
. build.sh && exit
fi
fi

make O=out ARCH=arm64 spaced_defconfig

PATH="${PWD}/clang/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      CC="clang" \
                      LLVM=1 \
                      LLVM_IAS=1 \
                       CONFIG_NO_ERROR_ON_MISMATCH=y 2>&1 | tee error.log 
}

function zupload()
{
zimage=out/arch/arm64/boot/Image.gz-dtb
if ! [ -a $zimage ];
then
echo  " Failed to compile zImage, fix the errors first "
else
echo -e " Build succesful, generating flashable zip now "
rm -rf AnyKernel
git clone --depth=1 https://github.com/HELLINFIX/AnyKernel3 AnyKernel
cp out/arch/arm64/boot/Image.gz-dtb AnyKernel
cd AnyKernel
zip -r9 InfixKernel-spaced-OSS-Kernel.zip *
curl -sL https://git.io/file-transfer | sh
./transfer fio InfixKernel-spaced-OSS-Kernel.zip
cd ../
fi
}

compile
zupload
