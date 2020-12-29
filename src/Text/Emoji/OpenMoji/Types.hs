{-# Language DeriveGeneric #-}
{-|
 Description:
   Types corresponding to OpenMoji's raw JSON data format.
-}
module Text.Emoji.OpenMoji.Types where
import Data.Text (Text)
import GHC.Generics (Generic)

-- | This record corresponds to the json format used in the OpenMoji dataset.
-- For example:
--
-- @
-- {
--     "emoji": "🖐️",
--     "hexcode": "1F590",
--     "group": "people-body",
--     "subgroups": "hand-fingers-open",
--     "annotation": "hand with fingers splayed",
--     "tags": "finger, hand, splayed",
--     "openmoji_tags": "Five Hand, Hand, Five, Splayed",
--     "openmoji_author": "Julian Grüneberg",
--     "openmoji_date": "2018-04-18",
--     "skintone": "",
--     "skintone_combination": "single",
--     "skintone_base_emoji": "🖐️",
--     "skintone_base_hexcode": "1F590",
--     "unicode": 0.7,
--     "order": 176
--   }
-- @
data OpenMoji = OpenMoji
  { _openMoji_annotation :: Text
  , _openMoji_emoji :: Text
  , _openMoji_group :: Text
  , _openMoji_hexcode :: Text
  , _openMoji_openmoji_author :: Text
  , _openMoji_openmoji_date :: Text
  , _openMoji_openmoji_tags :: [Text]
  , _openMoji_order :: Maybe Int
  , _openMoji_skintone :: [Text]
  , _openMoji_skintone_base_emoji :: Text
  , _openMoji_skintone_base_hexcode :: Text
  , _openMoji_skintone_combination :: Text
  , _openMoji_subgroups :: Text
  , _openMoji_tags :: [Text]
  , _openMoji_unicode :: Text
  }
  deriving (Read, Show, Eq, Ord, Generic)
