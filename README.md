Example of servant-streaming and amazonka

Run:

    stack build --exec servant-streaming-example-exe

Results into:

```haskell
    src/Servant/Streaming/Example.hs:29:3: error:
        * No instance for (MonadResource Handler)
            arising from a use of `runAWS'
        * In a stmt of a 'do' block: runAWS env conduits
          In the expression:
            do env <- newEnv Discover
               runAWS env conduits
          In an equation for `server':
              server
                = do env <- newEnv Discover
                     runAWS env conduits
       |
    29 |   runAWS env conduits
       |   ^^^^^^^^^^^^^^^^^^^
```
