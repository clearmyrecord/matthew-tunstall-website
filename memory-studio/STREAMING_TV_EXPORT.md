# Streaming TV Export — Windows Family Edition v16 beta

This is a **local** post-render export feature. It prepares review files and metadata for services such as Pluto TV, The Roku Channel, and distributors, but DOES NOT submit, upload, or guarantee platform acceptance.

Workflow: Render rough cut → Record narration → Export narrated film → Prepare captions, artwork, music cue sheets and rights clearances → Submit through approved distributors or platform partnerships.

Current ZIP is provided within the ChatGPT conversation; source code is not yet integrated with the hosted website's cloud backend.

### Export formats
- **Streaming MP4:** H.264 video, AAC stereo 48 kHz, capped at 1080p, preserving native lower resolutions and aspect ratios. A screening/review deliverable, not a platform-certified mezzanine.
- **ProRes master:** ProRes 422 HQ with PCM stereo audio in MOV, retaining source resolution.
- **Local draft delivery metadata** (CSV), rights checklist, cue sheet template and SHA-256 checksums.
- Optional *user-supplied* timed SRT captions. Captions are not automatically created.
- Output goes into a new `family_renders/streaming_tv/` subfolder. Existing v13/v15 files are untouched.

### Commercial distribution is separate
Pluto TV: https://pluto.tv/partners
Official additional delivery restrictions: https://www.paramount.com/pluto-tv-additional-content-delivery-guidelines
Roku submissions: https://developer.roku.com/dev/docs/video-on-demand
Filmhub specs: https://help.filmhub.com/en/articles/2663770-video-audio-requirements

Pluto and Roku have approval/partner requirements. Filmhub requires captions, metadata, appropriate artwork and clearance. A video file alone does not establish eligibility.

### Product tiers
Consumer editions can eventually export a finished personal-use MP4. Professional distributor-package features are targeted for Creator Studio; actual feature gating is **NOT implemented** until Supabase/Stripe entitlements and checks are built.

### Remaining before public release
- Test against user’s complete narrated v13/v15 movie.
- Build accurate subtitle generation/editor and QC verification.
- Create professional artwork tools, validation and provider-specific metadata templates.
- Review music, image, appearance/release and performer rights for public distribution.
- Connect website to renderer and protect features using a verified server-side entitlement, not frontend state.
- Establish distributor partnerships for any actual delivery/publishing integration.
