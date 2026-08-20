-- Run this once in your Supabase project's SQL Editor
-- (left sidebar > SQL Editor > New query > paste this in > Run)

create table if not exists spots (
  id text primary key,
  name text not null,
  location text not null,
  notes text,
  rating int,
  lat double precision,
  lng double precision,
  created_at bigint,
  sort_order int
);

-- If this table already existed before sort_order was added, this makes
-- sure the column is there without wiping anything out.
alter table spots add column if not exists sort_order int;

-- Turn on row-level security, then explicitly allow the public (anon) key
-- used by the website to read, add, and remove rows. See the setup note
-- at the top of coffeetrail.html for the security trade-off this implies.
alter table spots enable row level security;

drop policy if exists "Public can read spots" on spots;
create policy "Public can read spots"
on spots for select
to anon
using (true);

drop policy if exists "Public can add spots" on spots;
create policy "Public can add spots"
on spots for insert
to anon
with check (true);

drop policy if exists "Public can delete spots" on spots;
create policy "Public can delete spots"
on spots for delete
to anon
using (true);

drop policy if exists "Public can update spots" on spots;
create policy "Public can update spots"
on spots for update
to anon
using (true)
with check (true);
