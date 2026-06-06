-- Restrict public.chat SELECT to authenticated users.
--
-- The chat SELECT policy was role=public USING(true) — the same "always true"
-- pattern profiles had — so the anon key (embedded in the public community.html)
-- could read the entire building group chat without logging in. Chat is a
-- residents-only conversation and is never rendered before auth: every read goes
-- through loadChat(), which runs only from showMainApp() after login + approval.
-- Narrow SELECT from public to authenticated. Logged-in/approved read behavior is
-- unchanged (USING(true) preserved); anon is excluded.
--
-- announcements and bulletin keep their role=public SELECT ON PURPOSE — reserved
-- for a future public-facing notices view (see docs/next_session.md). They are not
-- touched here. direct_messages is already participant-scoped and is left alone.
DROP POLICY IF EXISTS "Anyone can read chat" ON public.chat;

CREATE POLICY "Authenticated users can read chat"
  ON public.chat
  FOR SELECT
  TO authenticated
  USING (true);
