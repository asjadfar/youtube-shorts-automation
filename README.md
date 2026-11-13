# YouTube Shorts Automation Skill

A Claude skill for end-to-end YouTube Shorts automation, built for Asjad's kids' learning channel Bunny Sounds. Claude handles all the work end to end — topic and learning goal, script, video prompts, voiceover, edit/stitch, thumbnail, title/description/hashtags, upload checklist and analytics review — with the owner involved only for approval at the upload step and for channel/Google account setup. It is the portrait short-form companion to the long-form skill ([youtube-long-video-automation](https://github.com/asjadfar/youtube-long-video-automation)): same channel, same characters, same style — one lesson in 60 seconds instead of one episode in 3–5 minutes.

## What it does

Takes a Short from idea to upload in one repeatable workflow:

1. **Topic / learning goal** — one lesson per Short (one number set, one sound set, one color set, one letter set), and the learning goal stated in one line.
2. **Script** — a 4–6-scene, up-to-60-second Short, portrait 9:16 vertical, 720x1280. Hook in the first 3 seconds, one learning beat per scene, finale with a subscribe call.
3. **Visuals** — Flow-ready, visual-only image/video prompts (no children speaking or dialogue in the prompt).
4. **Voiceover** — a separate brief, simple Urdu voiceover script (adult TTS), recorded / generated apart from the visuals.
5. **Edit / stitch** — ffmpeg joins the scene clips into one 720x1280 portrait video, 60 seconds or less.
6. **Thumbnail** — 720x1280 portrait guidance for a clear, readable Shorts thumbnail.
7. **Title / description / hashtags** — a fixed template so every upload is consistent, always with #Shorts.
8. **Upload** — checklist + approval gate. Nothing uploads without the owner's approval.
9. **Analytics follow-up** — what to check after publishing (views, average view duration, viewed vs swiped away), and what to change next time.

## Who does what — Claude handles all the work end to end

Claude runs every step — topic, script, video prompts, voiceover, edit/stitch, thumbnail, title/description/hashtags, upload checklist and analytics review. The owner is involved only at two points: (1) channel / Google account setup (pick the Google account, create the channel, choose name/handle, complete any Google sign-in or OAuth on their own device), and (2) approval of the exact final video, title, description, hashtags and thumbnail before upload. The two device-bound exceptions are the video clips (Claude writes the Flow-ready prompts; the owner generates the clips in Flow, because video generation is region-unavailable on the owner's Muse account) and the upload sign-in itself (on the owner's own device). Everything else is Claude's work — do not hand it back to the owner as homework.

## The channel

- **Channel:** Bunny Sounds
- **Handle:** @BunnySoundsKids (https://www.youtube.com/@BunnySoundsKids)
- **Google account:** asjadfarooqch@gmail.com
- **Location:** United States
- **Language:** English (channel); Shorts voiceover is Urdu by default — see Voiceover below
- **Created:** Nov 13, 2026
- **Content:** kids' learning videos — NOT rhymes only. Every video teaches something: sounds, animals, colors, numbers, letters. Each Short names its learning goal in the script (for example "learn to count 1 to 4" or "learn 3 animal sounds").
- **Format:** one lesson per Short — hook, 3–4 learning beats, finale with a subscribe call. 4–6 scenes x ~10 seconds, 60 seconds or less total.
- **Ratio:** 9:16 portrait vertical, 720x1280, for YouTube Shorts (and TikTok).
- **Style:** soft 2D storybook cartoon — warm sunlight, painterly backgrounds, big expressive eyes, gentle soft colors. Prompts also say "2D cartoon style video, flat colorful cartoon characters with bold outlines, classic kids' cartoon look".
- **Characters:** same white bunny with blue bow as host, same six friends (cow, lion, elephant, dog, duck, pig) in every episode — see Character lock in `SKILL.md`.

## Voiceover

The voiceover is Urdu by default: short, simple lines, spoken by one warm adult voice (adult TTS). Google Flow blocks children speaking / dialogue prompts, so dialogue is never in the visual prompt — it goes in the separate voiceover script instead. If the owner wants a Short in English instead, translate the same lines — the scene structure does not change. Voiceover lines are written in Urdu script (for TTS) with Roman Urdu in brackets (so the owner can read them).

## Files

```
youtube-shorts-automation/
├── README.md                                  # this file
└── youtube-shorts-automation/
    ├── SKILL.md                               # the Claude skill — the workflow itself
    ├── scripts/
    │   └── stitch.sh                          # ffmpeg: concat scene clips into one 720x1280 portrait Short
    └── templates/
        ├── episode-script.md                  # blank Shorts script template
        ├── flow-prompts.md                    # Flow prompt template (visual-only, portrait)
        ├── voiceover-script.md                # voiceover script template (Urdu, one speaker per line)
        └── upload-checklist.md                # pre-upload checklist + approval gate
```

## Setup

### 1. Create the YouTube channel first

Pick a Google account, then create the channel and choose its name and handle. The skill cannot create the channel for you, and it cannot pick the Google account — that is the owner's decision. (Bunny Sounds already exists — see The channel above.)

### 2. Choose an upload route (one of these)

**Route A — Browser upload (recommended to start).** Upload in the browser with the owner's Google sign-in and approval. The agent prepares the finished video file, title, description, hashtags and thumbnail, and the owner uploads (or approves the browser upload) in YouTube Studio. No API key needed. A Short is a video 60 seconds or less in portrait 9:16 — YouTube classifies it as a Short automatically.

**Route B — YouTube Data API with OAuth.** Set up a Google Cloud project, enable the YouTube Data API v3, create OAuth credentials, and complete the consent flow on the owner's own device. The skill then follows the API upload steps. This is more setup, and it is the only route that lets an agent upload without the browser.

Do not use any other upload route. Do not paste API keys, passwords or credentials into the skill files, into chat, or into the repo — credentials live only in the owner's secure storage / OAuth flow.

### 3. Video clips

Clips come from Google Flow (or another video tool the owner chooses). The skill's prompts are visual-only on purpose: Flow blocks children speaking / dialogue prompts, so dialogue is never in the visual prompt — it goes in the separate voiceover script instead.

### 4. Use in Claude

Copy the `youtube-shorts-automation/` folder into a Claude skills directory (for example a Claude Code skills folder, or a repo Claude is pointed at), or keep this whole repo and point Claude at `youtube-shorts-automation/SKILL.md`. Then ask Claude to run the workflow, for example: "Make a Short for Bunny Sounds about counting 1 to 4 using the youtube-shorts-automation skill."

### 5. Companion skill

This is the short-form companion to the long-form skill ([youtube-long-video-automation](https://github.com/asjadfar/youtube-long-video-automation) — 16:9 horizontal, 3–5 minutes, 18–30 scenes). Same channel, same characters, same style. A Short can be a mini version of a long-form episode (for example the long-form "Count 1 to 10 with Bunny" becomes the Short "Count 1 to 4 with Bunny"), or a standalone lesson. Keep the two in sync: same character lock, same style lock, same approval gate.

## Honest limits — read before using

- **No direct YouTube connector.** Claude does not have a built-in YouTube connection like it does for some other apps. Upload is browser (owner's sign-in + approval) or YouTube Data API with OAuth the owner sets up. Never claim direct auto-upload without one of those.
- **Video generation is region-unavailable on the owner's Muse account.** The skill does not promise that Muse/Claude can generate video clips itself. Clips are made in Flow (by the owner) or another tool, then stitched by ffmpeg.
- **Google Flow blocks children speaking / dialogue.** All visual prompts in this skill are visual-only for that reason. Dialogue lives only in the voiceover script.
- **No credentials in the skill.** No API keys, passwords, OAuth tokens or secrets are stored in these files. If a step needs a login, the owner does it on their own device.
- **Approval gate is mandatory.** No video, title, description or thumbnail is published or uploaded until the owner approves the exact final version. A changed caption, clip order or thumbnail needs fresh approval.
- **One speaker per voiceover line.** Each line is spoken by one character only; do not put two speakers in one voiceover line.
- **A Short must be 60 seconds or less.** If the stitched video runs over 60 seconds, YouTube does not classify it as a Short. Count the scenes before generating anything: 4–6 scenes x ~10 seconds = 40–60 seconds. Never deliver a 7-scene Short.

## How to run one Short

1. Pick the lesson (one number set, one sound set, one color set, one letter set) and state the learning goal in one line.
2. Fill in `templates/episode-script.md`.
3. Generate the 4–6 scene visuals from the prompts in `templates/flow-prompts.md` (Flow-ready, visual-only, portrait).
4. Record / generate the voiceover from `templates/voiceover-script.md`.
5. Run `scripts/stitch.sh` to join the clips into one 720x1280 portrait video, 60 seconds or less.
6. Make the thumbnail (720x1280 portrait).
7. Fill in `templates/upload-checklist.md` and get the owner's approval.
8. Upload via Route A or Route B.
9. Check analytics after 24–48 hours and note what to change next time.
