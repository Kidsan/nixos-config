# All this file does is import the secrets in the config file and format them 
# in the way that the agenix cli reads secrets.nix
with builtins; let
  config = import ./config.nix;

  nameValuePair = name: value: { inherit name value; };

  filterAttrs = pred: set:
    listToAttrs (concatMap
      (name:
        let
          v = set.${name};
        in
        if pred name v
        then [ (nameValuePair name v) ]
        else [ ])
      (attrNames set));

  collect = pred: attrs:
    if pred attrs
    then [ attrs ]
    else if builtins.isAttrs attrs
    then builtins.concatMap (collect pred) (builtins.attrValues attrs)
    else [ ];

  relPath = path: replaceStrings [ (toString ./.) ] [ "." ] (toString path);

  secretToOutput = attr:
    nameValuePair
      (relPath attr.secret.file)
      {
        publicKeys = attr.secret.publicKeys;
      };

  collectSecrets =
    builtins.listToAttrs
      (builtins.map
        secretToOutput
        (collect
          (x: x ? "secret")
          config));
in
collectSecrets
