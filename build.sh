set -ex

#cd ~/dev/engine/src/flutter
cd ~/dev/flutter-engine/engine/src/flutter/
#git fetch upstream
#git rebase upstream/main
gclient sync
cd ..

flutter/tools/gn --unoptimized --runtime-mode=debug --android-cpu=arm64
flutter/tools/gn --android --unoptimized --runtime-mode=debug --android-cpu=arm64
flutter/tools/gn --android --runtime-mode=profile --android-cpu=arm64
flutter/tools/gn --android --runtime-mode=release --android-cpu=arm64

cd out
find . -mindepth 1 -maxdepth 1 -type d | xargs -n 1 sh -c 'ninja -C $0 || exit 255'
