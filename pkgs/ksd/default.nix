{ buildGoModule, fetchFromGitHub, lib }:
buildGoModule rec {
  pname = "ksd";
  version = "1.0.8";

  src = fetchFromGitHub {
    owner = "mfuentesg";
    repo = "ksd";
    rev = "v${version}";
    sha256 = "1am9slkhifzyjn6b7g4rm5kxi7q4sns4vbvmzlcs26ib9m8h2pwf";
  };

  vendorHash = "sha256-eoz8vkqUqyYPXZtnN9UENcWG+lsnYYeqxPX6coXMhis=";

  meta = with lib; {
    description = "Kubernetes secret decoder - decode base64 secret values in yaml/json output";
    homepage = "https://github.com/mfuentesg/ksd";
    license = licenses.mit;
    mainProgram = "ksd";
  };
}
