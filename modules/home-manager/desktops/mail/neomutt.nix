{ inputs, config, lib, pkgs, ... }:

let
  mailAccounts = inputs.nix-secrets.mail;
  mailDir = config.accounts.email.maildirBasePath;

  mkMailAccount = name: attrs: {
    primary = attrs.primary or false;
    address = attrs.address;
    userName = attrs.userName;
    realName = attrs.realName;

    imap = {
      host = attrs.imap.host;
      port = attrs.imap.port;
      tls.enable = true;
    };

    smtp = {
      host = attrs.smtp.host;
      port = attrs.smtp.port;
      tls.enable = true;
      tls.useStartTls = true;
    };

    passwordCommand = "cat ${config.sops.secrets."mail/${name}/password".path}";

    mbsync = {
      enable = true;
      create = "both";
      expunge = "both";
      patterns = [ "*" ];
    };

    msmtp.enable = true;
    notmuch.enable = true;

    neomutt = {
      enable = true;
      extraMailboxes = [ "Sent" "Drafts" "Trash" "Junk" "Archive" ];
    };

    signature = {
      showSignature = if attrs.signature != "" then "append" else "none";
      text = attrs.signature;
    };
  };

  accountNames = lib.attrNames mailAccounts;

  # Mailbox subdirs that neomutt expects to exist
  mailboxDirs = [ "Inbox" "Sent" "Drafts" "Trash" "Junk" "Archive" ];

  # Generate macro to switch to account N using <number> key
  accountSwitchMacros = lib.concatStringsSep "\n" (lib.imap1 (i: name:
    ''macro index,pager <f${toString i}> "<change-folder>${mailDir}/${name}/Inbox<enter>" "Switch to ${name}"''
  ) accountNames);
in
{
  sops.secrets = lib.mapAttrs' (name: _:
    lib.nameValuePair "mail/${name}/password" { }
  ) mailAccounts;

  accounts.email.accounts = lib.mapAttrs mkMailAccount mailAccounts;

  # Pre-create maildir folders so neomutt doesn't error on missing mailboxes
  home.activation.createMaildirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${lib.concatStringsSep "\n" (lib.concatMap (name:
      map (dir: "mkdir -p ${mailDir}/${name}/${dir}/{cur,new,tmp}") mailboxDirs
    ) accountNames)}
  '';

  programs.mbsync.enable = true;

  programs.msmtp.enable = true;

  programs.notmuch = {
    enable = true;
    hooks.preNew = "mbsync --all";
  };

  programs.neomutt = {
    enable = true;
    vimKeys = true;
    sort = "threads";
    sidebar = {
      enable = true;
      width = 30;
    };
    settings = {
      sort_aux = "reverse-last-date-received";
      mailcap_path = "${config.home.homeDirectory}/.mailcap";
      mail_check_stats = "yes";
    };
    binds = [
      { map = [ "index" "pager" ]; key = "\\Cj"; action = "sidebar-next"; }
      { map = [ "index" "pager" ]; key = "\\Ck"; action = "sidebar-prev"; }
      { map = [ "index" "pager" ]; key = "\\Co"; action = "sidebar-open"; }
      { map = [ "index" ]; key = "gg"; action = "first-entry"; }
      { map = [ "index" ]; key = "G"; action = "last-entry"; }
      { map = [ "pager" ]; key = "gg"; action = "top"; }
      { map = [ "pager" ]; key = "G"; action = "bottom"; }
    ];
    macros = [
      { map = [ "index" ]; key = "O"; action = "<shell-escape>mbsync --all && notmuch new<enter>"; }
      { map = [ "index" ]; key = "\\\\"; action = "<vfolder-from-query>"; }
    ];
    extraConfig = ''
      # Index format with year in date
      set index_format="%4C %zs%zc%zt %{%Y-%m-%d %H:%M} %-15.15L (%?l?%4l&%4c?) %s"

      # Editor
      set editor = "nvim"

      # HTML email rendering
      auto_view text/html
      alternative_order text/plain text/enriched text/html

      # Account switching
      ${accountSwitchMacros}

      # Gruvbox Dark color scheme
      # bg0=color235, bg1=color237, bg2=color239
      # fg0=color223, fg1=color223, fg2=color250
      # red=color124, green=color106, yellow=color172, blue=color66
      # purple=color132, aqua=color72, orange=color166, gray=color245

      # General
      color normal        color223 default
      color indicator     color235 color172
      color tree          color106 default
      color status        color223 color237
      color error         color124 default
      color message       color106 default
      color signature     color245 default
      color attachment    color172 default
      color search        color235 color172
      color tilde         color239 default
      color markers       color124 default
      color hdrdefault    color245 default
      color prompt        color172 default

      # Header highlights
      color header        color172 default "^From:"
      color header        color106 default "^Subject:"
      color header        color72  default "^To:"
      color header        color72  default "^Cc:"
      color header        color66  default "^Date:"

      # Index — message list
      color index         color172 default "~N"
      color index         color172 default "~U"
      color index         color245 default "~R"
      color index         color124 default "~D"
      color index         color132 default "~F"
      color index         color66  default "~T"
      color index         color239 default "~v~(!~N)"
      color index         color172 default "~v~(~N)"

      # Quoted text in replies
      color quoted        color106 default
      color quoted1       color72  default
      color quoted2       color132 default
      color quoted3       color66  default
      color quoted4       color245 default

      # URL and email highlighting
      color body          color66  default "(https?|ftp)://[^ \t\n\">]+"
      color body          color72  default "[-a-z_0-9.]+@[-a-z_0-9.]+"
      color body          color172 default "[*][-a-z0-9_. ]+[*]"
      color body          color172 default "[-a-z_0-9.]+@[-a-z_0-9.]+"

      # Sidebar
      color sidebar_new       color172 default
      color sidebar_unread    color223 default
      color sidebar_highlight color235 color172
      color sidebar_indicator color235 color106
      color sidebar_divider   color239 default
      color sidebar_ordinary  color245 default
    '';
  };

  services.mbsync = {
    enable = true;
    frequency = "*:0/5";
    postExec = "${pkgs.notmuch}/bin/notmuch new";
  };

  home.file.".mailcap".text = ''
    text/html; ${pkgs.w3m}/bin/w3m -I %{charset} -T text/html; copiousoutput;
  '';

  home.packages = with pkgs; [
    w3m
  ];
}
