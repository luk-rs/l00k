# src/

Each `.pine` file in this directory is a module of the **l00k** indicator.

## Naming convention

Files are concatenated in lexicographic order during the build.
Use numeric prefixes to control ordering:

| Range   | Purpose                          |
|---------|----------------------------------|
| 00–09   | Meta (version, indicator decl)   |
| 10–19   | Types & constants                |
| 20–29   | Inputs                           |
| 30–49   | Utility functions                |
| 50–79   | Indicators / strategies          |
| 80–89   | Alerts                           |
| 90–99   | Plots & visuals                  |

**Example:** `50_rsi_divergence.pine`, `51_volume_profile.pine`
