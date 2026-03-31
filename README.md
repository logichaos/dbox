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
    - btop (system monitor)
    - atop (system-wide performance monitor)
    - yazi file manager
    - superfile (file manager)
    - lazyjournal (journalctl TUI)
    - git-delta (diff pager)
    - nwg-displays (using copr tofik/nwg-shell)
- exported to host:
    - neovim
    - lazygit
    - jujutsu scm (jj)
    - yazi file manager
    - superfile (spf)
    - lazyjournal
    - git-delta (delta)
    - btop
    - atop
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
    - posting (API client TUI, installed via pipx)
- exported to host:
    - posting

## File Structure

```
distrobox.ini              # declarative container definitions
setup.sh                   # main entry point
scripts/
  rebuild-containers.sh    # rebuild one or both containers (system|dev|all)
  setup-system.sh          # post-setup verification for system container
  setup-dev.sh             # post-setup verification for dev container
  install-lazyjournal.sh   # lazyjournal install script (called during system init)
```
