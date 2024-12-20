#!/bin/bash

# Define variables
SOURCES=$(ls *.tex)
BUILD_DIR="build.nosync"
LATEXMK="latexmk"
LATEXMKFLAGS="-xelatex -outdir=$BUILD_DIR -silent"

# Create the build directory if it doesn't exist
mkdir -p $BUILD_DIR

# Build all PDF targets
for source in $SOURCES; do
    target="${source%.tex}.pdf"
    echo "Building $target..."
    $LATEXMK $LATEXMKFLAGS $source
    cp "$BUILD_DIR/$target" .
done

echo "Build complete."
