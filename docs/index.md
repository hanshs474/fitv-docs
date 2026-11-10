# Free Image to Video API and SDKs

Free image to video AI with no daily cap: start with no sign-up, keep going on a free account. Every video comes with sound and no watermark. This is the official API, MCP and SDK documentation for [Free Image to Video](https://freeimagetovideo.ai/?utm_source=readthedocs&utm_medium=docs).

The site turns a photo into a moving clip with the photo as the first frame, or a prompt into a clip from nothing, on MiniMax H3. The API key from your account runs the same thing from your own code, a script or an AI assistant. On the site itself: [image to video AI with sound](https://freeimagetovideo.ai/video/image-to-video-ai-with-sound), [free text to video AI](https://freeimagetovideo.ai/video/free-text-to-video-ai) and [animate a photo](https://freeimagetovideo.ai/video/animate-photo-ai).

## Quick start

1. Sign in on [freeimagetovideo.ai](https://freeimagetovideo.ai/?utm_source=readthedocs&utm_medium=docs) and pick a plan on [pricing](https://freeimagetovideo.ai/pricing). API runs need a paid plan.
2. Create a key at [freeimagetovideo.ai/settings/apikeys](https://freeimagetovideo.ai/settings/apikeys).
3. `export FREEIMAGETOVIDEO_API_KEY=sk-...` and call the [HTTP API](http.md), an [SDK](sdk/index.md) or the [MCP server](mcp.md).

```bash
curl -s -X POST https://freeimagetovideo.ai/api/ai/generate \
  -H "Authorization: Bearer $FREEIMAGETOVIDEO_API_KEY" -H "Content-Type: application/json" \
  -d '{"provider":"auto","mediaType":"video","model":"minimax-h3","scene":"image-to-video",
       "prompt":"the camera slowly orbits the statue",
       "options":{"image_input":["https://example.com/statue.jpg"],"duration":6,"sound":true}}'
```

The answer carries a task id in `data.id`. Poll `POST /api/ai/query` with `{"taskId": "<id>"}` every 10 seconds until `status` is `success`; the clip URL is `data.videos[0]`.

Or with an SDK:

```python
# pip install freeimagetovideo
from freeimagetovideo import generate_video
print(generate_video("the camera slowly orbits the statue", image_url="https://example.com/statue.jpg"))
```

```bash
# the same from a terminal
freeimagetovideo --image https://example.com/statue.jpg "the camera slowly orbits the statue"
```

## What every client does

1. `POST /api/ai/generate` with a prompt (and a photo URL for image to video); keep `data.id`.
2. `POST /api/ai/query` every 10 seconds until `status` is `success` (`videos[0]` is the clip), `failed` or `canceled`.
3. Read the envelope, not just the HTTP status: success is HTTP below 400 **and** `code` 0. Most refusals come back as HTTP 200 with a non-zero `code`.

The [HTTP API](http.md) page has every field and every error.

## Pick a client

| You want | Use |
|---|---|
| Python script or notebook | [`pip install freeimagetovideo`](sdk/python.md) |
| Node, Deno, Bun or the browser | [`npm install freeimagetovideo`](sdk/javascript.md) |
| Go program or a single binary CLI | [`github.com/hanshs474/fitv-go`](sdk/go.md) |
| Rust | [`cargo add freeimagetovideo`](sdk/rust.md) |
| Claude, Cursor or another AI assistant | [MCP server](mcp.md): remote at `https://freeimagetovideo.ai/api/mcp`, or `npx -y freeimagetovideo-mcp` |
| Anything else | the [HTTP API](http.md): three POST calls |

No key, no code: the generator on [freeimagetovideo.ai](https://freeimagetovideo.ai/?utm_source=readthedocs&utm_medium=docs) starts with no sign-up and keeps going on a free account.
