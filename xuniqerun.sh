#!/bin/sh

# uniquify and sort the Xcode projct files
python -mxUnique "${PROJECT_FILE_PATH}/project.pbxproj"
