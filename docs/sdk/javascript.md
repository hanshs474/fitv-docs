# JavaScript / TypeScript SDK

npm [`freeimagetovideo`](https://www.npmjs.com/package/freeimagetovideo), for Node 18+, Deno and Bun. Uses the global `fetch`, no dependencies.

```bash
npm install freeimagetovideo
export FREEIMAGETOVIDEO_API_KEY=sk-...
```

```ts
import { generateVideo, credits } from "freeimagetovideo";

// text to video
const clip = await generateVideo("a paper lantern drifting over a night river");

// image to video: the photo is the first frame
const moved = await generateVideo("the camera slowly orbits the statue", {
  imageUrl: "https://example.com/statue.jpg",
  options: { duration: 6, aspect_ratio: "9:16" },
});

console.log(await credits());
```

For an AI assistant instead of code, the npm package [`freeimagetovideo-mcp`](https://www.npmjs.com/package/freeimagetovideo-mcp) runs the [MCP server](../mcp.md) locally: `npx -y freeimagetovideo-mcp`.

API runs need a paid plan; see [pricing](https://freeimagetovideo.ai/pricing).
