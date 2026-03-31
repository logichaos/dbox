# distrobox config

A reproducible distrobox setup that can be carried over to other machines.

## Usage

```bash
./setup.sh
```

This assembles both containers via `distrobox.ini`, then runs post-setup verification and exports.

Exported binaries land in `~/.local/bin` — make sure it's in your `PATH`.

## Containers

### System

- description: common utilities container
- packages:
    - neovim
    - lazygit (using copr dejan/lazygit)
    - jujutsu scm (installed via cargo)
    - yazi file manager
    - nwg-displays (using copr tofik/nwg-shell)
- exported to host:
    - neovim
    - lazygit
    - jujutsu scm (jj)
    - yazi file manager
    - nwg-displays (desktop app)

### Development

- description: all development tools (except GUI IDEs, which are installed as flatpaks)
- packages:
    - dotnet sdk 10
    - dotnet sdk 11 (preview, via install script)
    - aspire workload
    - azure functions core tools
    - golang tools
    - npm
    - typescript
    - python

## File Structure

```
distrobox.ini          # declarative container definitions
setup.sh               # main entry point
scripts/
  setup-system.sh      # post-setup verification & app exports for system container
  setup-dev.sh         # post-setup verification for dev container
```
