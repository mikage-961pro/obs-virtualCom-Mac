# OBSプラグイン：virtualCom（Mac用）

このガイドを使用すると、OVSにvirtualCom（仮想カメラ）を追加することができます。

## Use
### build
```bash:Terminal Command
cd /location/of/file
chmod +x ./obs-mac-virtualcam-install.sh  
sudo ./obs-mac-virtualcam-install.sh
```

## Customer Use

1. Open Application folder.
2. Open /Applications/OBS.app/Contents/PlugIns
3. Copy obs-mac-virtualcam.so
4. Open /Library/CoreMediaIO/Plug-Ins/DAL/
5. Copy obs-mac-virtualcam.plugin


## Zoom 5.0 and Newer
Terminal Command
```
sudo codesign --remove-signature /Applications/zoom.us.app/
```
