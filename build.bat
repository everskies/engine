pushd ..
CALL python flutter/tools/gn --unoptimized --runtime-mode=debug --android-cpu=arm64
CALL python flutter/tools/gn --android --unoptimized --runtime-mode=debug --android-cpu=arm64
CALL python flutter/tools/gn --android --runtime-mode=profile --android-cpu=arm64
CALL python flutter/tools/gn --android --runtime-mode=release --android-cpu=arm64

CALL ninja -C out/host_debug_unopt_arm64
CALL ninja -C out/android_debug_unopt_arm64
CALL ninja -C out/android_profile_arm64
CALL ninja -C out/android_release_arm64
