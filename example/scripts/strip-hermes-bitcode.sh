#!/bin/bash

# Strip bitcode from Hermes framework
# This is necessary for iOS 26.1+ which no longer accepts bitcode in App Store submissions

set -e

echo "Stripping bitcode from Hermes framework..."

# Find the Pods directory - look in common locations
if [ -n "$SRCROOT" ]; then
    PODS_ROOT="$SRCROOT/Pods"
elif [ -d "example/ios/Pods" ]; then
    PODS_ROOT="example/ios/Pods"
elif [ -d "Pods" ]; then
    PODS_ROOT="Pods"
else
    echo "Warning: Could not find Pods directory"
    exit 0
fi

HERMES_FRAMEWORK="$PODS_ROOT/hermes-engine/destroot/Library/Frameworks/universal/hermes.xcframework"

if [ ! -d "$HERMES_FRAMEWORK" ]; then
    echo "Warning: Hermes framework not found at: $HERMES_FRAMEWORK"
    exit 0
fi

echo "Found Hermes framework at: $HERMES_FRAMEWORK"

# Find all Hermes binaries in the xcframework and strip bitcode
found_binary=0
find "$HERMES_FRAMEWORK" -name "hermes" -type f 2>/dev/null | while read -r binary; do
    if [ -f "$binary" ]; then
        echo "Found Hermes binary: $binary"
        found_binary=1

        # Check if binary contains bitcode
        if otool -l "$binary" 2>/dev/null | grep -q "__LLVM"; then
            echo "Bitcode detected. Stripping from: $binary"
            if xcrun bitcode_strip -r "$binary" -o "$binary" 2>/dev/null; then
                echo "Successfully stripped bitcode from: $binary"
            else
                echo "Warning: bitcode_strip may have failed, but continuing..."
            fi
        else
            echo "No bitcode found in: $binary"
        fi
    fi
done

echo "Hermes bitcode stripping completed"