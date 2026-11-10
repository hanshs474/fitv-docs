# Go SDK and CLI

[`github.com/hanshs474/fitv-go`](https://pkg.go.dev/github.com/hanshs474/fitv-go) · source [hanshs474/fitv-go](https://github.com/hanshs474/fitv-go). Standard library only.

```bash
go get github.com/hanshs474/fitv-go
# CLI
go install github.com/hanshs474/fitv-go/cmd/freeimagetovideo@latest
```

```go
import fitv "github.com/hanshs474/fitv-go"

url, err := fitv.GenerateVideo(ctx, "the camera slowly orbits the statue",
	&fitv.Options{ImageURL: "https://example.com/statue.jpg",
		Options: map[string]any{"duration": 6, "aspect_ratio": "9:16"}})
if errors.Is(err, fitv.ErrPlan) { /* API runs need a paid plan */ }
```

`fitv.New(key)` gives a client with `Submit`, `Status`, `Wait`, `GenerateVideo` and `Credits`. Errors wrap `ErrAuth`, `ErrQuota`, `ErrPlan`, `ErrBusy`, `ErrRejected`, `ErrGeneration`, `ErrTimeout` and `ErrAPI`; test them with `errors.Is`.

```bash
freeimagetovideo -image https://example.com/statue.jpg "the camera slowly orbits the statue"
freeimagetovideo -o duration=10 -o resolution=768p "a fox in fresh snow"
freeimagetovideo -credits
```

The CLI is also on Snapcraft: `sudo snap install freeimagetovideo`.
