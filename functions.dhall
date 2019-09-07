let s = ./schema.dhall

in  { sharedModule =
          λ(x : s.SimpleModule)
        → s.Module.Shared ({ root = "shared", sources = [ "shared/src" ] } ∧ x)
    , jvmModule =
          λ(x : s.SimpleModule)
        → s.Module.Jvm ({ root = "jvm", sources = [ "jvm/src" ] } ∧ x)
    , nativeModule =
          λ(x : s.SimpleModule ⩓ s.WithNative)
        → s.Module.Native ({ root = "native", sources = [ "native/src" ] } ∧ x)
    , mkJavaDep =
          λ(organisation : Text)
        → λ(artefact : Text)
        → λ(version : Text)
        → s.Dep.Java
          { organisation =
              organisation
          , artefact =
              artefact
          , version =
              version
          }
    , mkScalaDep =
          λ(organisation : Text)
        → λ(artefact : Text)
        → λ(version : Text)
        → s.Dep.Scala
          { organisation =
              organisation
          , artefact =
              artefact
          , version =
              version
          }
    , jvmTestModule =
          λ(x : s.SimpleModule ⩓ s.WithTestFrameworks)
        → s.TestModule.Jvm ({ root = "jvm", sources = [ "jvm/test" ] } ∧ x)
    , nativeTestModule =
          λ(x : s.SimpleModule ⩓ s.WithNative ⩓ s.WithTestFrameworks)
        → s.TestModule.Native
          ({ root = "native", sources = [ "native/test" ] } ∧ x)
    , sharedTestModule =
          λ(x : s.SimpleModule ⩓ s.WithTestFrameworks)
        → s.TestModule.Shared
          ({ root = "shared", sources = [ "shared/test" ] } ∧ x)
    }
