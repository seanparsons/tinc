{-# LANGUAGE CPP #-}
module Tinc.GhcPkgSpec (spec) where

import           Control.Monad
import           System.Environment
import           Helper

import           Tinc.Facts
import           Tinc.GhcPkg
import           Tinc.Package

globalPackages :: [String]
globalPackages = [
    "array"
  , "base"
  , "binary"
#if __GLASGOW_HASKELL__ < 800
  , "bin-package-db"
#endif
  , "bytestring"
  , "Cabal"
  , "containers"
  , "deepseq"
  , "directory"
  , "filepath"
  , "ghc"
  , "ghc-prim"
  , "hoopl"
  , "hpc"
  , "integer-gmp"
  , "pretty"
  , "process"
  , "rts"
  , "template-haskell"
  , "time"
  , "unix"
  , "haskeline"
  , "terminfo"
  , "transformers"
  , "xhtml"
#if __GLASGOW_HASKELL__ < 710
  , "haskell2010"
  , "haskell98"
  , "old-locale"
  , "old-time"
#endif
#if __GLASGOW_HASKELL__ > 710
  , "ghc-boot"
  , "ghc-boot-th"
  , "ghci"
#endif
  ]

spec :: Spec
spec = do
  describe "listGlobalPackages" $ before_ (getExecutablePath >>= useNix >>= (`when` pending)) $ do
    it "lists packages from global package database" $ do
      packages <- listGlobalPackages
      map packageName packages `shouldMatchList` globalPackages
