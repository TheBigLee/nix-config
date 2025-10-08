{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "kubectl-split-config";
  version = "v0.0.3";
  cargoHash = "sha256-A2+5nWEZwKPPbo4XqfNftHdb07rFkAdIwH8lFyeuLnA=";

  src = fetchFromGitHub {
    repo = "kubectl-split-config";
    owner = "simu";
    rev = version;
    sha256 = "1b0qdgxn0m9c7d607777zk3i35prlpgj8dgxh4rahlsp007b84w2";
  };

  meta = with lib; {
    description = "Kubectl plugin which can split a Kubeconfig file into separate files for each context.";
    homepage = "https://github.com/simu/kubectl-split-config";
    licence = licenses.bsd3;
    maintainers = [];
    mainProgram = "kubectl-split-config";
  };
}