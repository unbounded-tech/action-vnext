# action-vnext

**action-vnext** is a GitHub Action wrapper for [vnext](https://github.com/harmony-labs/vnext), a fast, Rust‑based CLI tool that calculates your next semantic version by analyzing your Git commit history using Conventional Commit standards. It brings the simplicity of semantic‑release without requiring Node.js—making it ideal for any project and CI/CD pipeline.

## Motivation

I used to use semantic‑release in Node.js and was spoiled by its automated versioning and release process. However, semantic‑release is tightly coupled to the Node ecosystem—it requires a `package.json` and brings extra overhead. I wanted a lightweight, language‑agnostic solution that does one thing well: read Git commit messages and output the next version. That’s why I built **vnext** and wrapped it in this action, providing a simple, reliable version calculator that works anywhere.

## Features

- **Automated Version Calculation:**  
  Parses commit messages (e.g., `feat:`, `fix:`, `BREAKING CHANGE:`) to determine version bumps:
  - **Major:** Triggers if a commit includes `BREAKING CHANGE:` or a designated major marker.
  - **Minor:** Triggers if a commit contains `feat:` (new feature).
  - **Patch:** Triggers if a commit contains `fix:` (bug fix).
  - **No-Op:** Ignores commits that don’t require a version bump.
- **Language‑Agnostic:**  
  No Node.js, npm, or package.json required—just the Git history.
- **Simplicity:**
  Packaged in a Docker container that mounts your repository so vnext can compute the next version effortlessly.

## Optional Arguments

The action supports passing optional arguments to the underlying `vnext` CLI tool:

- **--changelog**: Generate a changelog based on commit messages.
- Any other flags supported by the `vnext` CLI tool.

To use these optional arguments, provide them using the `args` input parameter:

```yaml
- name: Calculate Next Version
  id: version
  uses: harmony-labs/action-vnext@latest
  with:
    args: '--changelog'
```

## Usage

### In a GitHub Workflow

Reference a released version of the action in your workflow file. For example:

```yaml
jobs:
  version:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0  # Ensure full history for version calculation.

      - name: Calculate Next Version
        id: version
        uses: harmony-labs/action-vnext@latest
        # Optional: Pass additional arguments to vnext
        # with:
        #   args: '--changelog'

      - name: Display Computed Version
        run: echo "Next version is: ${{ steps.version.outputs.version }}"
```

### Conditional Release Example: Comparing to the Current Version

In many pipelines, you only want to create a new tag, build a versioned image, or trigger a release if the computed next version differs from the current version. Below is an example snippet that shows how to do this:

```yaml
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Get Current Version
        id: get-current
        run: |
          CURRENT=$(git describe --tags --abbrev=0 --match "v*" 2>/dev/null || echo "0.0.0")
          echo "Current version: $CURRENT"
          echo "current=$CURRENT" >> $GITHUB_OUTPUT

      - name: Calculate Next Version
        id: version
        uses: harmony-labs/action-vnext@latest
        # Optional: Pass additional arguments to vnext
        # with:
        #   args: '--changelog'

      - name: Compare Versions and Act
        if: steps.version.outputs.version != steps.get-current.outputs.current
        run: |
          echo "There is a new version"
```

In this example:
- The **Get Current Version** step uses `git describe` with the `--match "v*"` flag to consider only tags starting with `v` (defaulting to `0.0.0` if none exist).
- The **Calculate Next Version** step runs the action to determine the next version based on your commit history.
- The **Compare Versions and Act** step then checks whether the computed version differs from the current version. If they differ, the pipeline proceeds with tagging and releasing; otherwise, it skips those steps.

### Using Docker Compose for Local Testing

A `docker-compose.yaml` file is provided to test the action locally. This file mounts your current directory into the container so that vnext can access your Git commit history.

```yaml
services:
  vnext:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - ./:/workspace
    working_dir: /workspace
    environment:
      LOG_LEVEL: debug
      GIT_DISCOVERY_ACROSS_FILESYSTEM: 1
      # Optional: Pass additional arguments to vnext
      # INPUT_ARGS: '--changelog'
    entrypoint: ["/entrypoint.sh"]
    command: []
```

**To test locally:**

1. Ensure you're in a Git repository (vnext relies on the commit history).
2. Run the following command in your terminal:

   ```bash
   docker compose run --rm vnext
   ```

   To pass optional arguments, you can either:
   
   - Uncomment the `INPUT_ARGS` line in the docker-compose.yml file, or
   - Set the environment variable directly in the command:
   
   ```bash
   docker compose run --rm -e INPUT_ARGS="--changelog" vnext
   ```

This command builds the image (if not already built) and runs the vnext service, printing the computed version to your terminal.

## Installation

### Using GitHub Releases

This action is automatically built and released via GitHub Actions. Use it in your workflows by referencing the appropriate tag (e.g., `harmony-labs/action-vnext@latest`).

### Building from Source

If you’d like to build and test locally:

```bash
docker build -t action-vnext .
```

Then, use Docker Compose as described above to run the container.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for bug fixes, new features, or improvements. For major changes, open an issue first to discuss your ideas.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
