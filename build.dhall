let schema = ./schema.dhall

let f = ./functions.dhall

let dependencies =
      { betterFiles =
          f.mkScalaDep "com.github.pathikrit" "better-files" "3.8.0"
      , imageIoJpeg =
          f.mkJavaDep "com.twelvemonkeys.imageio" "imageio-jpeg" "3.4.2"
      , imageIoCore =
          f.mkJavaDep "com.twelvemonkeys.imageio" "imageio-core" "3.4.2"
      , miniTest =
          f.mkScalaDep "io.monix" "minitest" "2.6.0"
      }

let shared = { scalaVersion = "2.13.0", deps = [] : List schema.Dep }

let jvm = shared

let native = shared ⫽ { scalaVersion = "2.11.12", scalaNativeVersion = "0.3.9" }

let test =
      { testFrameworks =
          [ "minitest.runner.Framework" ]
      , deps =
          [ dependencies.miniTest ]
      }

let example =
      { main =
          [ f.sharedModule shared
          , f.jvmModule
            (   jvm
              ⫽ { deps =
                    [ dependencies.betterFiles
                    , dependencies.imageIoJpeg
                    , dependencies.imageIoCore
                    ]
                }
            )
          , f.nativeModule native
          ]
      , test =
          [ f.sharedTestModule (shared ⫽ test)
          , f.jvmTestModule (jvm ⫽ test)
          , f.nativeTestModule (native ⫽ test)
          ]
      }

in  { project = {=}, modules = { example = example } }
