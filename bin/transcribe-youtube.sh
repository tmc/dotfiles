#!/bin/bash
set -euo pipefail

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg could not be found, please install it."
    exit 1
fi

# Resolve the full path of the input file
f=$(readlink -f "$1")

# If the file doesn't end in .wav, convert it to wav (replacing the extension)
ext="${f##*.}"
if [[ "${ext}" != "wav" ]]; then
  new_f="${f%.*}.wav"
  ffmpeg -i "$f" -vn -acodec pcm_s16le -ar 16000 "$new_f"
  f="$new_f"
fi

# Define the Whisper.cpp root directory
WHISPER_CPP_ROOT="${HOME}/go/src/github.com/ggerganov/whisper.cpp"

# Check if the Whisper.cpp root directory exists
if [[ ! -d "${WHISPER_CPP_ROOT}" ]]; then
  echo "Whisper.cpp root directory does not exist: ${WHISPER_CPP_ROOT}"
  exit 1
fi

# Change to the Whisper.cpp directory and run the command
(
  cd "${WHISPER_CPP_ROOT}"
  set -x
  ./main -f "$f" -m ./models/ggml-small.en-tdrz.bin -tdrz | tee -a "${f%.*}.txt"
)
