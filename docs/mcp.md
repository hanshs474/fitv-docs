# MCP server (Claude, Cursor, any MCP client)

Free Image to Video speaks the Model Context Protocol, so an AI assistant can make the clip for you: ask for a video in chat, get the URL back. Three tools:

| tool | what it does |
|---|---|
| `generate_video` | a clip with sound from `prompt`, or [animate a photo](https://freeimagetovideo.ai/video/animate-photo-ai) by passing `image_url`; optional `duration`, `resolution`, `aspect_ratio`. Returns a run id |
| `check_status` | status of a run (`run_id`) and the video URL when it is ready |
| `credits` | credits left on the account |

Video takes minutes, so `generate_video` returns a run id and the assistant calls `check_status` later.

## Remote server (no install)

Endpoint `https://freeimagetovideo.ai/api/mcp`, Streamable HTTP. Send your key as `Authorization: Bearer sk-...` ([create one](https://freeimagetovideo.ai/settings/apikeys)). Listing the tools needs no key. Server card: [`/.well-known/mcp/server-card.json`](https://freeimagetovideo.ai/.well-known/mcp/server-card.json).

Claude Code:

```bash
claude mcp add --transport http freeimagetovideo https://freeimagetovideo.ai/api/mcp \
  --header "Authorization: Bearer sk-..."
```

Cursor, Windsurf and other clients that take a URL:

```json
{
  "mcpServers": {
    "freeimagetovideo": {
      "url": "https://freeimagetovideo.ai/api/mcp",
      "headers": { "Authorization": "Bearer sk-..." }
    }
  }
}
```

Check it from a terminal:

```bash
curl -s -X POST https://freeimagetovideo.ai/api/mcp \
  -H "Content-Type: application/json" -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'
```

## Local server (npm)

For clients that only run stdio servers, the npm package [`freeimagetovideo-mcp`](https://www.npmjs.com/package/freeimagetovideo-mcp) exposes the same three tools:

```json
{
  "mcpServers": {
    "freeimagetovideo": {
      "command": "npx",
      "args": ["-y", "freeimagetovideo-mcp"],
      "env": { "FREEIMAGETOVIDEO_API_KEY": "sk-..." }
    }
  }
}
```

Claude Code: `claude mcp add freeimagetovideo -e FREEIMAGETOVIDEO_API_KEY=sk-... -- npx -y freeimagetovideo-mcp`

## Plans

Runs from an assistant are API runs: they need a paid plan, draw on the plan's full-speed allowance, then wait in the relaxed queue. See [pricing](https://freeimagetovideo.ai/pricing).
