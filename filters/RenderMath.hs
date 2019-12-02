#!/usr/bin/env stack
-- stack --resolver lts-14.16 --install-ghc runghc --package pandoc-types --package text
{-# Language OverloadedStrings #-}

import System.Process (readProcess)
import qualified Data.Text as T
import Text.Pandoc.JSON

renderMath :: Inline -> IO Inline
renderMath (Math mathType text) =
  toInline <$> readProcess "/home/delta/.nix-profile/bin/npx" options text
    where
  options = [ "katex", "--no-throw-on-error" ] ++ (case mathType of
    DisplayMath -> [ "--display-mode" ]
    InlineMath ->  [])
  toInline :: String -> Inline
  toInline = RawInline (Format "html")
renderMath x = return x

main :: IO ()
main = toJSONFilter renderMath
