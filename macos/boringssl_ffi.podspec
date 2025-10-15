# #
# # To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# # Run `pod lib lint boringssl_ffi.podspec` to validate before publishing.
# #
# Pod::Spec.new do |s|
#   s.name             = 'boringssl_ffi'
#   s.version          = '0.0.1'
#   s.summary          = 'A new Flutter FFI plugin project.'
#   s.description      = <<-DESC
# A new Flutter FFI plugin project.
#                        DESC
#   s.homepage         = 'http://example.com'
#   s.license          = { :file => '../LICENSE' }
#   s.author           = { 'Your Company' => 'email@example.com' }

#   # This will ensure the source files in Classes/ are included in the native
#   # builds of apps using this FFI plugin. Podspec does not support relative
#   # paths, so Classes contains a forwarder C file that relatively imports
#   # `../src/*` so that the C sources can be shared among all target platforms.
#   s.source           = { :path => '.' }
#   s.source_files = 'Classes/**/*'

#   # If your plugin requires a privacy manifest, for example if it collects user
#   # data, update the PrivacyInfo.xcprivacy file to describe your plugin's
#   # privacy impact, and then uncomment this line. For more information,
#   # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
#   # s.resource_bundles = {'boringssl_ffi_privacy' => ['Resources/PrivacyInfo.xcprivacy']}

#   s.dependency 'FlutterMacOS'

#   s.platform = :osx, '10.11'
#   s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
#   s.swift_version = '5.0'
# end

# In boringssl_ffi/macos/boringssl_ffi.podspec

Pod::Spec.new do |s|
  s.name             = 'boringssl_ffi'
  s.version          = '0.0.0'
  s.summary          = 'A new Flutter FFI plugin project.'
  s.description      = <<-DESC
A new Flutter FFI plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }

  # This is the key: We tell CocoaPods where to find our source files.
  # The Flutter FFI build system sees that this path includes our src/CMakeLists.txt
  # and automatically knows to run it.
  s.source_files = '../src/**/*'

  info_plist_content_ruby_interpolated = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
    <key>CFBundleExecutable</key>
    <string>${FRAMEWORK_NAME}</string>
    <key>CFBundleIdentifier</key>
    <string>ph.integritynet.boringssl_ffi</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>${FRAMEWORK_NAME}</string>
    <key>CFBundlePackageType</key>
    <string>FMWK</string>
    <key>CFBundleShortVersionString</key>
    <string>#{s.version}</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>CFBundleVersion</key>
    <string>#{s.version}</string>
    <key>LSMinimumSystemVersion</key>
    <string>15.0</string>
    <key>NSPrincipalClass</key>
    <string></string>
</dict>
</plist>"

  s.prepare_command = <<-CMD
  set -e
  echo "--- Starting CMake build for boringssl_ffi ---"
  
  CMAKE_BUILD_DIR="build"
  rm -rf "$CMAKE_BUILD_DIR" # Clean build directory
  mkdir -p "$CMAKE_BUILD_DIR"
  
  # We now explicitly pass the architecture to CMake.
  cmake -S "../src" -B "$CMAKE_BUILD_DIR" -DCMAKE_OSX_ARCHITECTURES="$(uname -m)" -DCMAKE_OSX_SYSROOT=macosx

  # Compile using multiple cores
  cmake --build "$CMAKE_BUILD_DIR" -j

  FRAMEWORK_NAME="boringssl_ffi"


  # --- CRITICAL NEW STEP: Use install_name_tool to fix dylib's internal ID ---
  # Define the new desired internal ID for the dylib when it's part of the framework
  NEW_FRAMEWORK_DYLIB_ID="@rpath/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" 
  
  # Path to the dylib *after* CMake builds it, but *before* it's copied into the framework structure
  DYLIB_BUILD_PATH="${CMAKE_BUILD_DIR}/lib/lib${FRAMEWORK_NAME}.dylib"
  
  echo "DEBUG: Fixing dylib install name with install_name_tool..."
  echo "DEBUG:   Original ID (from otool -L): @rpath/libboringssl_ffi.dylib"
  echo "DEBUG:   New desired ID: ${NEW_FRAMEWORK_DYLIB_ID}"
  echo "DEBUG:   Modifying binary at: ${DYLIB_BUILD_PATH}"
  
  # Execute install_name_tool to change the internal ID of the dylib
  install_name_tool -id "${NEW_FRAMEWORK_DYLIB_ID}" "${DYLIB_BUILD_PATH}"
  
  echo "DEBUG: install_name_tool completed."

  # --- End install_name_tool step ---


  FRAMEWORK_DIR="${CMAKE_BUILD_DIR}/${FRAMEWORK_NAME}.framework"
  rm -rf "${FRAMEWORK_DIR}"
  mkdir -p "${FRAMEWORK_DIR}/Versions/A/Headers"
  mkdir -p "${FRAMEWORK_DIR}/Versions/A/Resources"
  cp "${CMAKE_BUILD_DIR}/lib/lib${FRAMEWORK_NAME}.dylib" "${FRAMEWORK_DIR}/Versions/A/${FRAMEWORK_NAME}"
  ln -s A "${FRAMEWORK_DIR}/Versions/Current"
  ln -s Versions/Current/${FRAMEWORK_NAME} "${FRAMEWORK_DIR}/${FRAMEWORK_NAME}"
  ln -s Versions/Current/Headers "${FRAMEWORK_DIR}/Headers"
  ln -s Versions/Current/Resources "${FRAMEWORK_DIR}/Resources"
  cp -R "build/_deps/boringssl-src/include/"* "${FRAMEWORK_DIR}/Versions/A/Headers/"

  cat > "${FRAMEWORK_DIR}/Info.plist" <<~EOF
#{info_plist_content_ruby_interpolated}

CMD
  s.vendored_frameworks = 'build/boringssl_ffi.framework'

  s.dependency 'FlutterMacOS'
  # Let's target a more modern version of macOS to ensure compatibility.
  s.platform = :osx, '15.0'

  # Standard Flutter configuration
  # s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EMBEDDED_CONTENT_CONTAINS_HEADERS' => 'YES' }
  s.swift_version = '5.0'
end