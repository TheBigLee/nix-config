{

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      compression = true;
      controlMaster = "no";
      controlPersist = "no";
      forwardAgent = false;
      addKeysToAgent = "no" ;
      hashKnownHosts = false;
      userKnownHostsFile = null;
      identitiesOnly = true;
      identityFile = "~/.ssh/id_ed25519_2025";
      extraOptions = {
        "Include" = "sshop_config";
      };
    };
  };

}
