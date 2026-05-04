# src/

Each `.pine` file in this directory is a module of the **l00k** indicator.

## Naming convention

Files are concatenated in lexicographic order during the build.
Use numeric prefixes to control ordering:

| Range   | Purpose                          |
|---------|----------------------------------|
| 00–09   | Meta (version, indicator decl)   |
| 10–19   | Types & constants                |
| 20–29   | Shared inputs                    |
| 30–49   | Shared utility functions         |
| 50–79   | Indicator / strategy slices      |
| 80–89   | Alerts                           |
| 90–99   | Shared plots & visuals           |

**Example:** `50_rsi_divergence.pine`, `51_volume_profile.pine`

Prefer self-contained vertical slices in the `50-79` range. A slice may define
its own inputs, helpers, calculations, plots, lines, labels, and alerts when
those symbols are specific to that feature. Move code into `10-49` or `90-99`
only when another slice genuinely reuses it.
