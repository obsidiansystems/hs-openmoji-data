# hs-openmoji-data
[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org) [![Haskell](https://img.shields.io/badge/language-Haskell-orange.svg)](https://haskell.org) [![Hackage](https://img.shields.io/hackage/v/hs-openmoji-data.svg)](https://hackage.haskell.org/package/hs-openmoji-data) [![Hackage CI](https://matrix.hackage.haskell.org/api/v2/packages/hs-openmoji-data/badge)](https://matrix.hackage.haskell.org/#/package/hs-openmoji-data)   [![Github CI](https://github.com/obsidiansystems/hs-openmoji-data/workflows/github-action/badge.svg)](https://github.com/obsidiansystems/hs-openmoji-data/actions) [![BSD3 License](https://img.shields.io/badge/license-BSD3-blue.svg)](https://github.com/obsidiansystems/hs-openmoji-data/blob/master/LICENSE)


The OpenMoji emoji dataset for use in Haskell programs.

For emoji fonts, images, and spritesheets, please consult the documentation [openmoji.org](https://openmoji.org/).

## Updating the emojis

Use [nix-thunk](https://github.com/obsidiansystems/nix-thunk) to update the pinned version of openmoji and then use the generator script to produce a new `Data.hs` file:

```bash
nix-thunk update ./openmoji
./gen.sh
```

## Versioning

Versions of this package should correspond to the OpenMoji version number used to generate the data.
