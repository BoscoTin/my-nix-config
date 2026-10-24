@AGENTS.md

## Model routing

Claude Code implementation of the delegation roles in `AGENTS.md`.

| Role | Model | Defined in |
|---|---|---|
| Orchestrator (main chat) | Sonnet | `.claude/settings.json` (`"model": "sonnet"`) |
| `scout` | Haiku | `.claude/agents/scout.md` |
| `advisor` | Opus | `.claude/agents/advisor.md` |
| `worker` | Sonnet | `.claude/agents/worker.md` |

- Do **not** set `CLAUDE_CODE_SUBAGENT_MODEL` anywhere (settings `env`, shell
  profile, nix modules). It has the highest precedence and overrides the
  `model:` field in every agent.
- Subagents cannot spawn subagents, so `advisor` only advises.
- The built-in `Explore` agent already uses Haiku; Claude may use it alongside
  `scout`. That is fine.
- Tune the `description` lines in the agent files if delegation happens too
  often or too rarely; they drive auto-delegation.
- No-setup alternative to `advisor`: `/model opusplan` (Opus in plan mode,
  Sonnet for execution).

### Verifying
1. `/agents` lists `scout`, `advisor`, `worker` with the right models.
2. `/model` shows Sonnet.
3. Smoke test: "Find where X is defined, then ask the advisor whether we should
   refactor it." Both a scout and an advisor call should happen.
4. After a real session, check usage per model: Haiku and Opus usage should
   appear. If every subagent runs on the main model, check the Claude Code
   version and for a stray `CLAUDE_CODE_SUBAGENT_MODEL`.
