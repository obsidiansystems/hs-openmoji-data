# hs-openmoji-data

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
