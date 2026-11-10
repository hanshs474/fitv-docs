# Rust SDK

[`freeimagetovideo` on crates.io](https://crates.io/crates/freeimagetovideo) · API reference on [docs.rs](https://docs.rs/freeimagetovideo) · source [hanshs474/fitv-rs](https://github.com/hanshs474/fitv-rs). Blocking client on `ureq`, no async runtime.

```bash
cargo add freeimagetovideo
export FREEIMAGETOVIDEO_API_KEY=sk-...
```

```rust
use freeimagetovideo::{generate_video, Client, Options};

fn main() -> Result<(), freeimagetovideo::Error> {
    // text to video
    let clip = generate_video("a paper lantern drifting over a night river", &Options::new())?;

    // image to video: the photo becomes the first frame
    let moved = generate_video(
        "the camera slowly orbits the statue",
        &Options::new().image("https://example.com/statue.jpg").set("duration", 6).set("aspect_ratio", "9:16"),
    )?;

    // lower level
    let client = Client::from_env();
    let id = client.submit("a lighthouse in a storm", &Options::new())?;
    println!("{clip} {moved} {} {}", client.status(&id)?.status, client.credits()?);
    Ok(())
}
```

## Errors

`Error::Auth`, `Error::Quota`, `Error::Plan`, `Error::Busy`, `Error::Rejected`, `Error::Generation { task_id, error_message, failure_kind }`, `Error::Timeout { task_id }`, `Error::Api { http_status, code, message }`. See the [error table](../http.md#errors).

The same model on the site: [animate a photo](https://freeimagetovideo.ai/video/animate-photo-ai). API runs need a paid plan; see [pricing](https://freeimagetovideo.ai/pricing).
