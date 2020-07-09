{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_coercible (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/praveen/haskell/joyofhaskell/coercible/.stack-work/install/x86_64-linux/a55ff18c9ae07272b2cd9a2aafe99288a47745fa879f5d936a6f3c27493b440a/8.8.3/bin"
libdir     = "/home/praveen/haskell/joyofhaskell/coercible/.stack-work/install/x86_64-linux/a55ff18c9ae07272b2cd9a2aafe99288a47745fa879f5d936a6f3c27493b440a/8.8.3/lib/x86_64-linux-ghc-8.8.3/coercible-0.1.0.0-2AkEjDAdXPWJDR7c7ce2P6-coercible"
dynlibdir  = "/home/praveen/haskell/joyofhaskell/coercible/.stack-work/install/x86_64-linux/a55ff18c9ae07272b2cd9a2aafe99288a47745fa879f5d936a6f3c27493b440a/8.8.3/lib/x86_64-linux-ghc-8.8.3"
datadir    = "/home/praveen/haskell/joyofhaskell/coercible/.stack-work/install/x86_64-linux/a55ff18c9ae07272b2cd9a2aafe99288a47745fa879f5d936a6f3c27493b440a/8.8.3/share/x86_64-linux-ghc-8.8.3/coercible-0.1.0.0"
libexecdir = "/home/praveen/haskell/joyofhaskell/coercible/.stack-work/install/x86_64-linux/a55ff18c9ae07272b2cd9a2aafe99288a47745fa879f5d936a6f3c27493b440a/8.8.3/libexec/x86_64-linux-ghc-8.8.3/coercible-0.1.0.0"
sysconfdir = "/home/praveen/haskell/joyofhaskell/coercible/.stack-work/install/x86_64-linux/a55ff18c9ae07272b2cd9a2aafe99288a47745fa879f5d936a6f3c27493b440a/8.8.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "coercible_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "coercible_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "coercible_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "coercible_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "coercible_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "coercible_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
