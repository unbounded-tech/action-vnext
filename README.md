# action-vnext

**action-vnext** is a GitHub Action wrapper for [vnext](https://github.com/harmony-labs/vnext), a fast, Rust‑based CLI tool that calculates your next semantic version by analyzing your Git commit history based on Conventional Commit standards. It delivers the simplicity and power of semantic-release—without requiring Node.js—making it ideal for any project and CI/CD pipeline.

## Motivation

I used to use semantic‑release in Node.js and was spoiled by its automated versioning and release process. However, semantic‑release is tightly coupled to the Node ecosystem—it requires a `package.json` and brings a lot of extra overhead. I wanted a lightweight, language‑agnostic solution that does one thing well: read Git commit messages and output the next version. That’s why I built **vnext** and wrapped it in this action, providing a simple, reliable version calculator that works anywhere.

## Features

- **Automated Version Calculation:**  
  Parses commit messages (e.g., `feat:`, `fix:`, `BREAKING CHANGE:`) to determine version bumps:
  - **Major:** Triggers if a commit includes `BREAKING CHANGE:` or a major marker.
  - **Minor:** Triggers if a commit contains `feat:` (new feature).
  - **Patch:** Triggers if a commit contains `fix:` (bug fix).
  - **No-Op:** Ignores commits that don’t require a version bump.
- **Language‑Agnostic:**  
  No Node.js, npm, or package.json required—just Git history.
- **Simplicity:**  
  Packaged in a Docker container that mounts your repository so vnext can compute the next version effortlessly.

## Usage

### In a GitHub Workflow

Reference the released version of the action in your workflow file:

```yaml
jobs:
  version:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Calculate Next Version
        id: version
        uses: harmony-labs/action-vnext@v1.0.0

      - name: Display Version
        run: echo "Next version is: ${{ steps.version.outputs.version }}"
```

### Using Docker Compose for Local Testing

A `docker-compose.yaml` file is provided to test the action locally. This file mounts your current directory into the container so that vnext can access your Git commit history.

```yaml
version: "3.8"

services:
  vnext:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - ./:/workspace
    working_dir: /workspace
    command: []
```

**To test locally:**

1. Ensure you’re in a Git repository (vnext relies on Git history).
2. Run the following command in your terminal:

   ```bash
   docker compose -f docker-compose.yaml run --rm vnext
   ```

This command builds the image (if not already built) and runs the vnext service, printing the computed version to your terminal.

## Installation

### Using GitHub Releases

This action is automatically built and released via GitHub Actions. Use it in your workflows by referencing the appropriate tag (e.g., `harmony-labs/action-vnext@v1.0.0`).

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

---

This README provides a comprehensive overview of action-vnext, explaining its motivation, features, usage examples, and instructions for local testing and contribution.