# Memory Studio built-in demo soundtrack library

This site contains six **original procedurally synthesized instrumental preview cues** created for the Memory Studio prototype. It does not republish Mixkit, commercial recordings, or unverified third-party music files.

## Files
- audio/golden-hour.wav — warm
- audio/little-moments.wav — nostalgic
- audio/new-horizons.wav — adventure
- audio/together-again.wav — uplifting
- audio/quiet-reflection.wav — reflective
- audio/first-steps.wav — hopeful

Audio is uncompressed mono PCM WAV, 16kHz / 16-bit and ~18–28 seconds per cue. These are functional demo samples, not professionally produced or mastered full-length tracks. The files are served directly from this site's GitHub Pages origin and require no third-party music account or download site.

## How the website works
- Anyone can listen without logging in.
- Story-type presets create a simple six-chapter soundtrack plan.
- Selected track and plan are stored *only in the browser's localStorage*.
- The visitor can download a WAV to import in the local Windows v13 editor. The plan JSON is **not** currently a supported v13 import format.
- The browser cannot automatically assign music to a v13 render, cloud-render documentary, or sync soundtrack preferences between devices.
- No external audio platform or public Supabase bucket is necessary for this prototype.

## Before broad commercial availability
Review/approve audio sound quality; establish and publish product soundtrack usage terms; confirm accessibility and cross-browser playback; add a server-side per-project music selection model with RLS and renderer integration; replace short previews with full-length master tracks; add track duration, credits, and catalog versioning.

## Audio production
The demo cues were procedurally synthesized for this project using additive sine-wave synthesis, chord progressions, bass, melodic notes and simple percussion. No external sound files or third-party samples were used.