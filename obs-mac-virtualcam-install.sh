echo "OBSを取得中です。"
# Clone and build OBS
git clone --recursive https://github.com/obsproject/obs-studio.git
cd obs-studio
echo "OBSを取得完了。"
echo "Homebrewがインストールされているか確認中。"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo "Homebrew アップデート完了。"

echo "OBSのセットアップを実行中"
# Follow normal OBS build steps
brew install FFmpeg x264 Qt5 cmake mbedtls swig
mkdir build
cd build
export QTDIR=/usr/local/opt/qt
cmake .. && make -j

echo "OBSのプラグインを取得中"
# Clone this repo
cd ../..
git clone https://github.com/johnboiles/obs-mac-virtualcam.git
cd obs-mac-virtualcam

echo "STAP:Set an environment variable that points to the directory for your OBS clone"
# Set an environment variable that points to the directory for your OBS clone
export OBS_DIR=$PWD/../obs-studio

# Build the plugin
mkdir build
cd build
cmake -DLIBOBS_INCLUDE_DIR:STRING=$OBS_DIR/libobs -DLIBOBS_LIB:STRING=$OBS_DIR/build/libobs/libobs.dylib -DOBS_FRONTEND_LIB:STRING=$OBS_DIR/build/UI/obs-frontend-api/libobs-frontend-api.dylib -DQTDIR:STRING=/usr/local/opt/qt ..
make -j

# Copy the OBS plugin to your local OBS build
cp src/obs-plugin/obs-mac-virtualcam.so $OBS_DIR/build/rundir/RelWithDebInfo/obs-plugins/

# Remove any existing plugin and copy the DAL plugin to the right place
sudo rm -rf /Library/CoreMediaIO/Plug-Ins/DAL/obs-mac-virtualcam.plugin && sudo cp -r src/dal-plugin/obs-mac-virtualcam.plugin /Library/CoreMediaIO/Plug-Ins/DAL

echo "STAP:OBS実行"
# Run your build of OBS
cd $OBS_DIR/build/rundir/RelWithDebInfo/bin
./obs