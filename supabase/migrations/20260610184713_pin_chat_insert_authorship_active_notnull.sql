-- Close Findings A/B/C on public.chat INSERT.
--
-- Before: policy "Approved users can post to chat" was role=public with a WITH
-- CHECK that only required the poster's profile to be approved=true. It did NOT
-- pin author_id to the poster (Finding B: a logged-in resident could write rows
-- authored as someone else), did NOT exclude former tenants (Finding A:
-- approved-but-inactive could still post), and author_id was nullable (Finding C:
-- authorless rows possible).
--
-- After: recreate TO authenticated (aligns INSERT posture with the 2026-06-06
-- SELECT lockdown — anon is denied at policy-applicability, not just WITH CHECK),
-- pin author_id = auth.uid(), and require profiles.active = true for the
-- resident path. The admin path (grosvenorta@gmail.com) posts as itself.
-- Then make author_id NOT NULL (precheck: 0 NULLs / 6 rows, rides clean).
--
-- Plain DROP (no IF EXISTS): the policy name is taken from the live pg_policies
-- row, so a name mismatch should fail loud and roll back, not silently no-op.
-- BEGIN/COMMIT is load-bearing: a failed CREATE after the DROP would otherwise
-- leave chat with no INSERT policy (RLS denies every post). Wrapped, the DROP
-- rolls back with it.
--
-- D (email-literal admin check → role/is_admin flag) deferred: needs a schema
-- column + backfill + a grosvenor-connect cross-consumer check.

BEGIN;

DROP POLICY "Approved users can post to chat" ON public.chat;

CREATE POLICY "Approved users can post to chat"
  ON public.chat
  FOR INSERT
  TO authenticated
  WITH CHECK (
    author_id = auth.uid()                          -- Finding B: row must be self-authored
    AND (
      EXISTS (
        SELECT 1 FROM public.profiles
        WHERE profiles.id = auth.uid()
          AND profiles.approved = true
          AND profiles.active   = true              -- Finding A: former tenants can't post
      )
      OR EXISTS (
        SELECT 1 FROM public.profiles
        WHERE profiles.id = auth.uid()
          AND profiles.email = 'grosvenorta@gmail.com'  -- admin posts as itself (Q2); D deferred
      )
    )
  );

-- Finding C: no authorless rows. Precheck passed (0 NULLs / 6 rows), rides clean.
ALTER TABLE public.chat ALTER COLUMN author_id SET NOT NULL;

COMMIT;
