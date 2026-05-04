# l00k

TradingView Pine Script v6 custom indicator — modular source, unified build.

## How it works

Individual indicators, strategies, and utilities live as separate `.pine` files
in `src/`. On every push to `main`, CI:

1. Determines the next [semantic version](https://semver.org) from
   [conventional commits](https://www.conventionalcommits.org)
2. Concatenates all source files into a single `l00k.pine`
3. Stamps a version header at the top of the script
4. Publishes the unified script to a GitHub Gist (permanent URL)
5. Tags the release and updates `CHANGELOG.md`

## Project structure

```
l00k/
├── src/                  # Pine Script source modules
│   ├── 00_meta.pine      # //@version=6 + indicator() declaration
│   ├── 10_types.pine     # type definitions & constants
│   ├── 20_inputs.pine    # user inputs
│   ├── 30_utils.pine     # utility functions
│   ├── 50_*.pine         # indicator / strategy logic
│   └── 90_plots.pine     # plot & visual output
├── scripts/
│   ├── build.sh          # concatenate src → dist/l00k.pine
│   └── changelog.sh      # generate CHANGELOG.md from tags
├── .github/workflows/
│   └── publish.yml       # CI pipeline
├── .gist_id              # auto-managed gist ID (created by CI)
└── CHANGELOG.md          # auto-generated
```

Files in `src/` are concatenated **in lexicographic order** — use numeric
prefixes (see `src/README.md`).

## Versioning

Version bumps are derived automatically from commit messages:

| Commit prefix          | Bump  | Example                          |
|------------------------|-------|----------------------------------|
| `fix:`                 | patch | `fix: correct RSI threshold`     |
| `feat:`                | minor | `feat: add volume profile`       |
| `feat!:` / `BREAKING`  | major | `feat!: redesign input system`   |
| anything else          | patch | `chore: update readme`           |

## Setup

### 1. Clone

```sh
git clone https://github.com/luk-rs/l00k.git
```

### 2. Create a Personal Access Token

CI needs a token with **`gist`** scope to publish the unified script.

1. Go to https://github.com/settings/tokens?type=beta
2. Create a new **Fine-grained token** with:
   - **Repository access:** `luk-rs/l00k`
   - **Account permissions → Gists:** Read and write
3. Copy the token

### 3. Add the secret

```sh
gh secret set GIST_TOKEN --repo luk-rs/l00k
# paste the token when prompted
```

### 4. Push a change

```sh
# edit a file in src/
git add -A
git commit -m "feat: add my indicator"
git push
```

CI will run, and the Gist URL will appear in the workflow logs on the first run.

## Local build

```sh
bash scripts/build.sh 0.0.0-local abc1234
cat dist/l00k.pine
```

## License

MIT
