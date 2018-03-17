{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}

module Servant.Streaming.Example (main) where

import qualified Data.ByteString as BS
import           Control.Lens
import           Control.Monad.Trans.AWS  (runResourceT, runAWST, Region(..))
import           Network.AWS
import           Network.AWS.Data.Body (RsBody(..))
import           Network.AWS.S3
import           Control.Monad.Trans.Resource (ResourceT(..), MonadResource)
import Data.Conduit                       (($$+-), ResumableSource(..))
import Data.Conduit.List                  as CL
import Servant
import Network.Wai.Handler.Warp           (run)

import           Servant.Streaming.Server
import           Streaming                hiding (run)
import qualified Streaming.Prelude        as S


type API = "getfile" :> StreamResponseGet '[OctetStream]

server :: Server API
server =  do
  env <- newEnv Discover
  runAWST env conduits

conduits :: (MonadAWS m, MonadResource m) => m (S.Stream (Of BS.ByteString) (ResourceT IO) ())
conduits = do
  let bucketName = BucketName "test"
      key = ObjectKey "foobar"
  rs <- send (getObject bucketName key)
  let (RsBody body) = view gorsBody rs
  return $ hoist lift body $$+- CL.mapM_ S.yield


api :: Proxy API
api = Proxy

app1 :: Application
app1 = serve api server

main :: IO ()
main = do
    putStrLn "serving on 8081"
    run 8081 app1
