# Memory Studio — paid edition rollout

**Status (Windows v37):** Architecture staged; not live. The publicly displayed prices are proposed *one-time* launch offers. No customer payments are accepted yet. The v37 Story Picks beta is not divided into licensed paid editions.

| Edition | Proposed price | Planned entitlement |
|---|---:|---|
| My Life (`my_life`) | $59 one-time | Private personal projects, bulk import, chronology, written stories and voice notes |
| Family Legacy (`family_legacy`) | $119 one-time | My Life + guided interview questions, relationships, family history, chapter/story planning |
| Creator Studio (`creator_studio`) | $249 one-time | Family Legacy + professional workflows, AI-assisted scripts, transcription, soundtrack mixing and production tools |
| Beta (`beta`) | $0 while testing | Limited testing access only, not a paid edition |

## Architecture
- **Identity:** Existing Supabase authentication, one user identity across all editions.
- **Access:** `account/editions_setup.sql` creates a read-only-for-users entitlement record. Only trusted server code may write it after a verified Stripe webhook; never authorize paid features based on browser state or user-editable metadata.
- **Checkout:** Stripe Checkout in payment mode; three one-time Prices linked to Stripe Products. Server creates checkout sessions for a known authenticated user and fixed Price ID.
- **Fulfillment:** Signed webhook verifies checkout and payment status, prevents replay/duplicate grants, logs provider event IDs, updates edition ownership, and handles refunds/disputes. Do not grant access just because customer reaches a “success” URL.
- **API gating:** Every premium document/export/render operation checks a trusted entitlement before processing. UI explains locked functionality but is not the security boundary.
- **AI/cloud consumption:** One-time desktop prices do not imply unlimited ongoing cloud video rendering, AI transcription, or storage. Define explicit fair-use limits or optional usage plans before paid launch; keep basic local use independent.
- **Family access:** Family Legacy does not automatically include multi-user collaboration; invites, consent and cross-account sharing are a separate later addition requiring authorization review.
- **Rollout checks:** two-account privacy test; no-payment access rejection; tier-specific request rejection; charge/refund replay testing; quota and billing cost assessment; desktop installer license checks; support and account recovery paths.

## When / order
1. **Now:** edition definitions and protected database migration prepared in GitHub. No payments enabled.
2. **Next, after Stripe is connected:** create test-mode products and Price IDs; implement a secret-backed checkout endpoint and verified webhook. Apply migration in Supabase and test with test-mode purchases.
3. **Before collecting real money:** implement backend entitlements across the website and the current v37-based Windows engine, establish quotas, test refunds and access denial, configure payment/support pages, then enable live purchases.
4. **Afterward:** scale cloud rendering and bulk phone imports. Do not advertise those as available in a paid package until actually shipped.

**Security:** Never commit Stripe secret keys or webhook signing secrets to public GitHub Pages. GitHub Pages cannot execute a secure payment webhook. Use Supabase Edge Functions or another trusted server.
