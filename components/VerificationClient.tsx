"use client";

import { useState } from "react";
import { BadgeCheck, MailCheck, Sparkles } from "lucide-react";

type Props = {
  emailVerified: boolean;
  instagramStatus: "unverified" | "email_verified" | "instagram_verified" | "manual_verified";
  instagramHandle?: string | null;
};

export function VerificationClient({ emailVerified, instagramStatus, instagramHandle }: Props) {
  const [handle, setHandle] = useState(instagramHandle ?? "");
  const [proofUrl, setProofUrl] = useState("");
  const [note, setNote] = useState("");
  const [status, setStatus] = useState<"idle" | "sending" | "sent" | "error">("idle");

  async function submit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setStatus("sending");
    const response = await fetch("/api/verification", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ instagram_handle: handle, proof_url: proofUrl, note }),
    });
    setStatus(response.ok ? "sent" : "error");
  }

  return (
    <main className="mx-auto min-h-screen max-w-5xl px-4 py-8 sm:px-6">
      <div className="grid gap-5 lg:grid-cols-[0.9fr_1.1fr]">
        <section className="rounded-[28px] border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
          <p className="text-xs font-black uppercase tracking-widest text-rose-300">Verification</p>
          <h1 className="mt-3 text-3xl font-black tracking-tight text-white">Build trust before you meet people</h1>
          <p className="mt-3 text-sm leading-7 text-zinc-400">
            ThaiNight uses lightweight trust signals so social features feel intentional, not random.
          </p>

          <div className="mt-6 space-y-3">
            <div className="rounded-2xl border border-zinc-800 bg-zinc-900/70 p-4">
              <div className="flex items-center gap-3">
                <MailCheck className="h-5 w-5 text-emerald-300" />
                <div>
                  <p className="text-sm font-black text-white">Email verification</p>
                  <p className="text-sm text-zinc-400">{emailVerified ? "Verified via Supabase Auth" : "Not confirmed yet"}</p>
                </div>
              </div>
            </div>
            <div className="rounded-2xl border border-zinc-800 bg-zinc-900/70 p-4">
              <div className="flex items-center gap-3">
                <BadgeCheck className="h-5 w-5 text-sky-300" />
                <div>
                  <p className="text-sm font-black text-white">Profile trust level</p>
                  <p className="text-sm capitalize text-zinc-400">{instagramStatus.replace(/_/g, " ")}</p>
                </div>
              </div>
            </div>
          </div>
        </section>

        <form onSubmit={submit} className="rounded-[28px] border border-zinc-800 bg-zinc-950 p-5 sm:p-6">
          <p className="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-pink-300">
            <Sparkles className="h-4 w-4" />
            Instagram verification request
          </p>
          <div className="mt-5 grid gap-4">
            <label className="grid gap-2 text-sm text-zinc-300">
              Instagram handle
              <input value={handle} onChange={(event) => setHandle(event.target.value)} placeholder="@yourhandle" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
            </label>
            <label className="grid gap-2 text-sm text-zinc-300">
              Proof URL
              <input value={proofUrl} onChange={(event) => setProofUrl(event.target.value)} placeholder="Profile URL or supporting link" className="h-12 rounded-2xl border border-zinc-800 bg-zinc-900 px-4 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
            </label>
            <label className="grid gap-2 text-sm text-zinc-300">
              Note
              <textarea value={note} onChange={(event) => setNote(event.target.value)} rows={4} placeholder="Anything that helps us review faster." className="rounded-2xl border border-zinc-800 bg-zinc-900 px-4 py-3 text-white outline-none placeholder:text-zinc-600 focus:border-rose-400/70" />
            </label>
            <div className="flex items-center justify-between gap-3">
              <p className={`text-sm ${status === "sent" ? "text-emerald-300" : status === "error" ? "text-rose-300" : "text-zinc-500"}`}>
                {status === "sent" ? "Verification request submitted." : status === "error" ? "Could not submit request." : "Reviewed manually in the first version."}
              </p>
              <button type="submit" disabled={status === "sending"} className="inline-flex min-h-12 items-center rounded-2xl bg-rose-500 px-5 py-3 text-sm font-black text-white hover:bg-rose-400 disabled:opacity-60">
                {status === "sending" ? "Sending..." : "Submit request"}
              </button>
            </div>
          </div>
        </form>
      </div>
    </main>
  );
}
