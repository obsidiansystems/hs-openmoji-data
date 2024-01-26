hs-openmoji-data
================
[![Built with Nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://nixos.org) [![Haskell](https://img.shields.io/badge/language-Haskell-orange.svg)](https://haskell.org) [![Hackage](https://img.shields.io/hackage/v/hs-openmoji-data.svg)](https://hackage.haskell.org/package/hs-openmoji-data)   [![Github CI](https://github.com/obsidiansystems/hs-openmoji-data/workflows/github-action/badge.svg)](https://github.com/obsidiansystems/hs-openmoji-data/actions) [![BSD3 License](https://img.shields.io/badge/license-BSD3-blue.svg)](https://github.com/obsidiansystems/hs-openmoji-data/blob/master/LICENSE)


The OpenMoji emoji dataset for use in Haskell programs.

For emoji fonts, images, and spritesheets, please consult the documentation at [openmoji.org](https://openmoji.org/).


* [Updating the emojis](#updating-the-emojis)
* [Versioning](#versioning)
* [Example Usage](#example-usage)
* [About the Emojis](#about-the-emojis)

Updating the emojis
-------------------

Use [nix-thunk](https://github.com/obsidiansystems/nix-thunk) to update the pinned version of openmoji and then use the generator script to produce a new `Data.hs` file:

```bash
nix-thunk update ./openmoji
./gen.sh
```

Versioning
-------------------

Versions of this package should correspond to the OpenMoji version number used to generate the data.

Example Usage
-------------------

```haskell

> {-# Language LambdaCase #-}
> {-# Language OverloadedStrings #-}
>
> import Control.Monad
> import Data.Map (Map)
> import qualified Data.Map as Map
> import Data.Text (Text)
> import qualified Data.Text as T
> import System.Environment
> import Text.Emoji (emojiFromAlias)
> import Text.Emoji.OpenMoji.Data
> import Text.Emoji.OpenMoji.Types
>
> emojiMap :: Map Text OpenMoji
> emojiMap = Map.fromList $ map (\x -> (_openMoji_emoji x, x)) openmojis
> 
> main :: IO ()
> main = do
>   requestedAliases <- getArgs
>   when (null requestedAliases) $
>     putStrLn "Please search for at least one emoji alias (e.g., \"bricks\")"
>   forM_ requestedAliases $ \alias ->
>     case (\e -> Map.lookup e emojiMap) =<< emojiFromAlias (T.pack alias) of
>       Nothing -> putStrLn $ "Results for '" <> alias <> "': None"
>       Just openmoji -> do
>         putStrLn $ "Results for '" <> alias <> "':"
>         printOpenMojiInfo openmoji
>
> versionedSvg :: Text -> Text -> Text
> versionedSvg rev hex = mconcat
>   [ "https://raw.githubusercontent.com/hfg-gmuend/openmoji/"
>   , rev
>   , "/color/svg/"
>   , hex
>   , ".svg"
>   ]
>
> pinnedRevision :: Text
> pinnedRevision = "4a80b536eb62a78822548a2aa371426f912d7e9d" -- v13
>
> printOpenMojiInfo :: OpenMoji -> IO ()
> printOpenMojiInfo o = putStrLn $ T.unpack $ T.unlines
>   [ "Emoji:      " <> _openMoji_emoji o
>   , "Hexcode:    " <> _openMoji_hexcode o
>   , "Annotation: " <> _openMoji_annotation o
>   , "Group:      " <> _openMoji_group o
>   , "Sub-Group:  " <> _openMoji_subgroups o
>   , "Tags:       " <> T.intercalate ", " (_openMoji_tags o)
>   , "SVG:        " <> versionedSvg pinnedRevision (_openMoji_hexcode o)
>   ]

```

This program will do something like the following:

```
Results for 'bricks':
Emoji:      🧱
Hexcode:    1F9F1
Annotation: brick
Group:      travel-places
Sub-Group:  place-building
Tags:       bricks, clay, mortar, wall
SVG:        https://raw.githubusercontent.com/hfg-gmuend/openmoji/4a80b536eb62a78822548a2aa371426f912d7e9d/color/svg/1F9F1.svg

Results for 'pilot':
Emoji:      🧑‍✈️
Hexcode:    1F9D1-200D-2708-FE0F
Annotation: pilot
Group:      people-body
Sub-Group:  person-role
Tags:       plane
SVG:        https://raw.githubusercontent.com/hfg-gmuend/openmoji/4a80b536eb62a78822548a2aa371426f912d7e9d/color/svg/1F9D1-200D-2708-FE0F.svg
```

About the Emojis
-------------------

All emojis designed by OpenMoji – the open-source emoji and icon project. License: CC BY-SA 4.0
