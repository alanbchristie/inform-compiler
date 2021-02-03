#!/usr/bin/env bash

# The user is expected to have mounted their story into the container
# at '/story.inform' so that the story text should be found in the container
# at '/story.inform/Source/story.ni'.
#
# Here we run the various compilers to generate two game files: -
#
#  - '/story.inform/story.ulx'
#  - '/story.inform/story.gblorb'

set -e

STORY_DIR=/story.inform

# Create the uuid.txt file?
if [ ! -e "${STORY_DIR}/uuid.txt" ]; then
    # Generate a lower-case UUID.
    # The file cannot have a line-feed.
    uuid=$(uuidgen)
    uuid=${uuid,,}
    printf "%s" "${uuid}" > ${STORY_DIR}/uuid.txt
fi

# Run ni, inform6 and then cBlorb...
ni --release \
	--internal /usr/local/share/inform7/Internal \
	--format=ulx \
	--project ${STORY_DIR}

# The inform6 compiler gives us our `.ulx' file
inform6 -kw~S~DG +include_path=${STORY_DIR}/Source \
	${STORY_DIR}/Build/auto.inf \
	${STORY_DIR}/Build/output.ulx

# The cBlorb gives us our '.gblorb' file
cBlorb ${STORY_DIR}/Release.blurb ${STORY_DIR}/story.gblorb

# Copy the ulx file into place
cp ${STORY_DIR}/Build/output.ulx ${STORY_DIR}
