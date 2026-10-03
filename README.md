---
surface: long
---

# Awesome Link Check

Flag stale or archived GitHub repos in an awesome list. One bash script, no API key. <<src:checker-spec>>

Adapted from [lodar/awesome-self-hosted-agents/check.sh](https://github.com/lodar/awesome-self-hosted-agents/blob/main/check.sh), published under CC0-1.0. <<src:checker-upstream>>
This version reads GitHub repository links anywhere in a README and checks each repository once. <<src:checker-local>>
It prints the latest commit date from `commits.atom`, the age and archived status. The age limit defaults to 90 days. <<src:checker-local>>
A flag or a failed check returns exit 1. Invalid input returns exit 2. <<src:checker-fixtures>>
Requires Bash, curl, grep, sed, GNU date, sort, head and cat. <<src:checker-local>>

Run it on a local README:

```sh
bash check.sh /path/to/README.md 90
```

Real output on 2026-10-03, run on the README of [lodar/awesome-self-hosted-agents](https://github.com/lodar/awesome-self-hosted-agents): <<src:checker-live>>

```text
repository	last_commit	age	archived	status
https://github.com/0xranx/golembot	2026-09-29T03:00:50Z	4 days	no	OK
https://github.com/5dive-ai/5dive	2026-10-03T10:25:06Z	0 days	no	OK
https://github.com/Arize-ai/phoenix	2026-10-03T00:04:18Z	0 days	no	OK
https://github.com/BerriAI/litellm	2026-10-03T14:55:14Z	0 days	no	OK
https://github.com/FoundationAgents/OpenManus	2026-08-16T10:29:11Z	48 days	no	OK
https://github.com/HKUDS/LightRAG	2026-09-26T08:33:35Z	7 days	no	OK
https://github.com/Helicone/helicone	2026-09-16T19:28:17Z	16 days	no	OK
https://github.com/Mintplex-Labs/anything-llm	2026-10-02T20:24:28Z	0 days	no	OK
https://github.com/NVIDIA/OpenShell	2026-10-02T22:10:01Z	0 days	no	OK
https://github.com/NousResearch/hermes-agent	2026-10-03T15:24:04Z	0 days	no	OK
https://github.com/OpenHands/OpenHands	2026-10-03T14:30:29Z	0 days	no	OK
https://github.com/SWE-agent/mini-swe-agent	2026-09-03T05:05:59Z	30 days	no	OK
https://github.com/Skyvern-AI/skyvern	2026-10-03T11:14:04Z	0 days	no	OK
https://github.com/aaif-goose/goose	2026-10-02T15:03:24Z	1 days	no	OK
https://github.com/agent-infra/sandbox	2026-09-14T08:47:18Z	19 days	no	OK
https://github.com/agent0ai/agent-zero	2026-09-23T17:39:16Z	9 days	no	OK
https://github.com/agentscope-ai/QwenPaw	2026-09-30T07:48:36Z	3 days	no	OK
https://github.com/agno-agi/agno	2026-10-02T12:33:45Z	1 days	no	OK
https://github.com/anomalyco/opencode	2026-10-03T04:55:40Z	0 days	no	OK
https://github.com/anthropics/claude-code	2026-10-02T20:19:38Z	0 days	no	OK
https://github.com/browser-use/browser-use	2026-10-03T00:06:05Z	0 days	no	OK
https://github.com/browserless/browserless	2026-10-02T05:46:26Z	1 days	no	OK
https://github.com/charmbracelet/crush	2026-10-02T14:09:19Z	1 days	no	OK
https://github.com/comet-ml/opik	2026-10-02T15:59:53Z	0 days	no	OK
https://github.com/earendil-works/pi	2026-10-03T12:21:11Z	0 days	no	OK
https://github.com/getzep/graphiti	2026-09-30T08:02:28Z	3 days	no	OK
https://github.com/ggml-org/llama.cpp	2026-10-03T15:19:13Z	0 days	no	OK
https://github.com/google/adk-python	2026-10-03T13:13:21Z	0 days	no	OK
https://github.com/infiniflow/ragflow	2026-10-02T15:00:16Z	1 days	no	OK
https://github.com/langbot-app/LangBot	2026-10-03T05:03:02Z	0 days	no	OK
https://github.com/langfuse/langfuse	2026-10-02T21:15:58Z	0 days	no	OK
https://github.com/langgenius/dify	2026-10-03T10:12:10Z	0 days	no	OK
https://github.com/mastra-ai/mastra	2026-10-03T13:53:53Z	0 days	no	OK
https://github.com/maximhq/bifrost	2026-10-03T07:57:43Z	0 days	no	OK
https://github.com/mem0ai/mem0	2026-10-01T16:16:18Z	1 days	no	OK
https://github.com/microsoft/playwright-mcp	2026-09-28T23:12:55Z	4 days	no	OK
https://github.com/mindroom-ai/mindroom	2026-10-03T09:39:07Z	0 days	no	OK
https://github.com/mudler/LocalAI	2026-10-03T06:29:22Z	0 days	no	OK
https://github.com/ollama/ollama	2026-10-02T18:52:27Z	0 days	no	OK
https://github.com/openai/codex	2026-10-03T07:45:47Z	0 days	no	OK
https://github.com/openclaw/openclaw	2026-10-03T15:21:57Z	0 days	no	OK
https://github.com/openlit/openlit	2026-10-01T06:35:33Z	2 days	no	OK
https://github.com/opensandbox-group/OpenSandbox	2026-10-01T02:21:12Z	2 days	no	OK
https://github.com/steel-dev/steel-browser	2026-09-28T18:27:33Z	4 days	no	OK
https://github.com/superradcompany/microsandbox	2026-10-03T11:49:25Z	0 days	no	OK
https://github.com/tale-project/tale	2026-10-03T15:23:19Z	0 days	no	OK
https://github.com/topoteretes/cognee	2026-10-01T15:50:04Z	1 days	no	OK
https://github.com/vllm-project/vllm	2026-10-03T14:55:18Z	0 days	no	OK
Checked 48 repositories; exit 0
```
