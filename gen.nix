let thunkSource = (import ./nix-thunk {}).thunkSource;
    pkgs = import ./nixpkgs.nix;
    src = thunkSource ./openmoji;
    openmojiJson = builtins.fromJSON (builtins.readFile (src + "/data/openmoji.json"));
    inherit (pkgs) lib;
    toList = parseSep: renderSep: renderItem: source: lib.concatStringsSep renderSep
      (map (x: ''${renderItem x}'') (lib.splitString parseSep source));
    toListOfText = sep: tags: "[" + toList sep ", " (x: "\"${x}\"") tags + "]";
    haskellModule = builtins.toFile "OpenMoji.hs" ''
      {-# Language OverloadedStrings #-}
      {-|
        Description:
          Generated module containing the OpenMoji emoji set
          as a list of Haskell records.
      -}
      module Text.Emoji.OpenMoji.Data where

      import Text.Emoji.OpenMoji.Types

      -- | All the OpenMoji emojis and their associated metadata
      openmojis :: [OpenMoji]
      openmojis = ${"[\n  " + lib.concatStringsSep "\n  , " (builtins.map (o: ''
          OpenMoji
              { _openMoji_annotation = "${o.annotation}"
              , _openMoji_emoji = "${''\x'' + toList "-" ''\x'' (x: x) o.hexcode}"
              , _openMoji_group = "${o.group}"
              , _openMoji_hexcode = "${o.hexcode}"
              , _openMoji_openmoji_author = "${o.openmoji_author}"
              , _openMoji_openmoji_date = "${o.openmoji_date}"
              , _openMoji_openmoji_tags = ${toListOfText ", " o.openmoji_tags}
              , _openMoji_order = ${if o.order == null || o.order == ""
                then "Nothing"
                else "Just " + builtins.toString o.order}
              , _openMoji_skintone = ${toListOfText "," (builtins.toString o.skintone)}
              , _openMoji_skintone_combination = "${builtins.toString o.skintone_combination}"
              , _openMoji_skintone_base_emoji = "${if builtins.stringLength o.skintone_base_hexcode == 0
                then ""
                else ''\x'' + builtins.toString o.skintone_base_hexcode}"
              , _openMoji_skintone_base_hexcode = "${builtins.toString o.skintone_base_hexcode}"
              , _openMoji_subgroups = "${o.subgroups}"
              , _openMoji_tags = ${toListOfText ", " o.tags}
              , _openMoji_unicode = "${builtins.toString o.unicode}"
              }
        '') openmojiJson) + "\n  ]"}
    '';
in pkgs.stdenv.mkDerivation {
  name = "OpenMoji.hs";
  inherit src;
  dontBuild = true;
  installPhase = ''
    cp -r ${haskellModule} $out
  '';
}
