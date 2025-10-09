let
  devDirectory = "~/dev";
  devNix = "${devDirectory}/nix";
in
{
  # Overrides those provided by OMZ libs, plugins, and themes.
  # For a full list of active aliases, run `alias`.

  #-------------Bat related------------
  cat = "bat --paging=never";
  diff = "batdiff";
  rg = "batgrep";
  man = "batman";

  #------------Navigation------------
  clr = "clear";
  rst = "reset";
  doc = "cd $HOME/documents";
  dev = "cd $HOME/dev";
  work = "cd $HOME/dev/vshn";
  l = "eza -lah";
  la = "eza -lah";
  ll = "eza -lh";
  ls = "eza";
  lsa = "eza -lah";

  #------------Nix src navigation------------
  cnc = "cd ${devNix}/nix-config";
  cns = "cd ${devNix}/nix-secrets";

  #-----------Nix commands----------------
  nfc = "nix flake check";
  ne = "nix instantiate --eval";
  nb = "nix build";
  ns = "nix shell";

  #-------------justfiles---------------
  jr = "just rebuild";
  jrt = "just rebuild-trace";
  jl = "just --list";
  jc = "$just check";
  jct = "$just check-trace";

  #-------------Neovim---------------
  e = "nvim";
  vi = "nvim";
  vim = "nvim";

  #-------------Kubernetes------------
  kubectl = "kubecolor";
  k = "kubectl";
  pctl = "cli";

  #-------------SSH---------------
  ssh = "TERM=xterm ssh";

  #-------------rmtrash---------------
  # Path to real rm and rmdir in coreutils. This is so we can not use rmtrash for big files
  rrm = "/run/current-system/sw/bin/rm";
  rrmdir = "/run/current-system/sw/bin/rmdir";
  rm = "rmtrash";
  rmdir = "rmdirtrash";

  #-------------Git Goodness-------------
  # just reference `$ alias` and use the defaults, they're good.
}
