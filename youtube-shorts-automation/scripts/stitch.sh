#!/usr/bin/env bash
# stitch.sh — join YouTube Shorts scene clips into one 720x1280 portrait video.
#
# Part of the youtube-shorts-automation Claude skill.
# See youtube-shorts-automation/SKILL.md, Step 5, for the full workflow.
#
# What it does:
#   Concatenates the scene clips in order (scene1.mp4 … scene6.mp4;
#   4 scenes for 40 seconds, 6 scenes for 60 seconds) into a single
#   9:16 portrait vertical, 720x1280 video, 60 seconds or less, with audio kept.
#   It re-encodes so clips of slightly different sizes / frame rates join
#   cleanly, and scales/pads the result to exactly 720x1280.
#
# Usage:
#   ./stitch.sh <clips_dir> [output.mp4] [voiceover.m4a]
#
#   <clips_dir>   Directory containing the scene clips, named in order:
#                   scene1.mp4 scene2.mp4 scene3.mp4 scene4.mp4 scene5.mp4 scene6.mp4
#                   (Any .mp4 names work, as long as they sort in scene order.)
#   [output.mp4]  Output file. Default: <clips_dir>/../short-final.mp4
#   [voiceover.m4a] Optional separate voiceover audio file. If given, it
#                   replaces the clips' own audio. If omitted, clip audio is kept.
#
# Examples:
#   ./stitch.sh ./short-01
#   ./stitch.sh ./short-01 ./short-01-final.mp4
#   ./stitch.sh ./short-01 ./short-01-final.mp4 ./short-01-voiceover.m4a
#
# Requirements: ffmpeg and ffprobe on PATH. No credentials, no network.
# Check the result with: ffprobe -v error -select_streams v:0 \
#   -show_entries stream=width,height,duration -of default=nw=1 <output.mp4>
# Expected: width=720, height=1280, duration 60 seconds or less.
#
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <clips_dir> [output.mp4] [voiceover.m4a]" >&2
  exit 1
fi

CLIPS_DIR="$1"
OUTPUT="${2:-$(dirname "$CLIPS_DIR")/short-final.mp4}"
VOICEOVER="${3:-}"

if [ ! -d "$CLIPS_DIR" ]; then
  echo "Error: clips directory not found: $CLIPS_DIR" >&2
  exit 1
fi

command -v ffmpeg >/dev/null 2>&1 || { echo "Error: ffmpeg not found on PATH." >&2; exit 1; }
command -v ffprobe >/dev/null 2>&1 || { echo "Error: ffprobe not found on PATH." >&2; exit 1; }

# Collect clips in sorted (scene) order. Only .mp4 files, at the top level.
mapfile -t CLIPS < <(find "$CLIPS_DIR" -maxdepth 1 -type f -name '*.mp4' | sort)
if [ "${#CLIPS[@]}" -eq 0 ]; then
  echo "Error: no .mp4 clips found in $CLIPS_DIR" >&2
  exit 1
fi

if [ "${#CLIPS[@]}" -gt 6 ]; then
  echo "Warning: ${#CLIPS[@]} clips found — a Short must be 60 seconds or less." >&2
  echo "Check the total duration below; if it is over 60 seconds, cut a scene." >&2
fi

echo "Stitching ${#CLIPS[@]} clips in order:"
printf '  %s\n' "${CLIPS[@]}"

# Build a concat list file in a temp file (not in the clips dir, so it is
# not picked up as a clip on a re-run).
LIST_FILE="$(mktemp)"
trap 'rm -f "$LIST_FILE"' EXIT
for clip in "${CLIPS[@]}"; do
  # ffmpeg concat demuxer needs the path escaped for single quotes.
  printf "file '%s'\n" "${clip//\'/\'\\\'\'}" >> "$LIST_FILE"
done

# Re-encode every clip to the same portrait format, then concat.
# scale=720:1280 with force_original_aspect_ratio=decrease + pad centres
# the picture on a 720x1280 canvas, so a landscape or square clip never
# produces a non-9:16 output. fps=30 and aac audio keep the join clean.
FILTER="scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2,fps=30,format=yuv420p"

if [ -n "$VOICEOVER" ]; then
  if [ ! -f "$VOICEOVER" ]; then
    echo "Error: voiceover file not found: $VOICEOVER" >&2
    exit 1
  fi
  echo "Using separate voiceover audio: $VOICEOVER (clip audio replaced)"
  # apad pads the voiceover so a voiceover shorter than the video does not
  # truncate the output; -shortest ends the file when the video ends.
  ffmpeg -y -f concat -safe 0 -i "$LIST_FILE" -i "$VOICEOVER" \
    -filter_complex "[0:v]$FILTER[v];[1:a]apad[a]" \
    -map "[v]" -map "[a]" -c:v libx264 -preset medium -crf 20 \
    -c:a aac -b:a 128k -shortest -movflags +faststart "$OUTPUT"
else
  ffmpeg -y -f concat -safe 0 -i "$LIST_FILE" \
    -filter_complex "[0:v]$FILTER[v]" \
    -map "[v]" -map 0:a -c:v libx264 -preset medium -crf 20 \
    -c:a aac -b:a 128k -shortest -movflags +faststart "$OUTPUT"
fi

echo "Done: $OUTPUT"
ffprobe -v error -select_streams v:0 \
  -show_entries stream=width,height,duration \
  -of default=noprint_wrappers=1 "$OUTPUT"
echo "Check: width should be 720, height 1280, duration 60 seconds or less."
DURATION="$(ffprobe -v error -select_streams v:0 -show_entries stream=duration -of csv=p=0 "$OUTPUT")"
if awk -v d="$DURATION" 'BEGIN { exit !(d > 60) }'; then
  echo "WARNING: duration is over 60 seconds — YouTube will NOT classify this as a Short. Cut a scene and re-run." >&2
fi
