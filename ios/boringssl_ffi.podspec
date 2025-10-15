# In example/ios/boringssl_ffi.podspec
Pod::Spec.new do |s|
  s.name             = 'boringssl_ffi'
  s.version          = '0.0.1'
  s.summary          = 'BoringSSL FFI plugin for iOS.'
  s.description      = <<-DESC
A Flutter FFI plugin that integrates BoringSSL for iOS device (arm64) builds.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Name' => 'your.email@example.com' }
  s.source           = { :path => '.' }

  s.source_files = '../src/**/*'
  s.vendored_frameworks = 'Frameworks/boringssl_ffi.xcframework'
  s.platform = :ios, '15.6'

  s.prepare_command = <<-CMD
  set -ex # Exit immediately on error, echo commands

  FRAMEWORK_PATH="Frameworks/boringssl_ffi.xcframework"

  # Check if the framework already exists.
  if [ -d "$FRAMEWORK_PATH" ]; then
    # If it exists, print a message and exit the script successfully.
    echo "--- Framework found at ${FRAMEWORK_PATH}. Skipping build. ---"
    exit 0
  fi

  CMAKE_BUILD_DIR="build"
  rm -rf "$CMAKE_BUILD_DIR" # Clean build directory
  mkdir -p "$CMAKE_BUILD_DIR"

  cmake -S "../src" \
        -B "$CMAKE_BUILD_DIR" \
        -DCMAKE_OSX_ARCHITECTURES="arm64" \
        -DCMAKE_OSX_SYSROOT="iphoneos" \
        -GNinja
  
  # Build our specific 'boringssl_ffi' target
  cmake --build "$CMAKE_BUILD_DIR" -j

  echo "--- Creating xcframework ---"
  FRAMEWORK_NAME="boringssl_ffi"
  DYLIB_FILE="${CMAKE_BUILD_DIR}/lib/lib${FRAMEWORK_NAME}.dylib"
  NEW_DYLIB_ID="@rpath/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"
  install_name_tool -id "${NEW_DYLIB_ID}" "${DYLIB_FILE}"

  FRAMEWORK_DIR="${CMAKE_BUILD_DIR}/arm64-ios/${FRAMEWORK_NAME}.framework"
  mkdir -p "${FRAMEWORK_DIR}/Headers"
  cp -R "${CMAKE_BUILD_DIR}/_deps/boringssl-src/include/"* "${FRAMEWORK_DIR}/Headers/"

  cat > "${FRAMEWORK_DIR}/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>en</string>
	<key>CFBundleExecutable</key>
	<string>${FRAMEWORK_NAME}</string>
	<key>CFBundleIdentifier</key>
	<string>ph.integritynet.boringssl-ffi</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>${FRAMEWORK_NAME}</string>
  <key>MinimumOSVersion</key>
	<string>15.6</string>
	<key>CFBundlePackageType</key>
	<string>FMWK</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleVersion</key>
	<string>1</string>
</dict>
</plist>
EOF

  cp "${DYLIB_FILE}" "${FRAMEWORK_DIR}/${FRAMEWORK_NAME}"

  rm -rf "Frameworks/${FRAMEWORK_NAME}.xcframework" # Clean previous xcframework

  xcodebuild -create-xcframework \
    -framework "${FRAMEWORK_DIR}" \
    -output "Frameworks/${FRAMEWORK_NAME}.xcframework"

  echo "--- xcframework creation finished ---"
CMD

  s.dependency 'Flutter'
  s.swift_version = '5.0'
end