Example of servant-streaming and amazonka

Run:

    stack build --exec servant-streaming-example-exe

Results into:

```haskell
error:
    * No instance for (MonadAWS
                         (Control.Monad.Trans.AWS.AWST' Env Handle
r))                                                                       arising from a use of `conduits'
    * In the second argument of `runAWST', namely `conduits'
      In a stmt of a 'do' block: runAWST env conduits         
      In the expression:
        do env <- newEnv Discover
           runAWST env conduits                               
   |    
29 |   runAWST env conduits
   |               ^^^^^^^^
```
