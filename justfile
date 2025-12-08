SOPS_FILE := "../nix-secrets/.sops.yaml"

# Define path to helpers
export HELPERS_PATH := justfile_directory() + "/scripts/helpers.sh"

# default recipe to display help information
default:
  @just --list

# Update commonly changing flakes and prep for a rebuild
rebuild-pre: update-nix-secrets
  @git add --intent-to-add .

# Run post-rebuild checks, like if sops is running properly afterwards
rebuild-post: check-sops

# Run a flake check on the config and installer
check ARGS="":
	NIXPKGS_ALLOW_UNFREE=1 REPO_PATH=$(pwd) nix flake check --impure --keep-going --show-trace {{ARGS}}

# Rebuild the system
rebuild: rebuild-pre && rebuild-post
  # NOTE: Add --option eval-cache false if you end up caching a failure you can't get around
  scripts/rebuild.sh

# Rebuild the system and run a flake check
rebuild-full: rebuild-pre && rebuild-post
  scripts/rebuild.sh
  just check

# Rebuild the system and run a flake check
rebuild-trace: rebuild-pre && rebuild-post
  scripts/rebuild.sh trace
  just check

# Update the flake
update:
  nix flake update

# Update and then rebuild
rebuild-update: update rebuild

# Git diff there entire repo expcept for flake.lock
diff:
  git diff ':!flake.lock'

# Generate a new age key
age-key:
  nix-shell -p age --run "age-keygen"

# Check if sops-nix activated successfully
check-sops:
  scripts/check-sops.sh

# Update nix-secrets flake
update-nix-secrets:
  @(cd ../nix-secrets && git fetch && git rebase > /dev/null) || true
  nix flake update nix-secrets --timeout 5

# Called by the rekey recipe
sops-rekey:
  cd ../nix-secrets \
    sops updatekeys -y secrets.yaml \
  done

# Update all keys in sops/*.yaml files in nix-secrets to match the creation rules keys
rekey: sops-rekey
  cd ../nix-secrets && \
    (pre-commit run --all-files || true) && \
    git add -u && (git commit -nm "chore: rekey" || true) && git push
