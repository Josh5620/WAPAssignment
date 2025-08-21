import { useEffect } from "react";
import { supabase } from "../supabaseClient";

// Testing: real test user to test authed reads/updates
const TEST_EMAIL = "admin2@test.com";      // e.g. "test@example.com"
const TEST_PASSWORD = "adminpass";   // e.g. "StrongPassword!123"

export default function DevConsoleProbe() {
  useEffect(() => {
    (async () => {
      try {
        // 0) Login only if needed (skip if you already have a session or only testing public reads)
        const { data: { session } } = await supabase.auth.getSession();
        if (!session && TEST_EMAIL && TEST_PASSWORD) {
          const { data, error } = await supabase.auth.signInWithPassword({
            email: TEST_EMAIL,
            password: TEST_PASSWORD,
          });
          console.log("Auth sign-in:", { data, error });
        }

        // 1) Session check
        const sess = (await supabase.auth.getSession()).data.session;
        console.log("Session UID:", sess?.user?.id || null);

        // 2) forum_posts: public read
        const { data: posts, error: postsErr } = await supabase
          .from("forum_posts")
          .select("id,title,author_id,created_at")
          .order("created_at", { ascending: false })
          .limit(5);
        console.log("forum_posts:", { posts, postsErr });

        // 3) resources: public sees approved
        const { data: approved, error: appErr } = await supabase
          .from("resources")
          .select("id,title,is_approved,created_at,created_by")
          .eq("is_approved", true)
          .order("created_at", { ascending: false })
          .limit(5);
        console.log("approved resources:", { approved, appErr });

        // 4) profiles: read self (requires login + RLS policy)
        const uid = sess?.user?.id;
        if (uid) {
          const { data: me, error: meErr } = await supabase
            .from("profiles")
            .select("id,full_name,role,created_at")
            .eq("id", uid)
            .single();
          console.log("my profile:", { me, meErr });
        } else {
          console.log("Skipping profile read (no session).");
        }
      } catch (e) {
        console.error("Probe error:", e);
      }
    })();
  }, []);

  return null; // nothing visual; logs only
}
