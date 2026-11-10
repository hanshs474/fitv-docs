# Python SDK and CLI

[`freeimagetovideo` on PyPI](https://pypi.org/project/freeimagetovideo/) · source [hanshs474/fitv-py](https://github.com/hanshs474/fitv-py). Standard library only, Python 3.8+.

```bash
pip install freeimagetovideo
export FREEIMAGETOVIDEO_API_KEY=sk-...
```

```python
from freeimagetovideo import generate_video

clip = generate_video("a paper lantern drifting over a night river")

# image to video: the photo becomes the first frame
moved = generate_video("the camera slowly orbits the statue",
                       image_url="https://example.com/statue.jpg",
                       duration=6, resolution="768p", aspect_ratio="9:16")
```

## CLI

```bash
freeimagetovideo "a paper lantern drifting over a night river"
freeimagetovideo --image https://example.com/statue.jpg "the camera slowly orbits the statue"
freeimagetovideo -o duration=10 -o aspect_ratio=9:16 "a fox in fresh snow"
freeimagetovideo --no-wait "a lighthouse in a storm"   # print the task id
freeimagetovideo --credits
```

## Submit now, collect later

```python
from freeimagetovideo import submit, status, wait, credits

task_id = submit("a lighthouse in a storm, waves crashing", duration=5)
print(status(task_id)["status"])   # pending | processing | success | failed | canceled
url = wait(task_id)                # every 10 s, up to 30 min
print(credits())
```

## Errors

All subclass `FreeImageToVideoError`: `AuthError`, `QuotaError`, `PlanError`, `BusyError`, `RejectedError`, `GenerationFailed` (`.error_message`, `.failure_kind`), `GenerationTimeout` (`.task_id`), `APIError`. See the [error table](../http.md#errors).

API runs need a paid plan; see [pricing](https://freeimagetovideo.ai/pricing).
