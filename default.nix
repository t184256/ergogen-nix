{ lib, buildNpmPackage, nodejs_18, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "ergogen";
  version = "4.1.0";
  nodejs = nodejs_18;

  src = fetchFromGitHub {
    owner = "ergogen";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Y4Ri5nLxbQ78LvyGARPxsvoZ9gSMxY14QuxZJg6Cu3Y=";
  };

  npmDepsHash = "sha256-BQbf/2lWLYnrSjwWjDo6QceFyR+J/vhDcVgCaytGfl0=";
  forceGitDeps = true;
  makeCacheWritable = true;

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];
  npmFlags = [ "--legacy-peer-deps" ];

  NODE_OPTIONS = "--openssl-legacy-provider";

  meta = {
    description = "Ergonomic keyboard layout generator";
    homepage = "https://ergogen.xyz";
    license = lib.licenses.mit;
  };
}
