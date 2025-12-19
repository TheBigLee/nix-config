{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  # Enable Docker for paperless-ai
  virtualisation.docker = {
    enable = true;
  };
  
  # Create systemd service for paperless-ai
  systemd.services.paperless-ai = {
    description = "Paperless-AI extension";
    after = ["docker.service"];
    wantedBy = ["multi-user.target"];
    
    serviceConfig = {
      Type = "exec";
      ExecStartPre = [
        "${pkgs.docker}/bin/docker pull clusterzx/paperless-ai"
      ];
      ExecStart = "${pkgs.docker}/bin/docker run --rm --name paperless-ai --add-host=host.docker.internal:host-gateway --network bridge -v paperless-ai_data:/app/data -p 3000:3000 clusterzx/paperless-ai";
      ExecStop = "${pkgs.docker}/bin/docker stop paperless-ai";
      Restart = "always";
      RestartSec = 10;
    };
  };
  
  # Open firewall ports
  networking.firewall.allowedTCPPorts = [ 28981 3000 11434 ];
  
  # Install Docker
  environment.systemPackages = with pkgs; [
    docker
  ];
}
