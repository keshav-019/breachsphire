-- Every interactive challenge should end in a full solution tier so the
-- mission-wide walkthrough UI can always offer a complete explanation.
-- Story-dialogue acknowledgements intentionally keep their zero-cost
-- orientation hint because there is no puzzle to solve.

insert into public.hints (challenge_id, tier, text, xp_cost, sort_order)
values
  (
    'mission-w0-02-o1-c1',
    'solution',
    'First, select the sender domain because cyber-guardians-portal.com is not the real organization domain. Next, select the urgency language because the one-hour suspension threat is manufactured pressure. Then select the 03:12 timestamp because it reinforces the abnormal off-hours pattern. Finally, select the link destination because secure-verify.net owns the real destination, not Cyber Guardians. Leave the generic greeting unselected: it is weak context, not proof by itself.',
    50,
    5
  ),
  (
    'mission-w0-03-o1-c1',
    'solution',
    'First, choose the page at cyber-guardians-portal.com.secure-verify.net as the fake. Read the hostname from right to left: secure-verify.net is the registrable domain, while the familiar Cyber Guardians wording is only a subdomain chosen by its owner. Then confirm the certificate mismatch and invalid padlock state. The legitimate page remains portal.cyberguardians.org because cyberguardians.org is its actual registrable domain and its certificate matches.',
    50,
    5
  );
