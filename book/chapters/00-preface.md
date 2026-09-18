# Preface — the operator's account

*Erik Garrison, September 2026. Dictated in a single agent thread, without the orchestration framework running — fitting, since the same cool-down applies to how this record ends. I have edited only for flow; the voice is mine.*

---

I built wg because I wanted the work to hold itself. The concept is a work graph — a graph of work. The implementation is worksgood, which is what you enter on the command line.¹ I was trusting the model to be able to do everything, and the policy layer was very, very thin — and for the first six months of its life, the system was working fantastically. I was able to do incredible things, performance of very complex tasks, precisely *because* nothing stood between me and the model's capability.

Then I started using weaker models, and they began to violate the constraints of the system, bringing down its operation. A lot of the policy stuff and failures came out of trying to deal with low-reliability models — operational reliability and also intellectual reliability — on OpenRouter. The reaction was: these are failing, let me get a bug report from the system, bring it back into the wg directory, and have the agents and agency work on it and try to fix it. Which they did. Each time.

There's this whole problem of agency itself. Agency was a concept — still a concept I'd like to explore — but it's become much more diffused, and its utility much less clear, because it really looks like you don't need it in many contexts. There's so much in-context learning happening that you get it for free as long as the agents are exposed to their operational context — code generation, document generation, communication, research, whatever they're doing. Telling agents about a skill reminds them they have it, but they don't need that if they're in the right context. They fall into the right set of skills and behaviors on their own.

So what happened to me, in the middle of all this: I dug in really deep. Things weren't working, and I was like, okay, I'm going to try to fix it. So I kept adding more and more stuff. The complicated evaluation system became harder and harder for agents to pass. I kept thinking I'd fixed it. Throughout the summer I kept using it, kind of in control, and in small systems it would work okay. But then the final straw: observing that things would *work* but that they were failing over and over, requiring huge numbers of interventions from myself.

You end up in a place where the graph does all the things it should do. It holds information about the work. The machinery is all working. But every task fails. Every single one. You poke it and it's slightly fixed. You poke it again and it's slightly fixed. In the end you manually say, oh well, it passed, I'll just mark it as passed. And you get to: I can't understand what is going on. Why doesn't this work? That's when I ran down the phenomenon in the documentation — the bureaucratization cascade — and recognized it.

I can name the mechanism now, the way it felt from the inside. Things actually worked okay until eventually there were so many constraints that, even if the probability of failure in any one of them is low — if you have a 1% failure on a constraint and you have 100 constraints, you begin to have an expectation that you're always going to fail.

The resolution is as described in this book. We haven't removed a lot of these things. We've stripped their power out of the system.

---

¹ Annoyingly, I discovered later that `wg` is how you invoke WireGuard — which, through Tailscale, is how I actually connect to the host I'm working on. The collision is real and I choose to find it funny.
