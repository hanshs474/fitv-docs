# SDKs

Every official client has the same surface: `generate_video(prompt, image_url=None, **options)` submits the run, waits and returns the clip URL; `submit`, `status` and `credits` are there for finer control. All of them read `FREEIMAGETOVIDEO_API_KEY` ([create a key](https://freeimagetovideo.ai/settings/apikeys)), poll every 10 seconds and wait up to 30 minutes, and read the response envelope rather than only the HTTP status.

| Language | Install | Source |
|---|---|---|
| [Python](python.md) (SDK + CLI) | `pip install freeimagetovideo` | [hanshs474/fitv-py](https://github.com/hanshs474/fitv-py) |
| [JavaScript / TypeScript](javascript.md) | `npm install freeimagetovideo` | npm [`freeimagetovideo`](https://www.npmjs.com/package/freeimagetovideo) |
| [Go](go.md) (SDK + CLI) | `go get github.com/hanshs474/fitv-go` | [hanshs474/fitv-go](https://github.com/hanshs474/fitv-go) |
| [Rust](rust.md) | `cargo add freeimagetovideo` | [hanshs474/fitv-rs](https://github.com/hanshs474/fitv-rs) |
| MCP server | `npx -y freeimagetovideo-mcp` | [MCP page](../mcp.md) |

Writing your own client: the [HTTP API](../http.md) is three POST calls.

Pass a photo URL for [image to video AI with sound](https://freeimagetovideo.ai/video/image-to-video-ai-with-sound): the photo becomes the first frame. Leave it out for [free text to video AI](https://freeimagetovideo.ai/video/free-text-to-video-ai).
