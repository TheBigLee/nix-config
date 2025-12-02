{pkgs,...}:
{
  environment.systemPackages = with pkgs; [
    ollama
  ];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    host = "0.0.0.0";
    port = 11434;
  };
}
