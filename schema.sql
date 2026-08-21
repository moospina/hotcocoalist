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
  sort_order int,
  website text
);

-- If this table already existed before sort_order/website were added, this
-- makes sure the columns are there without wiping anything out.
alter table spots add column if not exists sort_order int;
alter table spots add column if not exists website text;

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

-- "Know a spot?" note submissions. Visitors can add notes; only you (via
-- the manage link) actually see/delete them in the site's UI, though like
-- everything else in this app the anon key itself isn't a hard security
-- boundary — see the setup note at the top of index.html.
create table if not exists suggestions (
  id text primary key,
  message text not null,
  created_at bigint
);

alter table suggestions enable row level security;

drop policy if exists "Public can add suggestions" on suggestions;
create policy "Public can add suggestions"
on suggestions for insert
to anon
with check (true);

drop policy if exists "Public can read suggestions" on suggestions;
create policy "Public can read suggestions"
on suggestions for select
to anon
using (true);

drop policy if exists "Public can delete suggestions" on suggestions;
create policy "Public can delete suggestions"
on suggestions for delete
to anon
using (true);
