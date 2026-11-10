# HTTP API

Base URL `https://freeimagetovideo.ai`. Every call is `POST` with a JSON body and the header `Authorization: Bearer sk-...` (create a key at [freeimagetovideo.ai/settings/apikeys](https://freeimagetovideo.ai/settings/apikeys)). The SDKs read the key from `FREEIMAGETOVIDEO_API_KEY`.

## The envelope

Every answer has the same shape:

```json
{ "code": 0, "message": "ok", "data": { } }
```

**Success is HTTP status below 400 and `code` equal to 0.** A refusal can arrive as HTTP 200 with a non-zero `code` and a `data.reason`; a client that only checks the status code reads it as success.

## Start a run

`POST /api/ai/generate`

```json
{
  "provider": "auto",
  "mediaType": "video",
  "model": "minimax-h3",
  "scene": "image-to-video",
  "prompt": "the camera slowly orbits the statue",
  "options": {
    "image_input": ["https://example.com/statue.jpg"],
    "duration": 6,
    "resolution": "480p",
    "aspect_ratio": "16:9",
    "sound": true
  }
}
```

| field | value |
|---|---|
| `provider` | `"auto"` (the server routes by model) |
| `mediaType` | `"video"` |
| `model` | `"minimax-h3"`, the only model |
| `scene` | `"text-to-video"`, or `"image-to-video"` when you pass a photo |
| `prompt` | what the clip shows |
| `options.image_input` | image to video only: a list with one public https image URL; the photo becomes the first frame |
| `options.duration` | 4, 5, 6, 8, 10 or 15 seconds |
| `options.resolution` | `480p` (default) or `768p` |
| `options.aspect_ratio` | `16:9` (default), `9:16` or `1:1` |
| `options.sound` | `true`; every clip comes with sound |

`data.id` in the answer is the task id.

## Check a run

`POST /api/ai/query` with `{"taskId": "<id>"}`

| `data` field | meaning |
|---|---|
| `status` | `pending`, `processing`, `success`, `failed` or `canceled` |
| `videos` | clip URLs once `status` is `success`; take `videos[0]` |
| `errorMessage`, `failureKind` | why a run failed |
| `queued`, `queueEta` | the run is waiting in the relaxed queue; `queueEta` is in seconds |

Poll every 10 seconds. A run can wait in the relaxed queue after the plan's full-speed allowance for the day is used, so the SDKs wait up to 30 minutes by default.

## Credits

`POST /api/user/get-user-credits` with an empty body. `data.remainingCredits` is the balance.

## Errors

| when | what it means | SDK error |
|---|---|---|
| HTTP 401, or a message containing `no auth` | key missing, wrong or deleted | Auth |
| `code` -2 or -3 | the content filter refused the prompt or photo, or a cooldown is active; reword it | Rejected |
| `data.reason` = `insufficient_credits` | not enough credits for this run | Quota |
| `data.reason` = `plan_required` | API runs need a paid plan | Plan |
| `data.reason` = `concurrency` | too many runs generating at once on this account | Busy |
| `status` = `failed` / `canceled` | the run was accepted but did not finish | Generation |
| anything else | read `message` | API |

A wrong key looks like this:

```json
{"code":-1,"message":"Invalid API key. Create one at https://freeimagetovideo.ai/settings/apikeys","data":{"reason":"invalid_api_key"}}
```

## Plans

API runs need a paid plan: each run draws on the plan's full-speed allowance, then waits in the relaxed queue. See [pricing](https://freeimagetovideo.ai/pricing). For clips without a key, use the [free unlimited AI video generator](https://freeimagetovideo.ai/video/free-unlimited-ai-video-generator) on the site.
