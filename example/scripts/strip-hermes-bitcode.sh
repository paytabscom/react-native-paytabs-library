#!/bin/bash

# Strip bitcode from Hermes framework
# This is necessary for iOS 26.1+ which no longer accepts bitcode in App Store submissions

echo "Stripping bitcode from Hermes framework..."

PODS_ROOT="${SRCROOT}/Pods"
HERMES_FRAMEWORK="${PODS_ROOT}/hermes-engine/destroot/Library/Frameworks/universal/hermes.xcframework"

if [ ! -d "$HERMES_FRAMEWORK" ]; then
    echo "Hermes framework not found at: $HERMES_FRAMEWORK"
    echo "Trying alternative path..."
    HERMES_FRAMEWORK="${PODS_ROOT}/hermes-engine/destroot/Library/Frameworks/universal/hermes.xcframework"
fi

if [ ! -d "$HERMES_FRAMEWORK" ]; then
    echo "Warning: Could not find Hermes framework path"
    exit 0
fi

# Find all Hermes binaries in the xcframework and strip bitcode
find "$HERMES_FRAMEWORK" -name "hermes" -type f | while read -r binary; do
    if [ -f "$binary" ]; then
        echo "Found Hermes binary: $binary"
        if otool -l "$binary" | grep -q "LC_SEGMENT_64 (__LLVM)"; then
            echo "Stripping bitcode from: $binary"
            xcrun bitcode_strip -r "$binary" -o "$binary"
            if [ $? -eq 0 ]; then
                echo "Successfully stripped bitcode from: $binary"
            else
                echo "Warning: Failed to strip bitcode from: $binary"
            fi
        else
            echo "No bitcode found in: $binary"
        fi
    fi
done

echo "Hermes bitcode stripping completed"