-- Memory Studio editions: PREPARATION ONLY. Do not treat this file as a payment integration.
-- Install in Supabase SQL Editor only after reviewing with the project's RLS policies.
-- Three paid editions: my_life, family_legacy, creator_studio; beta is unpaid evaluation.
-- No customer can grant themselves paid access. Only a trusted server, after verifying a
-- payment provider webhook, may change membership. Never use the publishable browser key.

create table if not exists public.memory_studio_entitlements (
  user_id uuid primary key references auth.users(id) on delete cascade,
  edition text not null default 'beta'
    check (edition in ('beta','my_life','family_legacy','creator_studio')),
  access_status text not null default 'beta'
    check (access_status in ('beta','active','revoked','refunded')),
  stripe_customer_id text,
  stripe_payment_intent_id text,
  purchased_at timestamptz,
  updated_at timestamptz not null default now(),
  constraint edition_status_consistent check (
    (edition = 'beta' and access_status = 'beta') or
    (edition <> 'beta' and access_status in ('active','revoked','refunded'))
  )
);

alter table public.memory_studio_entitlements enable row level security;
revoke all on public.memory_studio_entitlements from anon, authenticated;
grant select on public.memory_studio_entitlements to authenticated;

do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'memory_studio_entitlements'
      and policyname = 'Read own Memory Studio entitlement'
  ) then
    create policy "Read own Memory Studio entitlement"
      on public.memory_studio_entitlements
      for select to authenticated
      using (user_id = (select auth.uid()));
  end if;
end $$;

-- IMPORTANT: Do not create INSERT, UPDATE or DELETE policies for authenticated clients.
-- Payment verification, upgrades, refunds, and revocations must run in a trusted
-- server-side payment webhook handler. Use Stripe price IDs from server configuration,
-- not a price or plan supplied by the browser. Ensure webhook handling is idempotent.
-- No billing is activated by executing this schema.
