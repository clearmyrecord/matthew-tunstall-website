-- Run in Supabase SQL Editor before enabling the website.
create table if not exists public.memories (
 id uuid primary key,
 owner_id uuid not null references auth.users(id) on delete cascade,
 storage_path text not null unique,
 original_name text not null,
 mime_type text not null,
 file_size bigint not null check (file_size >= 0 and file_size <= 104857600),
 created_at timestamptz not null default now(),
 constraint own_path check (storage_path like (owner_id::text || '/%'))
);
alter table public.memories enable row level security;
create policy "Read own memories" on public.memories for select to authenticated using (owner_id = (select auth.uid()));
create policy "Insert own memories" on public.memories for insert to authenticated with check (owner_id = (select auth.uid()));
create policy "Delete own memories" on public.memories for delete to authenticated using (owner_id = (select auth.uid()));
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('memories','memories',false,104857600,array['image/jpeg','image/png','image/webp','image/heic','image/heif','image/gif','video/mp4','video/quicktime','video/webm'])
on conflict (id) do nothing;
create policy "Upload to own folder" on storage.objects for insert to authenticated with check (bucket_id='memories' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "Read own media" on storage.objects for select to authenticated using (bucket_id='memories' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "Delete own media" on storage.objects for delete to authenticated using (bucket_id='memories' and (storage.foldername(name))[1] = (select auth.uid())::text);
