---
name: youtube-shorts-automation
description: End-to-end YouTube Shorts automation for a kids' learning channel — Claude handles all the work end to end (topic and learning goal, 4-6-scene script for a video up to 60 seconds, Flow-ready visual-only portrait prompts, separate Urdu voiceover script, ffmpeg stitch to 720x1280 portrait 9:16, thumbnail, title/description/hashtags with #Shorts, upload checklist with approval gate, and analytics review), with the owner involved only for approval at the upload step and for channel/Google account setup. One lesson per Short (numbers, sounds, colors, letters, animals). Bunny and his friends stay the same characters in every Short — see Character lock. Portrait short-form companion to the long-form skill youtube-long-video-automation (16:9, 3-5 minutes); same channel, same characters, same style. Use when the user asks to make, plan, edit, or upload a YouTube Short, especially a kids' learning Short for Bunny Sounds.
---

# YouTube Shorts Automation

## When to use

Use this skill when the user asks to make a YouTube Short from idea to upload — especially a kids' learning Short for the Bunny Sounds channel — or asks for a Shorts script, video prompts, a thumbnail, titles/descriptions, or an upload for such a Short.

Do not use it for long-form videos (use the companion skill `youtube-long-video-automation` for 16:9, 3–5 minute videos), for live streams, or for any platform other than YouTube Shorts (and TikTok, which uses the same 9:16 portrait file), unless the user explicitly asks to adapt it.

## Who does what — Claude handles all the work end to end

Claude runs every step of the workflow below — topic, script, video prompts, voiceover, edit/stitch, thumbnail, title/description/hashtags, upload checklist and analytics review. The owner is involved only at two points:

1. **Channel / Google account setup** — the owner picks the Google account, creates the channel, chooses its name/handle, and completes any Google sign-in or OAuth consent on their own device. Claude cannot do these for the owner.
2. **Approval at the upload step** — the owner approves the exact final video, title, description, hashtags and thumbnail before anything is uploaded (see Step 8). Nothing is published without that approval.

Two device-bound exceptions, stated honestly so the "end to end" claim is not overstated:

- **Video clips:** Claude writes the Flow-ready visual prompts, but the clips themselves are generated in Google Flow by the owner, because video generation is region-unavailable on the owner's Muse account (see Hard limits). Claude then stitches the finished clips with ffmpeg.
- **Upload sign-in:** the Google sign-in / OAuth for the upload happens on the owner's own device (browser route) or through OAuth the owner set up. Claude never handles the owner's password or tokens.

Everything else — research, writing, prompts, voiceover script, stitching, thumbnail guidance, titles, descriptions, hashtags, checklist, analytics review — is Claude's work. Do not hand any of it back to the owner as homework.

## Channel facts (do not invent others)

- Channel: Bunny Sounds, handle @BunnySoundsKids (https://www.youtube.com/@BunnySoundsKids), Google account asjadfarooqch@gmail.com, location United States, language English, created Nov 13, 2026.
- Content: kids' learning videos — NOT rhymes only. Every video teaches something while it entertains: animal sounds, vehicle sounds, instrument sounds, colors, numbers, letters, animal names. Each Short names its learning goal in the script (for example "learn to count 1 to 4" or "learn 3 animal sounds").
- Format: one lesson per Short — hook, 3–4 learning beats, finale with a subscribe call. 4–6 scenes x ~10 seconds, 60 seconds or less total.
- Ratio: 9:16 portrait vertical, 720x1280, for YouTube Shorts (and TikTok).
- Style: soft 2D storybook cartoon — warm sunlight, painterly backgrounds, big expressive eyes, gentle soft colors. Prompts also say "2D cartoon style video, flat colorful cartoon characters with bold outlines, classic kids' cartoon look".
- Voiceover: Urdu by default — short, simple lines, one warm adult voice (adult TTS). See Step 4. If the owner wants a Short in English instead, translate the same lines — the scene structure does not change.
- Companion skill: `youtube-long-video-automation` (16:9 horizontal, 3–5 minutes, 18–30 scenes) — same channel, same characters, same style. A Short can be a mini version of a long-form episode (the long-form "Count 1 to 10 with Bunny" becomes the Short "Count 1 to 4 with Bunny"), or a standalone lesson.

## Character lock — Bunny and friends stay constant

The same characters appear in every Short. Never redesign them, never swap them for new characters, and never change their look:

- **Bunny (host):** a cute fluffy white bunny with long ears with pink insides, a small blue bow on one ear, big brown expressive eyes, a pink nose and rosy cheeks. Reference: the channel profile picture and banner.
- **Friends (always the same six):** a black-and-white cow with a red collar and bell, a friendly lion with a brown mane, a small grey elephant with pink ears, a brown-and-white dog with a red collar, a yellow duck, and a pink pig. Reference: the channel banner.
- Every visual prompt must name the exact same characters with the exact same description above, so Flow keeps them on-model across Shorts. Check each generated frame: if Bunny's bow, ears or colors changed, or a friend looks different, say so plainly and regenerate — do not ship a changed character. New animals/objects may appear as the things being counted or guessed in a Short, but the host and the six friends never change.

## Hard limits — state them honestly, do not work around them

- **A Short must be 60 seconds or less.** If the stitched video runs over 60 seconds, YouTube does not classify it as a Short. Count the scenes before generating anything: 4–6 scenes x ~10 seconds = 40–60 seconds. Never deliver a 7-scene Short.
- **No direct YouTube connector.** There is no built-in YouTube connection. Upload is only via (A) the browser in YouTube Studio with the owner's Google sign-in and approval, or (B) the YouTube Data API v3 with OAuth the owner sets up. Never claim direct auto-upload without one of those.
- **Video generation is region-unavailable on the owner's Muse account.** Do not promise Muse/Claude can generate the video clips itself. Clips come from Google Flow (made by the owner) or another video tool the owner chooses, then are stitched with ffmpeg.
- **Google Flow blocks children speaking / dialogue.** Every visual prompt below is visual-only for that reason. Never put spoken dialogue in a Flow / image / video prompt. Dialogue lives only in the separate voiceover script.
- **No credentials in the skill.** Never put an API key, password, OAuth token or secret in a skill file, in chat, or in the repo. Logins happen on the owner's own device.
- **Approval gate is mandatory.** Nothing is published or uploaded until the owner approves the exact final video, title, description, hashtags and thumbnail. A changed caption, clip order or thumbnail needs fresh approval.
- **One speaker per voiceover line.** Each line is spoken by one character only.

## Workflow

### Step 1 — Topic / learning goal

1. Pick ONE lesson for the Short — one number set (1–4, 1–5), one sound set (3 animal sounds), one color set (3 colors), one letter set (A–C), or one animal set. A Short teaches one thing. A Short that tries to teach two lessons is not ready.
2. State the learning goal in one line (what the child learns: for example "learn to count 1 to 4" or "learn 3 animal sounds"). A Short with no learning goal is not ready.
3. Pick the format — one of these two:
   - **Format A — Count / learn with Bunny:** hook, then one number/color/letter per scene, then finale. Example: "Count 1 to 4 with Bunny".
   - **Format B — What sound does it make? (mini guessing game):** hook, then 3 guessing items (one per scene, 2-second pause before the sound reveal), then finale. Example: "Cow, Lion, Duck — What Sound?"
4. Check what is trending in the target audience (USA) right now — search the web / news for the topic, do not guess from training data. Keep the topic evergreen if no trend fits: counting, animal sounds and colors work any week; a fad will not.
5. Decide the scene count before writing anything: hook (1) + learning beats (3–4) + finale (1) = 5–6 scenes at ~10 seconds each = 50–60 seconds total. A 4-scene Short (hook + 2 beats + finale) is the shortest allowed; a 6-scene Short is the longest. Never plan 7 scenes.

### Step 2 — Script (4–6 scenes, up to 60 seconds)

Write the script using `templates/episode-script.md`. Keep every line brief and simple. Structure:

| Scene | Time | What happens | Visual | Voiceover |
|---|---|---|---|---|
| 1 — Hook | 0:00–0:10 | Bunny host appears and asks the question — the first 3 seconds must hook, or the viewer swipes away | Bunny in a sunny meadow, waving, big and close to camera | "Hello! I am Bunny! Let's count!" |
| 2 — Beat 1 | 0:10–0:20 | First learning item appears, 2-second pause, then the answer | Item in a storybook setting, big and clear | "How many ducks? One! One duck!" |
| 3 — Beat 2 | 0:20–0:30 | Same beat, second item | Item in a storybook setting | "How many apples? One, two! Two apples!" |
| 4 — Beat 3 | 0:30–0:40 | Same beat, third item | Item in a storybook setting | "How many flowers? One, two, three! Three flowers!" |
| 5 — Beat 4 (5–6 scene Shorts only) | 0:40–0:50 | Same beat, fourth item | Item in a storybook setting | "How many balloons? One, two, three, four! Four balloons!" |
| 6 — Finale (5–6 scene Shorts) / 5 — Finale (4–5 scene Shorts) | 0:50–1:00 | Bunny and friends together, the lesson repeated in one line, subscribe call, loops back to the hook | All characters together, sunny, joyful | "Great job! Subscribe for more!" |

Count the scenes before generating anything: hook (1) + learning beats (3–4) + finale (1) = 5–6 scenes at ~10 seconds each = 50–60 seconds total. A 4-scene Short has 2 learning beats; a 6-scene Short has 4. Never deliver a 7-scene Short — it runs over 60 seconds and is not a Short.

Rules:
- One learning item per scene. No scene teaches two things.
- A 2-second silent pause before each answer, so the child can guess.
- The hook must show Bunny's face and the question in the first 3 seconds — Shorts viewers decide in 3 seconds whether to stay or swipe.
- No dialogue in the visual prompt — only in the voiceover column.
- The finale must loop back to the hook, so the Short replays cleanly, and must include the subscribe call in one short line.

#### Example — "Count 1 to 4 with Bunny" (6 scenes, 60 seconds)

This is the worked example. It is the Shorts version of the long-form Episode 1 ("Count 1 to 10 with Bunny", 24 scenes, 4:00) — same lesson, cut to one Short.

- Scene 1 — Hook (0:00–0:10): Bunny in a sunny meadow, waving: "Hello! I am Bunny! Let's count!"
- Scene 2 — Number 1 (0:10–0:20): One yellow duck in a sunny pond, big numeral "1": "How many ducks? One! One duck!"
- Scene 3 — Number 2 (0:20–0:30): Two red apples on green grass, big numeral "2": "How many apples? One, two! Two apples!"
- Scene 4 — Number 3 (0:30–0:40): Three pink flowers in a sunny garden, big numeral "3": "How many flowers? One, two, three! Three flowers!"
- Scene 5 — Number 4 (0:40–0:50): Four colorful balloons in a blue sky, big numeral "4": "How many balloons? One, two, three, four! Four balloons!"
- Scene 6 — Finale (0:50–1:00): Bunny and all six friends together in a sunny meadow: "Great job! Subscribe for more!"

For a 5-scene version, drop one beat (for example number 3) and keep hook + 3 beats + finale = 50 seconds.

#### Example — Format B, "Cow, Lion, Duck — What Sound?" (5 scenes, 50 seconds)

- Scene 1 — Hook (0:00–0:10): Bunny asks: "What sound does it make? Let's guess!"
- Scene 2 — Cow (0:10–0:20): Cow in a green field, 2-second pause: "Cow says… MOO!"
- Scene 3 — Lion (0:20–0:30): Lion in warm sunlight, 2-second pause: "Lion says… ROAR!"
- Scene 4 — Duck (0:30–0:40): Duck in a pond, 2-second pause: "Duck says… QUACK!"
- Scene 5 — Finale (0:40–0:50): Bunny and friends together: "You guessed them all! Subscribe for more!"

#### Blank template

Use `templates/episode-script.md` for every new Short. Fill in all 3–4 learning items, the setting for each, and the exact answer word for each before generating any visuals.

### Step 3 — Image / video prompts (Flow-ready, visual-only, portrait)

Write one prompt per scene, using `templates/flow-prompts.md`. Every prompt must:

- Start with the style lock: "Soft 2D storybook cartoon, warm sunlight, painterly backgrounds, big expressive eyes, gentle soft colors, 2D cartoon style video, flat colorful cartoon characters with bold outlines, classic kids' cartoon look, 9:16 portrait vertical, 720x1280."
- Describe only what is seen: character, setting, action, expression, colours. No spoken words, no dialogue, no children speaking, no text on screen — except the single large numeral/letter for the scene being taught, if the lesson needs it (for example a big colorful numeral "1").
- Keep the bunny host and each item visually consistent across scenes — same colours, same character design, same setting style. Copy the character description word for word into each prompt.
- Keep each clip ~10 seconds. If the tool makes clips under 10 seconds, note the actual length and adjust the stitch step. Count the clips: 5 clips for 50 seconds, 6 clips for 60 seconds.

Example prompt (Scene 2, number 1):
> Soft 2D storybook cartoon, warm sunlight, painterly backgrounds, big expressive eyes, gentle soft colors, 2D cartoon style video, flat colorful cartoon characters with bold outlines, classic kids' cartoon look, 9:16 portrait vertical, 720x1280. One yellow duck swimming in a sunny pond, a large colorful numeral "1" floating above, soft clouds in a blue sky, flowers at the water's edge. No dialogue, no speaking. Only the numeral "1" shown.

Example prompt (Scene 1, bunny host):
> Soft 2D storybook cartoon, warm sunlight, painterly backgrounds, big expressive eyes, gentle soft colors, 2D cartoon style video, flat colorful cartoon characters with bold outlines, classic kids' cartoon look, 9:16 portrait vertical, 720x1280. A cute fluffy white bunny with long ears with pink insides, a small blue bow on one ear, big brown expressive eyes, a pink nose and rosy cheeks, standing in a sunny meadow, waving one paw in greeting, flowers around, warm morning light, close to camera. No text, no dialogue, no speaking.

Check each generated frame before using it: character on-model, no extra limbs, no text burned in (except the single numeral/letter for the scene), 9:16 portrait ratio. Name errors plainly and regenerate the bad scene — do not ship it.

### Step 4 — Voiceover script (Urdu, separate from visuals)

Write the voiceover separately from the visuals, using `templates/voiceover-script.md`, one line per scene, one speaker per line. Rules:

- **Language: Urdu by default.** Short, simple lines, spoken by one warm adult voice (adult TTS). Write each line in Urdu script (for TTS) with Roman Urdu in brackets (so the owner can read it).
- **If the owner wants a Short in English instead,** translate the same lines — the scene structure does not change. Do not write two different scripts; translate line by line.
- **Keep every line short and simple.** One question and one answer per line at most. A line a small child cannot follow is too long — cut it.
- **One speaker per line.** Each line is spoken by one character only.
- A 2-second pause goes before each answer, so the child can guess.
- The voiceover is recorded / generated as audio and laid over the stitched video — it is never part of the visual prompt. If lip-sync is attempted, sync only the speaking character and only on their own line; if it misattributes, fall back to plain voiceover with no lip-sync.

Example voiceover — "Count 1 to 4 with Bunny" (Urdu, 6 lines):

1. Bunny: "ہیلو! میں بنی ہوں! آؤ گنیں!" (Hello! Main Bunny hoon! Aao ginein!)
2. Bunny: "کتنی بطخیں؟ ایک! ایک بطخ!" (Kitni batkhein? Ek! Ek batkh!)
3. Bunny: "کتنے سیب؟ ایک، دو! دو سیب!" (Kitne saib? Ek, do! Do saib!)
4. Bunny: "کتنے پھول؟ ایک، دو، تین! تین پھول!" (Kitne phool? Ek, do, teen! Teen phool!)
5. Bunny: "کتنے غبارے؟ ایک، دو، تین، چار! چار غبارے!" (Kitne ghubaray? Ek, do, teen, chaar! Chaar ghubaray!)
6. Bunny: "بہت اچھا! سبسکرائب کریں!" (Bohat acha! Subscribe karein!)

Keep the voiceover in the episode script file, in the voiceover column, and in full in `templates/voiceover-script.md`.

### Step 5 — Edit / stitch with ffmpeg

Join the scene clips into one portrait video with `scripts/stitch.sh`. Requirements:

- Output: one file, 9:16 portrait vertical, 720x1280, 60 seconds or less.
- Verify the output dimensions and duration with `ffprobe` after stitching; if the tool delivered another ratio, scale / pad to 720x1280 before uploading. If the output runs over 60 seconds, cut a scene — do not ship a Short over 60 seconds.
- Keep the scene order exactly as scripted. If a clip is under 10 seconds, do not stretch it silently — note the real total length and adjust the voiceover timing to match. The finished video must still be 60 seconds or less.
- Keep the finished file and the scene clips together so the Short can be re-cut later.

See `scripts/stitch.sh` for the exact command and usage.

### Step 6 — Thumbnail (720x1280 portrait)

- Size: 720x1280 portrait. Use the bunny host plus one item, big and readable at small size — Shorts are watched on phones, so the thumbnail must read on a phone screen.
- One brief hook on the thumbnail at most (for example "1 2 3 4" or "What sound?"), large bold text, high contrast. No more than 4 words.
- Same storybook style as the video. Do not use a frame with burned-in text or a dialogue bubble.
- In YouTube Studio a Short's thumbnail can be a frame picked from the video, or a custom 720x1280 thumbnail uploaded on desktop Studio. Prepare the custom thumbnail file either way.
- Show the thumbnail to the owner with the title before upload — it is part of the approval gate.

### Step 7 — Title / description / hashtags

Use this template every time. Do not change the structure without the owner's approval.

**Title template:**
`Count 1 to 4 with Bunny 🐰 | Learn Numbers #Shorts`

Replace the lesson with the Short's lesson. Keep it under 100 characters including the emoji. Put #Shorts in the title or in the description — one of the two, always.

**Description template:**
```
Count 1 to 4 with Bunny! 🐰
Learn numbers 1, 2, 3, 4 with Bunny and friends!

#Shorts #KidsVideos #NurseryRhymes #LearnNumbers #BunnySounds
```

Keep it short — 2–3 lines plus hashtags. The learning goal must be in the first two lines. Add the channel name once (Bunny Sounds).

**Hashtags (use 3–5, no more, and always include #Shorts):**
`#Shorts #KidsVideos #NurseryRhymes #LearnNumbers #BunnySounds`

Keep hashtags in the description, not in the title (except #Shorts, which may go in either place).

### Step 8 — Upload checklist + approval gate

Complete `templates/upload-checklist.md` for the Short. Then stop and get the owner's approval for the exact final video file, title, description, hashtags and thumbnail.

Upload only after approval, via one of the two routes in the README:

- **Route A — Browser / YouTube Studio:** owner signs in with Google on their own device and uploads, or approves a browser upload. Verify the uploaded video plays, is portrait, is 60 seconds or less, is classified as a Short, and shows the right title/description.
- **Route B — YouTube Data API with OAuth:** only if the owner has set up OAuth. Never paste credentials into the skill or chat.

After upload, return the public link (or the scheduled time with its timezone) to the owner. A draft saved in Studio, a scheduled video and a live video are different states — report which one it is.

### Step 9 — Analytics follow-up

24–48 hours after publishing, check and record:

- Views, average view duration, and **viewed vs swiped away** (the key Shorts number — the share of viewers who watched vs swiped past).
- Likes, comments, new subscribers from the Short.
- Which learning beat held attention best (if retention data shows a drop, name the scene).
- What to change next time: one change only (for example opening line, item order, or thumbnail), so the result shows what made the difference.

Do not chase a single Short's numbers by re-uploading the same video. Note the lesson in the next Short's script file instead.

## Shorts and monetization — YouTube Partner Program

### The goal

Qualify for the YouTube Partner Program (YPP), then set up AdSense to earn from ads. The channel's long-form plan (see the companion skill's monetization tracker) is 1,000 subscribers + 4,000 public watch hours in the last 12 months. Shorts count toward YPP too, through a separate Shorts-views route as well as watch hours — **check the current Shorts threshold in YouTube Studio → Earn**, because YouTube changes these numbers. Do not guess the threshold from memory; read it from Studio and write it down in the tracker before promising anything.

### Be honest about this — do not overpromise

- **Monetization is NOT instant.** No money is earned before the thresholds are met and the application is accepted. Early Shorts earn $0.
- **Claude cannot fake views or subscribers.** Do not buy views, buy subscribers, use view bots, or use any trick to inflate the numbers — that can get the channel rejected from YPP or removed. Growth comes only from real viewers watching real videos.
- **No views or subscribers are guaranteed.** The plan below improves the odds; it does not promise a number or a date. If growth is slow, the answer is better retention and more consistent Shorts, not shortcuts.
- **Shorts earn less per view than long-form videos.** A Shorts view is worth far less ad money than a long-form view. Shorts are for reach and subscribers first; the long-form videos are where most watch hours and ad revenue come from. Publish both: Shorts bring viewers in, long-form keeps them watching.

### The realistic plan

1. **Consistent Shorts.** Publish on a fixed schedule the owner can sustain — for example 3 Shorts per week on the same days — and do not miss weeks. Every Short is one lesson, 60 seconds or less.
2. **Retention hooks in every Short.**
   - A question in the first 3 seconds ("How many ducks? Let's count!") so the viewer stays to find out — Shorts viewers swipe in 3 seconds.
   - A new learning beat every ~10 seconds, so there is always a reason to keep watching.
   - A finale that loops back to the hook, so the Short replays and adds views.
3. **Series and playlists.** Keep every Short in the same series (same bunny host, same style, same title pattern), so one Short leads viewers to the next and to the long-form episodes. Link the long-form series playlist in every Short's description.
4. **SEO titles and descriptions.** Use the Step 7 template every time: the lesson in the title, the same lesson in the first two lines of the description, #Shorts and 3–5 relevant hashtags. Titles and descriptions must match what is actually in the video — no clickbait that makes viewers swipe away early, because swiping away hurts the viewed-vs-swiped-away rate.
5. **Upload schedule.** Agree the schedule with the owner before the first Short, publish at a consistent time, and keep it. If the schedule changes, update it in the tracker file, do not just skip silently.
6. **Progress tracker.** Use the companion long-form skill's `templates/monetization-tracker.md` for the channel totals (subscribers, watch hours). After every Short, also record its views, average view duration and viewed-vs-swiped-away rate in the Short's upload checklist file, so the next Short learns from it. Review the tracker after each Short and say plainly how far is left — never round the gap away.

### What happens after qualifying

1. Apply for YPP in YouTube Studio when the thresholds are met.
2. The owner sets up AdSense on their own device with their own payment details.
3. Once accepted, turn ads on and keep publishing — earnings come from real watch time, so retention stays the priority even after monetization starts.
4. Keep the tracker going after monetization: record monthly watch hours and estimated revenue from Analytics, and note which Shorts earned the most views.
