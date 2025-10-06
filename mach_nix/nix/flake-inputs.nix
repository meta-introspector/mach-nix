with builtins;

let
  lock = (fromJSON (readFile ../flake.lock)).nodes;
  get = input: {
    inherit (lock."${input}".locked) rev;
    sha256 = lock."${input}".locked.narHash;
  };
in
 get
