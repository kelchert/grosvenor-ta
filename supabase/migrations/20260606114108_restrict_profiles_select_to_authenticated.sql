-- Restrict public.profiles access to authenticated users.
--
-- Security Advisor flagged "RLS Policy Always True" on profiles: the SELECT
-- policy was role=public USING(true), so the anon key could read every row
-- (real PII: names, apartments, emails). Residents must log in to use the
-- community app and no code path reads profiles before auth, so SELECT is
-- narrowed from public to authenticated. Behavior for logged-in users is
-- unchanged (USING(true) preserved): own-row reads, unapproved/awaiting-approval
-- reads, admin pending-user reads, and chat/bulletin author joins all still work.
DROP POLICY IF EXISTS "Approved users can view approved profiles" ON public.profiles;

CREATE POLICY "Authenticated users can view profiles"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (true);

-- Drop the permissive anon INSERT policy. Legitimate signup inserts the profile
-- row via the handle_new_user() trigger on auth.users, which is SECURITY DEFINER
-- and therefore bypasses RLS — so this role=public WITH CHECK(true) policy did
-- nothing for real signups and only let anon write arbitrary profile rows.
DROP POLICY IF EXISTS "Anyone can insert profile on signup" ON public.profiles;
